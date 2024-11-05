import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserController userController;

  UserBloc({required this.userController}) : super(UserInitial()) {
    on<UserGetEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.get();
        emit(UserSuccess(message: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserUpdateEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.update(UpdateUserRequest(
          name: event.name,
          email: event.email,
          phone: event.phone,
        ));
        emit(UserSuccess(message: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserChangePasswordEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.changePassword(ChangePasswordRequest(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword,
        ));
        emit(UserSuccess(message: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserLogoutEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.logout();
        emit(UserSuccess(message: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });
  }
}