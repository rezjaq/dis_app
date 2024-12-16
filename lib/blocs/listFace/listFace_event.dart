import 'package:equatable/equatable.dart';

abstract class ListFaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSimilarPhotos extends ListFaceEvent {
  final String userId;
  LoadSimilarPhotos(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ClearListFace extends ListFaceEvent {}
