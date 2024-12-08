import 'package:dis_app/models/transaction_model.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class TransactionCreateEvent extends TransactionEvent {
  final List<Detail> details;
  final double total;

  const TransactionCreateEvent({
    required this.details,
    required this.total,
  });

  @override
  List<Object> get props => [details, total];
}

class TransactionListByBuyerEvent extends TransactionEvent {
  final int? page;
  final int? size;

  const TransactionListByBuyerEvent({
    this.page,
    this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class TransactionListBySellerEvent extends TransactionEvent {
  final int? page;
  final int? size;

  const TransactionListBySellerEvent({
    this.page,
    this.size,
  });

  @override
  List<Object?> get props => [page, size];
}