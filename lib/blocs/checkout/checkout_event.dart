import 'package:dis_app/models/chart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class LoadCheckoutItems extends CheckoutEvent {
  final List<CartItem> selectedItems;

  const LoadCheckoutItems(this.selectedItems);

  @override
  List<Object> get props => [selectedItems];
}
