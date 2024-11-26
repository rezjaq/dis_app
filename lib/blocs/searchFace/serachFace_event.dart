import 'package:equatable/equatable.dart';

abstract class SearchFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeCameraEvent extends SearchFaceEvent {}

class CapturePhotoEvent extends SearchFaceEvent {}
