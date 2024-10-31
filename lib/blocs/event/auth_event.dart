import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;

  RegisterEvent(this.name, this.email, this.password, this.confirmPassword, this.phone);

  @override
  List<Object> get props => [name, email, password, confirmPassword, phone];
}