import 'package:equatable/equatable.dart';

abstract class SearchFaceEvent extends Equatable {
  const SearchFaceEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends SearchFaceEvent {}

class CapturePhotoEvent extends SearchFaceEvent {}

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
