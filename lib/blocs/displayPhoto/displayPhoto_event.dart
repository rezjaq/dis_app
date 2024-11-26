import 'package:equatable/equatable.dart';

abstract class DisplayPhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RetakePhotoEvent extends DisplayPhotoEvent {}

class SavePhotoEvent extends DisplayPhotoEvent {
  final String photoPath;
  SavePhotoEvent({required this.photoPath});
}
