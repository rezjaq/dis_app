import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final String? message;
  final Map<String, dynamic>? data;

  const TransactionSuccess({this.message, this.data});

  @override
  List<Object> get props => [
    message ?? '',
    data ?? {},
  ];
}

class TransactionFailure extends TransactionState {
  final String message;

  const TransactionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class TransactionGetSuccess extends TransactionState {
  final String? message;
  final Map<String, dynamic>? data;

  const TransactionGetSuccess({this.message, this.data});

  @override
  List<Object> get props => [
    message ?? '',
    data ?? {},
  ];
}