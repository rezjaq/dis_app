import 'package:dis_app/pages/findme/checkout.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<CartItem> cartItems = [
    CartItem(
        "dsc22466.JPG", "photographer01", 15000, "assets/images/photo1.jpg"),
    CartItem("dsc76543.JPG", "photographer_jatim", 20000,
        "assets/images/photo2.jpg"),
    CartItem(
        "img_7652.JPG", "photographer01", 15000, "assets/images/photo3.jpg"),
    CartItem(
        "img_9087.JPG", "photographer01", 15000, "assets/images/photo4.jpg"),
    CartItem(
        "img_0097.JPG", "photographer01", 15000, "assets/images/photo5.jpg"),
    CartItem(
        "img_1239.JPG", "photographer01", 15000, "assets/images/photo6.jpg"),
  ];
  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.filled(cartItems.length, false);
  }

  int get totalPrice {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) total += cartItems[i].price;
    }
    return total;
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
                return ListTile(
                  leading: Checkbox(
                    value: selectedItems[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedItems[index] = value ?? false;
                      });
                    },
                  ),
                  title: Text(cartItems[index].title),
                  subtitle: Text(cartItems[index].photographer),
                  trailing: Text("IDR ${cartItems[index].price}"),
                  onTap: () {
                    setState(() {
                      selectedItems[index] = !selectedItems[index];
                    });
                  },
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
                  "IDR $totalPrice",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
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
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()),
                  );
                },
                child: Text("Buy Now"),
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
