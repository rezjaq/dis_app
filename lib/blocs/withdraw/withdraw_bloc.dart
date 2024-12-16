import 'package:dis_app/blocs/withdraw/withdraw_event.dart';
import 'package:dis_app/blocs/withdraw/withdraw_state.dart';
import 'package:dis_app/controllers/withdraw_controller.dart';
import 'package:dis_app/models/withdraw_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final WithdrawController withdrawController;

  WithdrawBloc({required this.withdrawController}) : super(WithdrawInitial()) {
    on<WithdrawCreateEvent>((event, emit) async {
      emit(WithdrawLoading());
      try {
        final response = await withdrawController.create(WithdrawCreateRequest(
          bankId: event.bankId,
          amount: event.amount,
        ));
        emit(WithdrawSuccess(message: "Withdrawal created successfully", data: response));
      } catch (e) {
        emit(WithdrawFailure(message: e.toString()));
      }
    });
  }
}