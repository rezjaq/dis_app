import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/chart/chart_state.dart';
import 'package:dis_app/controllers/cart_controller.dart';
import 'package:dis_app/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartController cartController;

  CartBloc({required this.cartController}) : super(CartInitial()) {
    on<AddCartItemEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await cartController.addToCart(AddItemRequest(photoId: event.photoId));
        emit(CartSuccess(data: response));
      } catch (e) {
        emit(CartFailure(message: e.toString()));
      }
    });

    on<RemoveCartItem>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await cartController.removeFromCart(RemoveItemRequest(photoId: event.photoId));
        if (response == true) {
          final updatedResponse = await cartController.listCartItems(ListItemsRequest(size: 10, page: 1));
          emit(CartSuccess(data: updatedResponse));
        } else {
          emit(CartFailure(message: "Failed to remove item"));
        }
      } catch (e) {
        emit(CartFailure(message: e.toString()));
      }
    });

    on<ListCartItem>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await cartController.listCartItems(ListItemsRequest(
          size: event.size,
          page: event.page,
        ));
        emit(CartSuccess(data: response));
      } catch (e) {
        emit(CartFailure(message: e.toString()));
      }
    });

    on<SelectAllCartItem>((event, emit) async {
      if (state is CartSuccess) {
        final currentState = state as CartSuccess;
        final selectedItems = event.isSelected
            ? (currentState.data!["data"] as List).map((e) => Cart.fromJson(e)).toSet()
            : <Cart>{};
        emit(CartSuccess(
          data: currentState.data,
          selectedItems: selectedItems,
        ));
      }
    });

    on<SelectCartItem>((event, emit) async {
      if (state is CartSuccess) {
        final currentState = state as CartSuccess;
        final selectedItems = Set<Cart>.from(currentState.selectedItems);
        if (event.isSelected) {
          selectedItems.add(event.cart);
        } else {
          selectedItems.remove(event.cart);
        }
        emit(CartSuccess(
          data: currentState.data,
          selectedItems: selectedItems,
        ));
      }
    });
  }
}