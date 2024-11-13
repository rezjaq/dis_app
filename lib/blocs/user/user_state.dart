import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final String? message;
  final Map<String, dynamic>? data;

  const UserSuccess({this.message, this.data});

  @override
  List<Object> get props => [
    message ?? '',
    data ?? {},
  ];
}

class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object> get props => [message];
}