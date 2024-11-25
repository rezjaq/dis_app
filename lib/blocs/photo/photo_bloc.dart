import 'package:dis_app/blocs/photo/photo_event.dart';
import 'package:dis_app/blocs/photo/photo_state.dart';
import 'package:dis_app/controllers/photo_controller.dart';
import 'package:dis_app/models/photo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoController photoController;

  PhotoBloc({required this.photoController}) : super(PhotoInitial()) {
    on<AddSellPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.addSellPhoto(AddSellPhotoRequest(
            name: event.name,
            basePrice: event.basePrice.toString(),
            sellPrice: event.sellPrice.toString(),
            description: event.description,
            file: event.file
        ));
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
            file: event.file
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<GetPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.get(GetPhotoRequest(
            id: event.id
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<ListPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.list(ListPhotoRequest(
            type: event.type,
            page: event.page,
            size: event.size
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });

    on<UpdateSellPhotoEvent>((event, emit) async {
      emit(PhotoLoading());
      try {
        final response = await photoController.updateSell(UpdateSellPhotoRequest(
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
        final response = await photoController.updatePost(UpdatePostPhotoRequest(
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
        final response = await photoController.likePost(LikePhotoPostRequest(
            id: event.id,
            liked: event.liked // true or false, You can change this value on icon button love
        ));
        emit(PhotoSuccess(data: response));
      } catch (e) {
        emit(PhotoFailure(message: e.toString()));
      }
    });
  }
}