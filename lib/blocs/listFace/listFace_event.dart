import 'package:equatable/equatable.dart';

abstract class ListFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSimilarPhotos extends ListFaceEvent {}

class AddSelfiePhoto extends ListFaceEvent {
  final String newPhotoPath;

  AddSelfiePhoto(this.newPhotoPath);

  @override
  List<Object?> get props => [newPhotoPath];
}

class ClearListFace extends ListFaceEvent {}
