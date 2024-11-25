import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetEvent extends UserEvent {
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

class AddBankEvent extends UserEvent {
  final String bank;
  final String name;
  final String number;

  const AddBankEvent({
    required this.bank,
    required this.name,
    required this.number,
  });

  @override
  List<Object> get props => [bank, name, number];
}

class ListBankEvent extends UserEvent {
  const ListBankEvent();
}

class GetBankEvent extends UserEvent {
  final String id;

  const GetBankEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UpdateBankEvent extends UserEvent {
  final String id;
  final String bank;
  final String name;
  final String number;

  const UpdateBankEvent({
    required this.id,
    required this.bank,
    required this.name,
    required this.number,
  });

  @override
  List<Object> get props => [id, bank, name, number];
}

class DeleteBankEvent extends UserEvent {
  final String id;

  const DeleteBankEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}