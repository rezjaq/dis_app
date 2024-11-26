import 'package:dis_app/models/chart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final List<bool> selectedItems;

  const CartState({required this.cartItems, required this.selectedItems});

  CartState copyWith({List<CartItem>? cartItems, List<bool>? selectedItems}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }

  int get totalPrice {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) total += cartItems[i].price;
    }
    return total;
  }

  @override
  List<Object> get props => [cartItems, selectedItems];
}
