import 'package:dis_app/blocs/photo/photo_event.dart';
import 'package:dis_app/blocs/photo/photo_state.dart';
import 'package:dis_app/controllers/photo_controller.dart';
import 'package:dis_app/models/photo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoController photoController;
  // List<String> _favorites = [];

  PhotoBloc({required this.photoController}) : super(PhotoInitial()) {
    on<AddSellPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.addSellPhoto(AddSellPhotoRequest(
            name: event.name,
            basePrice: event.basePrice.toString(),
            sellPrice: event.sellPrice.toString(),
            description: event.description,
            file: event.file));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<AddPostPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.addPostPhoto(AddPostPhotoRequest(
            name: event.name,
            description: event.description,
            file: event.file));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<GetPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response =
            await photoController.get(GetPhotoRequest(id: event.id));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<ListPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final responseSell = await photoController.list(
            ListPhotoRequest(type: "sell", page: event.page, size: event.size));
        final responsePost = await photoController.list(
            ListPhotoRequest(type: "post", page: event.page, size: event.size));
        emit(PhotoByAccountSuccess(sell: responseSell, post: responsePost));
      } catch (e) {
        emit(PhotoByAccountFailure(
            messageSell: e.toString(), messagePost: e.toString()));
      }
    });

    on<UpdateSellPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response =
            await photoController.updateSell(UpdateSellPhotoRequest(
          id: event.id,
          name: event.name,
          basePrice: event.basePrice.toString(),
          sellPrice: event.sellPrice.toString(),
          description: event.description,
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<UpdatePostPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response =
            await photoController.updatePost(UpdatePostPhotoRequest(
          id: event.id,
          name: event.name,
          description: event.description,
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<LikePhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        await photoController.likePost(LikePhotoPostRequest(
          id: event.id,
          liked: event.liked,
        ));
        final updatedPhoto =
            await photoController.get(GetPhotoRequest(id: event.id));
        emit(PhotoSuccess(data: updatedPhoto));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<SamplePhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.samplePost();
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<FindmePhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final responseAll = await photoController.findmePhoto();
        final responseCollections =
            await photoController.collectionPhoto(CollectionPhotoRequest());
        final favorites = <dynamic>[];

        emit(FindmeSuccess(
          all: responseAll,
          collections: responseCollections,
          favorites: favorites,
        ));
      } catch (e) {
        emit(FindmeFailure(
            messageAll: e.toString(), messageCollections: e.toString()));
      }
    });

    on<AddToFavoritesEvent>((event, emit) {
      if (state is FindmeSuccess) {
        final currentState = state as FindmeSuccess;
        final updatedFavorites =
            List<dynamic>.from(currentState.favorites ?? [])
              ..add(event.imageUrl);
        final updatedAll = Map<String, dynamic>.from(currentState.all ?? {})
          ..remove(event.imageUrl);

        emit(FindmeSuccess(
          all: updatedAll,
          collections: currentState.collections,
          favorites: updatedFavorites,
        ));
      }
    });
  }
}
