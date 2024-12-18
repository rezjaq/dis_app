import 'package:dis_app/models/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final String? message;
  final Map<String, dynamic>? data;
  final Set<Cart> selectedItems;
  final List<bool> isSelected;

  const CartSuccess(
      {this.message,
      this.data,
      this.selectedItems = const <Cart>{},
      this.isSelected = const <bool>[]});

  @override
  List<Object> get props => [
        message ?? '',
        data ?? {},
        selectedItems,
        isSelected,
      ];
}

class CartFailure extends CartState {
  final String message;

  const CartFailure({required this.message});

  @override
  List<Object> get props => [message];
}
