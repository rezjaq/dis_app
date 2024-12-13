import 'package:dis_app/blocs/face/face_event.dart';
import 'package:dis_app/blocs/face/face_state.dart';
import 'package:dis_app/controllers/face_controller.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceBloc extends Bloc<FaceEvent, FaceState> {
  final FaceController faceController;

  FaceBloc({required this.faceController}) : super(FaceInitial()) {
    on<FaceDetectionEvent>((event, emit) async {
      emit(FaceLoading());
      try {
        final response = await faceController
            .faceDetection(FaceDetectionRequest(file: event.file));
        emit(FaceSuccess(data: response));
      } catch (e) {
        emit(FaceFailure(message: e.toString()));
      }
    });
  }
}
