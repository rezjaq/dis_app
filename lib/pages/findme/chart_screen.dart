import 'package:dis_app/pages/findme/checkout.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<CartItem> cartItems = [
    CartItem(
        "dsc22466.JPG", "photographer01", 15000, "assets/images/profile_2.jpg"),
    CartItem("dsc76543.JPG", "photographer_jatim", 20000,
        "assets/images/profile_2.jpg"),
    CartItem(
        "img_7652.JPG", "photographer01", 15000, "assets/images/profile_2.jpg"),
    CartItem(
        "img_9087.JPG", "photographer01", 15000, "assets/images/profile_2.jpg"),
    CartItem(
        "img_0097.JPG", "photographer01", 15000, "assets/images/profile_2.jpg"),
    CartItem(
        "img_1239.JPG", "photographer01", 15000, "assets/images/profile_2.jpg"),
  ];

  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.filled(cartItems.length, false);
  }

  // Format harga dengan titik
  final NumberFormat currencyFormat = NumberFormat('#,###', 'id');

  int get totalPrice {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) total += cartItems[i].price;
    }
    return total;
  }

  void _showImageDialog(String imagePath) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Checkbox(
              value: selectedItems.every((element) => element),
              onChanged: (bool? value) {
                setState(() {
                  for (int i = 0; i < selectedItems.length; i++) {
                    selectedItems[i] = value ?? false;
                  }
                });
              },
            ),
            title: Text("Select All"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedItems[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedItems[index] = value ?? false;
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              _showImageDialog(cartItems[index].imagePath);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                cartItems[index].imagePath,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItems[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(cartItems[index].photographer),
                                Text(
                                  "IDR ${currencyFormat.format(cartItems[index].price)}",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                  "Total Price (${selectedItems.where((selected) => selected).length} Content)",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "IDR ${currencyFormat.format(totalPrice)}",
                  style: TextStyle(
                    fontSize: 20,
                    color: DisColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: DisColors.primary,
                ),
                onPressed: () {
                  List<CartItem> selectedCartItems = [];
                  for (int i = 0; i < cartItems.length; i++) {
                    if (selectedItems[i]) {
                      selectedCartItems.add(cartItems[i]);
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckoutScreen(selectedItems: selectedCartItems),
                    ),
                  );
                },
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String title;
  final String photographer;
  final int price;
  final String imagePath;

  CartItem(this.title, this.photographer, this.price, this.imagePath);
}
