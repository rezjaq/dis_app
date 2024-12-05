import 'package:dis_app/models/chart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartEvent {}

class SelectCartItem extends CartEvent {
  final int index;
  final bool isSelected;

  const SelectCartItem(this.index, this.isSelected);

  @override
  List<Object> get props => [index, isSelected];
}

class SelectAllCartItems extends CartEvent {
  final bool selectAll;

  const SelectAllCartItems(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class RemoveCartItem extends CartEvent {
  final int index;

  const RemoveCartItem(this.index);

  @override
  List<Object> get props => [index];
}

class AddCartItem extends CartEvent {
  final CartItem cartItem;

  const AddCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class ListCartItem extends CartEvent {
  final List<CartItem> cartItems;

  const ListCartItem(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}