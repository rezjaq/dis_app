import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_event.dart';
import 'package:dis_app/blocs/displayPhoto/displayPhoto_state.dart';

class DisplayPhotoBloc extends Bloc<DisplayPhotoEvent, DisplayPhotoState> {
  DisplayPhotoBloc() : super(DisplayPhotoInitialState(imagePath: '')) {
    on<RetakePhotoEvent>((event, emit) {
      print("Event received: $event");
      emit(DisplayPhotoInitialState(imagePath: ''));
    });

    on<SavePhotoEvent>((event, emit) async {
      emit(DisplayPhotoSavingState());
      try {
        await Future.delayed(Duration(seconds: 2));
        emit(DisplayPhotoSavedState(savedPath: event.photoPath));
      } catch (e) {
        emit(DisplayPhotoErrorState(errorMessage: e.toString()));
      }
    });
  }
}
