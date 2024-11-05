import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetEvent extends UserEvent {
  const UserGetEvent();
}

class UserUpdateEvent extends UserEvent {
  final String name;
  final String email;
  final String phone;

  const UserUpdateEvent({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [name, email, phone];
}

class UserChangePasswordEvent extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UserChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];
}

class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();
}