import 'package:dis_app/models/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddCartItemEvent extends CartEvent {
  final String photoId;

  const AddCartItemEvent(this.photoId);

  @override
  List<Object> get props => [photoId];
}

class RemoveCartItem extends CartEvent {
  final String photoId;

  const RemoveCartItem({required this.photoId});

  @override
  List<Object> get props => [photoId];
}

class ListCartItem extends CartEvent {
  final int? page;
  final int? size;

  const ListCartItem({this.page, this.size});

  @override
  List<Object?> get props => [page, size];
}

class SelectCartItem extends CartEvent {
  final Cart cart;
  final bool isSelected;

  const SelectCartItem({required this.cart, required this.isSelected});

  @override
  List<Object> get props => [cart, isSelected];
}

class SelectAllCartItem extends CartEvent {
  final bool isSelected;

  const SelectAllCartItem({required this.isSelected});

  @override
  List<Object> get props => [isSelected];
}