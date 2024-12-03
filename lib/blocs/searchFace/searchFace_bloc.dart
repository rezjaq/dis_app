import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'searchFace_state.dart';
import 'serachFace_event.dart';

class SearchFaceBloc extends Bloc<SearchFaceEvent, SearchFaceState> {
  late CameraController _controller;
  final FaceController _faceController;

  SearchFaceBloc(this._faceController) : super(SearchFaceInitial()) {
    on<InitializeCameraEvent>(_onInitializeCamera);
    on<CapturePhotoEvent>(_onCapturePhoto);
    on<SearchMatchedPhotosEvent>(_onSearchMatchedPhotos);
  }

  Future<void> _onInitializeCamera(
      InitializeCameraEvent event, Emitter<SearchFaceState> emit) async {
    emit(SearchFaceLoading());
    try {
      final cameras = await availableCameras();

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => throw CameraException(
          'CAMERA_NOT_FOUND',
          'Kamera depan tidak ditemukan',
        ),
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller.initialize();
      emit(SearchFaceLoaded(controller: _controller));
    } catch (e) {
      emit(SearchFaceError(message: 'Gagal menginisialisasi kamera: $e'));
    }
  }

  Future<void> _onCapturePhoto(
      CapturePhotoEvent event, Emitter<SearchFaceState> emit) async {
    if (!_controller.value.isInitialized) {
      emit(SearchFaceError(message: 'CameraController belum diinisialisasi.'));
      return;
    }

    try {
      final XFile photo = await _controller.takePicture();
      emit(SearchFacePhotoCaptured(imagePath: photo.path));
    } catch (e) {
      emit(SearchFaceError(message: 'Gagal mengambil foto: $e'));
    }
  }

  Future<void> _onSearchMatchedPhotos(
      SearchMatchedPhotosEvent event, Emitter<SearchFaceState> emit) async {
    try {
      emit(SearchFaceLoading());
      final matchedPhotos =
          await _faceController.getMatchedPhotos(event.userId);

      if (matchedPhotos.isEmpty) {
        emit(SearchFaceNoMatchFound());
      } else {
        emit(SearchFaceMatchedPhotosLoaded(matchedPhotos: matchedPhotos));
      }
    } catch (e) {
      emit(SearchFaceError(message: 'Gagal mencari foto yang cocok: $e'));
    }
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
