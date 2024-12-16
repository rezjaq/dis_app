import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dis_app/blocs/searchFace/searchFace_state.dart';
import 'package:dis_app/blocs/searchFace/serachFace_event.dart';
import 'package:dis_app/controllers/face_controller.dart';

class SearchFaceBloc extends Bloc<SearchFaceEvent, SearchFaceState> {
  final FaceController _faceController;

  SearchFaceBloc(this._faceController) : super(SearchFaceInitial()) {
    on<SearchMatchedPhotosEvent>(_onSearchMatchedPhotos);
  }

  Future<void> _onSearchMatchedPhotos(
      SearchMatchedPhotosEvent event, Emitter<SearchFaceState> emit) async {
    emit(SearchFaceLoading());
    try {
      final matchedFaces = await _faceController.listFaces(event.userId);
      if (matchedFaces.isNotEmpty) {
        final List<String> matchedPhotoUrls =
            matchedFaces.map((face) => face.url).toList();
        emit(SearchFaceMatchedPhotosLoaded(matchedPhotos: matchedPhotoUrls));
      } else {
        emit(SearchFaceNoMatchFound());
      }
    } catch (e) {
      emit(SearchFaceError(message: e.toString()));
    }
  }
}
