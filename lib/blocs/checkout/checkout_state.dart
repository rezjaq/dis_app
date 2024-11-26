import 'package:dis_app/models/chart_model.dart';
import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final List<CartItem> cartItems;

  const CheckoutState({required this.cartItems});

  CheckoutState copyWith({List<CartItem>? cartItems}) {
    return CheckoutState(cartItems: cartItems ?? this.cartItems);
  }

  @override
  List<Object> get props => [cartItems];
}
