import 'package:dis_app/models/chart_model.dart';
import 'package:dis_app/blocs/checkout/checkout_bloc.dart';
import 'package:dis_app/blocs/checkout/checkout_event.dart';
import 'package:dis_app/blocs/checkout/checkout_state.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dis_app/utils/constants/colors.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> selectedItems;

  CheckoutScreen({required this.selectedItems});

  final NumberFormat currencyFormat = NumberFormat('#,###', 'id');

  int getTotalPrice(List<CartItem> items) {
    return items.fold(0, (total, item) => total + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CheckoutBloc()..add(LoadCheckoutItems(selectedItems)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: DisColors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: DisColors.primary,
        ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            final groupedItems = <String, List<CartItem>>{};
            for (var item in state.cartItems) {
              groupedItems.putIfAbsent(item.photographer, () => []).add(item);
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: groupedItems.keys.length,
                    itemBuilder: (context, index) {
                      final photographer = groupedItems.keys.elementAt(index);
                      final items = groupedItems[photographer]!;
                      final subtotal = getTotalPrice(items);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt_outlined,
                                    color: DisColors.black),
                                title: Text(
                                  photographer,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Column(
                                children: items.map((item) {
                                  return ListTile(
                                    leading: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  item.imagePath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          item.imagePath,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      item.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      "IDR ${currencyFormat.format(item.price)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Subtotal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: DisColors.black)),
                                    Text(
                                      "IDR ${currencyFormat.format(subtotal)}",
                                      style:
                                          TextStyle(color: DisColors.primary),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(Icons.payment,
                                    color: DisColors.primary),
                                title: Text("Payment Option"),
                                trailing: Image.asset(
                                  "assets/images/qris.png",
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.contain,
                                ),
                                onTap: () {
                                  DisHelperFunctions.showSnackBar(
                                      context, "Payment option selected: QRIS");
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price (${state.cartItems.length} Items)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: DisColors.primary),
                              color: DisColors.white,
                            ),
                            child: Text(
                              "IDR ${currencyFormat.format(getTotalPrice(state.cartItems))}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: DisColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: DisColors.white,
                              backgroundColor: DisColors.primary,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 4,
                              shadowColor: DisColors.black,
                            ),
                            onPressed: () {
                              DisHelperFunctions.showAlert(
                                context,
                                "Order Confirmation",
                                "Are you sure you want to place the order?",
                                  () {
                                    DisHelperFunctions.navigateToRoute(context, "/payment");
                                  }
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle,
                                    color: DisColors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Place Order",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: DisColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
