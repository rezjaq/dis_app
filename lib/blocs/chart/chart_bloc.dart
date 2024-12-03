import 'package:dis_app/models/chart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dis_app/controllers/cart_controller.dart';
import 'package:dis_app/models/cart_model.dart';
import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/chart/chart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: [], selectedItems: [])) {
    on<LoadCartItems>(_onLoadCartItems);
    on<SelectCartItem>(_onSelectCartItem);
    on<SelectAllCartItems>(_onSelectAllCartItems);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<AddCartItem>(_onAddCartItem);
  }

  void _onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) async {
    try {
      final cartItems = await CartController().getCartItemsFromFindMe();
      final selectedItems = List<bool>.filled(cartItems.length, false);
      emit(CartState(cartItems: cartItems, selectedItems: selectedItems));
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  void _onAddCartItem(AddCartItem event, Emitter<CartState> emit) {
    final updatedCartItems = List<CartItem>.from(state.cartItems)
      ..add(event.cartItem);
    final updatedSelectedItems = List<bool>.from(state.selectedItems)
      ..add(false);

    emit(state.copyWith(
      cartItems: updatedCartItems,
      selectedItems: updatedSelectedItems,
    ));
  }

  void _onSelectCartItem(SelectCartItem event, Emitter<CartState> emit) {
    final updatedSelectedItems = List<bool>.from(state.selectedItems);
    updatedSelectedItems[event.index] = event.isSelected;

    emit(state.copyWith(selectedItems: updatedSelectedItems));
  }

  void _onSelectAllCartItems(
      SelectAllCartItems event, Emitter<CartState> emit) {
    final updatedSelectedItems =
        List<bool>.filled(state.cartItems.length, event.selectAll);

    emit(state.copyWith(selectedItems: updatedSelectedItems));
  }

  void _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) {
    final updatedCartItems = List<CartItem>.from(state.cartItems)
      ..removeAt(event.index);
    final updatedSelectedItems = List<bool>.from(state.selectedItems)
      ..removeAt(event.index);

    emit(state.copyWith(
        cartItems: updatedCartItems, selectedItems: updatedSelectedItems));
  }
}
