import 'package:dis_app/pages/findme/chart_screen.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dis_app/utils/constants/colors.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> selectedItems;

  CheckoutScreen({required this.selectedItems});

  // Formatter untuk harga dengan titik
  final NumberFormat currencyFormat = NumberFormat('#,###', 'id');

  int get totalPrice {
    // Hitung total harga berdasarkan items yang dipilih
    return selectedItems.fold(0, (total, item) => total + item.price);
  }

  @override
  Widget build(BuildContext context) {
    // Group items by photographer
    Map<String, List<CheckoutItem>> groupedItems = {};
    for (var item in selectedItems) {
      if (groupedItems.containsKey(item.photographer)) {
        groupedItems[item.photographer]!
            .add(CheckoutItem(item.title, item.price, item.imagePath));
      } else {
        groupedItems[item.photographer] = [
          CheckoutItem(item.title, item.price, item.imagePath)
        ];
      }
    }

    List<CheckoutGroup> groups = groupedItems.entries.map((entry) {
      return CheckoutGroup(photographer: entry.key, items: entry.value);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt_outlined,
                              color: DisColors.black),
                          title: Text(group.photographer),
                        ),
                        Column(
                          children: group.items.map((item) {
                            return ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Image.asset(
                                          item.imagePath,
                                          fit: BoxFit.cover,
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
                              title: Text(item.title),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                  "IDR ${currencyFormat.format(group.items.fold(0, (sum, item) => sum + item.price))}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Price",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("IDR ${currencyFormat.format(totalPrice)}",
                        style:
                            TextStyle(fontSize: 20, color: DisColors.primary)),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DisColors.primary,
                    ),
                    onPressed: () {
                      DisHelperFunctions.showAlert(
                        context,
                        "Order Confirmation",
                        "Are you sure you want to place the order?",
                      );
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: DisColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutItem {
  final String title;
  final int price;
  final String imagePath;

  CheckoutItem(this.title, this.price, this.imagePath);
}

class CheckoutGroup {
  final String photographer;
  final List<CheckoutItem> items;

  CheckoutGroup({required this.photographer, required this.items});
}
