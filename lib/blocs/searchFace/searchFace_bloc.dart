import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dis_app/blocs/face/face_bloc.dart';
import 'package:dis_app/blocs/face/face_event.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'package:dis_app/pages/findme/DisplayPhotoScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchFaceBloc extends Bloc<SearchFaceEvent, SearchFaceState> {
  final FaceController _faceController;
  late CameraController _controller;
  bool _isInitialized = false;
  bool _isReloadingCamera = false;

  CameraController get controller => _controller;

  SearchFaceBloc(this._faceController) : super(SearchFaceInitial()) {
    on<CapturePhotoEvent>(_onCapturePhoto);
    on<SearchMatchedPhotosEvent>(_onSearchMatchedPhotos);
    on<UploadFaceEvent>(_onUploadFace);
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

        if (photo.path.isEmpty) {
          emit(SearchFaceNoPhotoFound(message: "Foto wajah tidak ditemukan"));
          return;
        }

        emit(SearchFacePhotoCaptured(imagePath: imagePath));

        final FaceBloc faceBloc = BlocProvider.of<FaceBloc>(event.context);
        faceBloc.add(FaceDetectionEvent(file: photo));

        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => DisplayPhotoScreen(imagePath: imagePath),
          ),
        ).then((_) {
          BlocProvider.of<SearchFaceBloc>(event.context)
              .add(InitializeCameraEvent());
        });
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
        emit(SearchFaceNoFaceDetected(message: "Wajah tidak terdeteksi"));
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

  @override
  Future<void> close() {
    if (_isInitialized) {
      _controller.dispose();
    }
    return super.close();
  }
}
