import 'package:dis_app/models/withdraw_model.dart';
import 'package:equatable/equatable.dart';

abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object> get props => [];
}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoading extends WithdrawState {}

class WithdrawSuccess<T> extends WithdrawState {
  final String message;
  final T data;

  const WithdrawSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, if (data is Object) data as Object else data.toString()];
}

class WithdrawListSuccess extends WithdrawState {
  final String message;
  final List<Withdraw> data;

  const WithdrawListSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}

class WithdrawFailure extends WithdrawState {
  final String message;

  const WithdrawFailure({required this.message});

  @override
  List<Object> get props => [message];
}