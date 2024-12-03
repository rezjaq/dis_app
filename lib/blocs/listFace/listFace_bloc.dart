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
      //contoh saja
      final photos = [
        MatchedPhoto(
          id: '1',
          url: 'https://example.com/similar_face1.jpg',
          userId: 'user1',
        ),
        MatchedPhoto(
          id: '2',
          url: 'https://example.com/similar_face2.jpg',
          userId: 'user1',
        ),
        MatchedPhoto(
          id: '3',
          url: 'https://example.com/similar_face3.jpg',
          userId: 'user1',
        ),
        MatchedPhoto(
          id: '4',
          url: 'https://example.com/similar_face4.jpg',
          userId: 'user1',
        ),
      ];
      emit(ListFaceLoaded(photos));
    } catch (e) {
      emit(ListFaceError("Failed to load similar photos."));
    }
  }

  void _onAddSelfiePhoto(AddSelfiePhoto event, Emitter<ListFaceState> emit) {
    if (state is ListFaceLoaded) {
      final currentState = state as ListFaceLoaded;
      final updatedPhotos = List<MatchedPhoto>.from(currentState.similarPhotos)
        ..add(MatchedPhoto(
          id: 'new_id',
          url: event.newPhotoPath,
          userId: 'user1',
        ));
      emit(ListFaceLoaded(updatedPhotos));
    }
  }

  void _onClearListFace(ClearListFace event, Emitter<ListFaceState> emit) {
    emit(ListFaceLoading()); // Reset ke loading atau initial state
  }
}
