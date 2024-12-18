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
        add(FindmePhotoEvent());
        add(ListPhotoEvent(page: 1, size: 10));
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
      Map<String, dynamic>? responseAll;
      Map<String, dynamic>? responseCollections;
      Map<String, dynamic>? responseFavorites;
      String? messageAll;
      String? messageCollections;

      try {
        responseAll = await photoController.findmePhoto();
      } catch (e) {
        messageAll = e.toString();
      }

      try {
        responseCollections =
            await photoController.collectionPhoto(CollectionPhotoRequest());
      } catch (e) {
        messageCollections = e.toString();
      }

      emit(FindmeSuccess(
        all: responseAll,
        collections: responseCollections,
        favorites: {"data": []},
        messageAll: messageAll,
        messageCollections: messageCollections,
        messageFavorites: null,
      ));
    });

    on<AddToFavoritesEvent>((event, emit) {
      if (state is FindmeSuccess) {
        final currentState = state as FindmeSuccess;

        // Ambil data favorites saat ini dan tambahkan data baru
        final updatedFavorites = List<Map<String, dynamic>>.from(
          currentState.favorites?["data"] ?? [],
        )..add({"url": event.imageUrl});

        // Emit state baru dengan data favorites yang diperbarui
        emit(FindmeSuccess(
          all: currentState.all,
          collections: currentState.collections,
          favorites: {"data": updatedFavorites},
          messageAll: currentState.messageAll,
          messageCollections: currentState.messageCollections,
          messageFavorites: currentState.messageFavorites,
        ));
      }
    });
  }
}
