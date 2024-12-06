import 'package:equatable/equatable.dart';

abstract class SearchFaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFaceInitial extends SearchFaceState {}

class SearchFaceLoading extends SearchFaceState {}

class SearchFaceCameraInitialized extends SearchFaceState {}

class SearchFacePhotoCaptured extends SearchFaceState {
  final String imagePath;

  SearchFacePhotoCaptured({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class SearchFaceMatchedPhotosLoaded extends SearchFaceState {
  final List<String> matchedPhotos;

  SearchFaceMatchedPhotosLoaded({required this.matchedPhotos});

  @override
  List<Object?> get props => [matchedPhotos];
}

class SearchFaceNoMatchFound extends SearchFaceState {}

class SearchFaceUploaded extends SearchFaceState {}

class SearchFaceError extends SearchFaceState {
  final String message;

  SearchFaceError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SearchFaceNoFaceDetected extends SearchFaceState {
  final String message;

  SearchFaceNoFaceDetected({required this.message});

  @override
  List<Object?> get props => [message];
}

class SearchFaceNoPhotoFound extends SearchFaceState {
  final String message;

  SearchFaceNoPhotoFound({required this.message});

  @override
  List<Object?> get props => [message];
}
