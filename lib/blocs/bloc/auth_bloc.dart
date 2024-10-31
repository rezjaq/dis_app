import 'package:dis_app/blocs/event/auth_event.dart';
import 'package:dis_app/blocs/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      yield AuthLoading();

      try {
        // Simulate network request
        await Future.delayed(Duration(seconds: 2));
        yield AuthAuthenticated();
      } catch (e) {
        yield AuthError(e.toString());
      }
    }
  }
}