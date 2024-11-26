import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:path_provider/path_provider.dart';

class SearchFaceBloc extends Bloc<SearchFaceEvent, SearchFaceState> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isInitialized = false;

  SearchFaceBloc() : super(SearchFaceInitial()) {
    on<InitializeCameraEvent>(_onInitializeCamera);
    on<CapturePhotoEvent>(_onCapturePhoto);
  }

  CameraController get controller => _controller;

  Future<void> _onInitializeCamera(
      InitializeCameraEvent event, Emitter<SearchFaceState> emit) async {
    if (_isInitialized) {
      emit(SearchFaceLoaded(controller: _controller));
      return;
    }

    emit(SearchFaceLoading());
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
      _controller = CameraController(frontCamera, ResolutionPreset.high);
      await _controller.initialize();
      _isInitialized = true;
      emit(SearchFaceLoaded(controller: _controller));
    } catch (e) {
      emit(SearchFaceError(message: e.toString()));
    }
  }

  Future<void> _onCapturePhoto(
      CapturePhotoEvent event, Emitter<SearchFaceState> emit) async {
    try {
      if (_controller.value.isInitialized) {
        final XFile photo = await _controller.takePicture();
        final directory = await getApplicationDocumentsDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final imagePath = '${directory.path}/aligned_face_photo_$timestamp.jpg';

        await photo.saveTo(imagePath);
        emit(SearchFacePhotoCaptured(imagePath: imagePath));
      } else {
        emit(SearchFaceError(message: "Camera not initialized"));
      }
    } catch (e) {
      emit(SearchFaceError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
