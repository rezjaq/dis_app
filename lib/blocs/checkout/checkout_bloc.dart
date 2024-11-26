import 'package:dis_app/blocs/checkout/checkout_event.dart';
import 'package:dis_app/blocs/checkout/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutState(cartItems: [])) {
    on<LoadCheckoutItems>(_onLoadCheckoutItems);
  }

  void _onLoadCheckoutItems(
      LoadCheckoutItems event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(cartItems: event.selectedItems));
  }
}
