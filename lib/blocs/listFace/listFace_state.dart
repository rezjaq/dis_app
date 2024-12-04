import 'package:dis_app/models/face_model.dart';
import 'package:equatable/equatable.dart';

abstract class ListFaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListFaceLoading extends ListFaceState {}

class ListFaceLoaded extends ListFaceState {
  final List<Face> similarFaces;

  ListFaceLoaded(this.similarFaces);

  @override
  List<Object?> get props => [similarFaces];
}

class ListFaceError extends ListFaceState {
  final String message;

  ListFaceError(this.message);

  @override
  List<Object?> get props => [message];
}
