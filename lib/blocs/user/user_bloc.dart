import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/models/user_model.dart';
import 'package:dis_app/utils/local_storage/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserController userController;

  UserBloc({required this.userController}) : super(UserInitial()) {
    on<UserGetEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.get();
        print("Response: $response");
        emit(UserSuccess(data: response));
      } catch (e) {
        print(e);
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
        emit(UserSuccess(message: "Profile updated successfully", data: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserChangePasswordEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response =
            await userController.changePassword(ChangePasswordRequest(
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
        if (response['data'] != true) {
          throw response['errors'];
        } else {
          DisLocalStorage().removeData('access_token');
          emit(UserSuccess(message: response['data']));
        }
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<AddBankEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.addAccount(AddAccountRequest(
          bank: event.bank,
          name: event.name,
          number: event.number,
        ));
        emit(UserSuccess(message: "Bank account added successfully", data: response['data']));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<ListBankEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.listAccount(ListAccountRequest());
        print(response);
        emit(UserSuccess(data: response));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<GetBankEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.getAccount(GetAccountRequest(id: event.id));
        emit(UserSuccess(data: response));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UpdateBankEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.updateAccount(UpdateAccountRequest(
          id: event.id,
          bank: event.bank,
          name: event.name,
          number: event.number,
        ));
        emit(UserSuccess(message: "Bank account updated successfully", data: response));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<DeleteBankEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await userController.deleteAccount(DeleteAccountRequest(id: event.id));
        emit(UserSuccess(message: "Bank account deleted successfully", data: response));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserChangeProfileEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final requestBody = ChangeProfileRequest(
          name: event.name,
          email: event.email,
          phone: event.phone,
          username: event.username,
        );
        final response = await userController
            .update(requestBody.toJson() as UpdateUserRequest);
        if (response['success'] == true) {
          emit(UserSuccess(
              message: response['message'] ?? "Profile updated successfully!"));
        } else {
          emit(UserFailure(
              message: response['message'] ?? "Failed to update profile."));
        }
      } catch (e) {
        emit(UserFailure(message: "An error occurred: ${e.toString()}"));
      }
    });
  }
}