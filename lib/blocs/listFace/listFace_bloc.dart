import 'package:dis_app/blocs/listFace/listFace_event.dart';
import 'package:dis_app/blocs/listFace/listFace_state.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFaceBloc extends Bloc<ListFaceEvent, ListFaceState> {
  ListFaceBloc() : super(ListFaceLoading()) {
    on<LoadSimilarPhotos>(_onLoadSimilarPhotos);
    on<AddSelfiePhoto>(_onAddSelfiePhoto);
    on<ClearListFace>(_onClearListFace);
  }

  Future<void> _onLoadSimilarPhotos(
      LoadSimilarPhotos event, Emitter<ListFaceState> emit) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final faces = [
        Face(
          id: '1',
          url: 'https://example.com/similar1.jpg',
          userId: 'user1',
          detections: [],
        ),
        Face(
          id: '2',
          url: 'https://example.com/similar2.jpg',
          userId: 'user2',
          detections: [],
        ),
      ];
      emit(ListFaceLoaded(faces));
    } catch (e) {
      emit(ListFaceError("Error loading photos."));
    }
  }

  void _onAddSelfiePhoto(AddSelfiePhoto event, Emitter<ListFaceState> emit) {
    if (state is ListFaceLoaded) {
      final currentState = state as ListFaceLoaded;
      final updatedFaces = List<Face>.from(currentState.similarFaces)
        ..add(Face(
          id: 'new_id',
          url: event.newPhotoPath,
          userId: 'new_user',
          detections: [],
        ));
      emit(ListFaceLoaded(updatedFaces));
    }
  }

  void _onClearListFace(ClearListFace event, Emitter<ListFaceState> emit) {
    emit(ListFaceLoading());
  }
}
