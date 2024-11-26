import 'package:dis_app/blocs/listFace/listFace_event.dart';
import 'package:dis_app/blocs/listFace/listFace_state.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFaceBloc extends Bloc<ListFaceEvent, ListFaceState> {
  ListFaceBloc() : super(ListFaceLoading()) {
    on<LoadSimilarPhotos>(_onLoadSimilarPhotos);
    on<AddSelfiePhoto>(_onAddSelfiePhoto);
    on<ClearListFace>(_onClearListFace); // Tambahkan handler ini
  }

  Future<void> _onLoadSimilarPhotos(
      LoadSimilarPhotos event, Emitter<ListFaceState> emit) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final photos = [
        // Contoh file saja
        PhotoModel(imagePath: 'assets/images/similar_face1.jpg'),
        PhotoModel(imagePath: 'assets/images/similar_face2.jpg'),
        PhotoModel(imagePath: 'assets/images/similar_face3.jpg'),
        PhotoModel(imagePath: 'assets/images/similar_face4.jpg'),
      ];
      emit(ListFaceLoaded(photos));
    } catch (e) {
      emit(ListFaceError("Failed to load similar photos."));
    }
  }

  void _onAddSelfiePhoto(AddSelfiePhoto event, Emitter<ListFaceState> emit) {
    if (state is ListFaceLoaded) {
      final currentState = state as ListFaceLoaded;
      final updatedPhotos = List<PhotoModel>.from(currentState.similarPhotos)
        ..add(PhotoModel(imagePath: event.newPhotoPath));
      emit(ListFaceLoaded(updatedPhotos));
    }
  }

  // Handler baru untuk ClearListFace
  void _onClearListFace(ClearListFace event, Emitter<ListFaceState> emit) {
    emit(ListFaceLoading()); // Reset ke loading atau initial state
  }
}
