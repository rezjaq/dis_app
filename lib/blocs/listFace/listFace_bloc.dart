import 'package:dis_app/blocs/listFace/listFace_event.dart';
import 'package:dis_app/blocs/listFace/listFace_state.dart';
import 'package:dis_app/models/face_model.dart';
import 'package:dis_app/utils/http/http_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFaceBloc extends Bloc<ListFaceEvent, ListFaceState> {
  ListFaceBloc() : super(ListFaceLoading()) {
    on<LoadSimilarPhotos>(_onLoadSimilarPhotos);
    on<ClearListFace>(_onClearListFace);
  }

  Future<void> _onLoadSimilarPhotos(
      LoadSimilarPhotos event, Emitter<ListFaceState> emit) async {
    emit(ListFaceLoading());
    try {
      final response = await DisHttpClient.findMe(event.userId);
      final faces = (response['data'] as List)
          .map((json) => Face.fromJson(json))
          .toList();
      emit(ListFaceLoaded(faces));
    } catch (e) {
      emit(ListFaceError("Failed to load faces: $e"));
    }
  }

  void _onClearListFace(ClearListFace event, Emitter<ListFaceState> emit) {
    emit(ListFaceLoading());
  }
}
