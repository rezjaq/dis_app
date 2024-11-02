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

  void _showWarningDialog() {
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
                Navigator.of(context).pop(); // Close the dialog
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
    return Scaffold(
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
            title: Text("Select All",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            tileColor: Colors.white, // Set tile background to white
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Keep product item background white
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                cartItems[index].imagePath,
                                width: 80,
                                height: 80,
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 2),
                                Text(cartItems[index].photographer,
                                    style: TextStyle(color: Colors.grey[600])),
                                SizedBox(height: 4),
                                Text(
                                  "IDR ${currencyFormat.format(cartItems[index].price)}",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600),
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
                  "Total Price (${selectedItems.where((selected) => selected).length} Items)",
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
                    "IDR ${currencyFormat.format(totalPrice)}",
                    style: TextStyle(
                      fontSize: 20,
                      color: DisColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
                top: 8.0), // Add top padding for the button
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
                  // Check if any item is selected
                  if (selectedItems.contains(true)) {
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
                  } else {
                    // Show a warning dialog if no items are selected
                    _showWarningDialog();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart,
                        color: Colors.white), // Shopping cart icon
                    SizedBox(width: 8),
                    Text(
                      "Buy Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
