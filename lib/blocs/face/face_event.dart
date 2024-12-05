import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class FaceEvent extends Equatable {
  const FaceEvent();

  @override
  List<Object?> get props => [];
}

class FaceDetectionEvent extends FaceEvent {
  final XFile file;

  const FaceDetectionEvent({
    required this.file,
  });

  @override
  List<Object> get props => [file];
}
