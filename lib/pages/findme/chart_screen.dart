import 'package:dis_app/models/chart_model.dart';
import 'package:dis_app/pages/findme/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/blocs/chart/chart_bloc.dart';
import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/chart/chart_state.dart';

class ShoppingCartScreen extends StatelessWidget {
  final NumberFormat currencyFormat = NumberFormat('#,###', 'id');

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Item Selected"),
          content:
              Text("Please select at least one product before proceeding."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: DisColors.primary,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cartBloc = context.read<CartBloc>();

            return Column(
              children: [
                ListTile(
                  leading: Checkbox(
                    value: state.selectedItems.every((element) => element),
                    onChanged: (bool? value) {
                      cartBloc.add(SelectAllCartItems(value ?? false));
                    },
                  ),
                  title: Text("Select All",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  tileColor: Colors.white,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            cartBloc.add(RemoveCartItem(index));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: Offset(0, 3)),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: state.selectedItems[index],
                                    onChanged: (bool? value) {
                                      cartBloc.add(SelectCartItem(
                                          index, value ?? false));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(context,
                                          state.cartItems[index].imagePath);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                          state.cartItems[index].imagePath,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state.cartItems[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        SizedBox(height: 2),
                                        Text(
                                            state.cartItems[index].photographer,
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                        SizedBox(height: 4),
                                        Text(
                                            "IDR ${currencyFormat.format(state.cartItems[index].price)}",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price (${state.selectedItems.where((selected) => selected).length} Items)",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: DisColors.primary),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "IDR ${currencyFormat.format(state.totalPrice)}",
                          style: TextStyle(
                              fontSize: 20,
                              color: DisColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: DisColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black54,
                      ),
                      onPressed: () {
                        if (state.selectedItems.contains(true)) {
                          List<CartItem> selectedCartItems = [];
                          for (int i = 0; i < state.cartItems.length; i++) {
                            if (state.selectedItems[i]) {
                              selectedCartItems.add(state.cartItems[i]);
                            }
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                  selectedItems: selectedCartItems),
                            ),
                          );
                        } else {
                          _showWarningDialog(context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Buy Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
