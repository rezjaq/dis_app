import 'package:dis_app/blocs/transaction/transaction_event.dart';
import 'package:dis_app/blocs/transaction/transaction_state.dart';
import 'package:dis_app/controllers/transaction_controller.dart';
import 'package:dis_app/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionController transactionController;

  TransactionBloc({required this.transactionController}) : super(TransactionInitial()) {
    on<TransactionCreateEvent>((event, emit) async {
      emit(TransactionLoading());
      try {
        final response = await transactionController.createTransaction(CreateTransactionRequest(
            details: event.details, total: event.total
        ));
        emit(TransactionSuccess(data: response));
      } catch (e) {
        emit(TransactionFailure(message: e.toString()));
      }
    });

    on<TransactionListByBuyerEvent>((event, emit) async {
      emit(TransactionLoading());
      try {
        final response = await transactionController.listByBuyer(ListTransactionRequest(
            page: event.page, size: event.size
        ));
        emit(TransactionSuccess(data: response));
      } catch (e) {
        emit(TransactionFailure(message: e.toString()));
      }
    });

    on<TransactionListBySellerEvent>((event, emit) async {
      emit(TransactionLoading());
      try {
        final response = await transactionController.listBySeller(ListTransactionRequest(
            page: event.page, size: event.size
        ));
        emit(TransactionSuccess(data: response));
      } catch (e) {
        emit(TransactionFailure(message: e.toString()));
      }
    });
  }
}