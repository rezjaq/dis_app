import 'package:dis_app/blocs/auth/auth_event.dart';
import 'package:dis_app/blocs/auth/auth_state.dart';
import 'package:dis_app/controllers/auth_controller.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthController authController;

  AuthBloc({required this.authController}) : super(AuthInitial()) {
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authController.register(RegisterUserRequest(
          name: event.name,
          email: event.email,
          password: event.password,
          phone: event.phone,
        ));
        emit(AuthSuccess(message: "User registered successfully"));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authController.login(LoginUserRequest(
          emailOrPhone: event.emailOrPhone,
          password: event.password,
        ));
        emit(AuthSuccess(message: "Login successful"));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<AuthChangeProfileEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authController.changeProfile(
          ChangeProfileRequest(
            name: event.name,
            email: event.email,
            phone: event.phone,
            username: event.username,
          ),
        );
        emit(AuthSuccess(
          message: response['message'] ?? 'Profile updated successfully',
        ));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });
  }
}
