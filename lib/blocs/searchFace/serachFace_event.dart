import 'package:camera/src/camera_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchFaceEvent extends Equatable {
  const SearchFaceEvent();

  @override
  List<Object> get props => [];
}

class CapturePhotoEvent extends SearchFaceEvent {
  final BuildContext context;

  const CapturePhotoEvent(
      {required this.context, required CameraController controller});

  @override
  List<Object> get props => [context];

  get controller => null;
}

class UploadFaceEvent extends SearchFaceEvent {
  final String userId;
  final String filePath;

  const UploadFaceEvent({required this.userId, required this.filePath});

  @override
  List<Object> get props => [userId, filePath];
}

class SearchMatchedPhotosEvent extends SearchFaceEvent {
  final String userId;

  const SearchMatchedPhotosEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CloseCameraEvent extends SearchFaceEvent {}

class InitializeCameraEvent extends SearchFaceEvent {}
