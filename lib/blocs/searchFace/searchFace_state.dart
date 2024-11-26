import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class SearchFaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFaceInitial extends SearchFaceState {}

class SearchFaceLoading extends SearchFaceState {}

class SearchFaceLoaded extends SearchFaceState {
  final CameraController controller;
  SearchFaceLoaded({required this.controller});

  @override
  List<Object?> get props => [controller];
}

class SearchFacePhotoCaptured extends SearchFaceState {
  final String imagePath;
  SearchFacePhotoCaptured({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class SearchFaceError extends SearchFaceState {
  final String message;
  SearchFaceError({required this.message});

  @override
  List<Object?> get props => [message];
}
