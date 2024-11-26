import 'package:equatable/equatable.dart';

abstract class DisplayPhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DisplayPhotoInitialState extends DisplayPhotoState {
  final String imagePath;
  DisplayPhotoInitialState({required this.imagePath});
}

class DisplayPhotoSavingState extends DisplayPhotoState {}

class DisplayPhotoSavedState extends DisplayPhotoState {
  final String savedPath;
  DisplayPhotoSavedState({required this.savedPath});
}

class DisplayPhotoErrorState extends DisplayPhotoState {
  final String errorMessage;
  DisplayPhotoErrorState({required this.errorMessage});
}
