import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'package:path_provider/path_provider.dart';

class SearchFaceBloc extends Bloc<SearchFaceEvent, SearchFaceState> {
  final FaceController _faceController;
  late CameraController _controller;
  bool _isInitialized = false;

  SearchFaceBloc(this._faceController) : super(SearchFaceInitial()) {
    on<InitializeCameraEvent>(_onInitializeCamera);
    on<CapturePhotoEvent>(_onCapturePhoto);
    on<SearchMatchedPhotosEvent>(_onSearchMatchedPhotos);
    on<UploadFaceEvent>(_onUploadFace);
    on<CloseCameraEvent>(_onCloseCamera);
  }

  Future<void> _onInitializeCamera(
      InitializeCameraEvent event, Emitter<SearchFaceState> emit) async {
    emit(SearchFaceLoading());
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => throw Exception("Kamera depan tidak ditemukan"),
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller.initialize();
      _isInitialized = true;
      emit(SearchFaceLoaded(controller: _controller));
    } catch (e) {
      emit(SearchFaceError(
        message: "Gagal memulai kamera depan: ${e.toString()}",
      ));
    }
  }

  Future<void> _onCapturePhoto(
      CapturePhotoEvent event, Emitter<SearchFaceState> emit) async {
    try {
      if (_isInitialized && _controller.value.isInitialized) {
        final XFile photo = await _controller.takePicture();
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            '${directory.path}/face_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await photo.saveTo(imagePath);
        emit(SearchFacePhotoCaptured(imagePath: imagePath));
      } else {
        emit(SearchFaceError(message: "Camera not initialized"));
      }
    } catch (e) {
      emit(
          SearchFaceError(message: "Failed to capture photo: ${e.toString()}"));
    }
  }

  Future<void> _onUploadFace(
      UploadFaceEvent event, Emitter<SearchFaceState> emit) async {
    emit(SearchFaceLoading());
    try {
      final response =
          await _faceController.addFace(event.userId, event.filePath);
      if (response.detections.isEmpty) {
        emit(SearchFaceNoFaceDetected());
      } else {
        emit(SearchFaceUploaded());
      }
    } catch (e) {
      emit(SearchFaceError(message: e.toString()));
    }
  }

  Future<void> _onSearchMatchedPhotos(
      SearchMatchedPhotosEvent event, Emitter<SearchFaceState> emit) async {
    emit(SearchFaceLoading());
    try {
      final matchedFaces = await _faceController.listFaces(event.userId);
      if (matchedFaces.isNotEmpty) {
        final List<String> matchedPhotoUrls =
            matchedFaces.map((face) => face.url).toList();
        emit(SearchFaceMatchedPhotosLoaded(matchedPhotos: matchedPhotoUrls));
      } else {
        emit(SearchFaceNoMatchFound());
      }
    } catch (e) {
      emit(SearchFaceError(message: e.toString()));
    }
  }

  Future<void> _onCloseCamera(
      CloseCameraEvent event, Emitter<SearchFaceState> emit) async {
    if (_isInitialized) {
      await _controller.dispose();
      _isInitialized = false;
    }
  }
}
