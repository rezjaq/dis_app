import 'package:equatable/equatable.dart';

abstract class WithdrawEvent extends Equatable {
  const WithdrawEvent();

  @override
  List<Object> get props => [];
}

class WithdrawCreateEvent extends WithdrawEvent {
  final String bankId;
  final double amount;

  const WithdrawCreateEvent({
    required this.bankId,
    required this.amount,
  });

  @override
  List<Object> get props => [bankId, amount];
}