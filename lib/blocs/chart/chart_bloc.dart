import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/chart/chart_state.dart';
import 'package:dis_app/models/chart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartState(
          cartItems: [
            CartItem("dsc22466.JPG", "photographer01", 15000,
                "assets/images/profile_2.jpg"),
            CartItem("dsc76543.JPG", "photographer_jatim", 20000,
                "assets/images/profile_2.jpg"),
            CartItem("img_7652.JPG", "photographer01", 15000,
                "assets/images/profile_2.jpg"),
            CartItem("img_9087.JPG", "photographer01", 15000,
                "assets/images/profile_2.jpg"),
            CartItem("img_0097.JPG", "photographer01", 15000,
                "assets/images/profile_2.jpg"),
            CartItem("img_1239.JPG", "photographer01", 15000,
                "assets/images/profile_2.jpg"),
          ],
          selectedItems: List<bool>.filled(6, false),
        )) {
    on<LoadCartItems>(_onLoadCartItems);
    on<SelectCartItem>(_onSelectCartItem);
    on<SelectAllCartItems>(_onSelectAllCartItems);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  void _onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) {
    emit(state);
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
