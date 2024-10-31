import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutScreen(),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final List<CheckoutGroup> groups = [
    CheckoutGroup(
      photographer: "photographer_jatim",
      items: [
        CheckoutItem("dsc76543.JPG", 20000, "assets/images/photo2.jpg"),
      ],
    ),
    CheckoutGroup(
      photographer: "photographer01",
      items: [
        CheckoutItem("img_7652.JPG", 15000, "assets/images/photo3.jpg"),
      ],
    ),
  ];

  int get totalPrice => groups.fold(0, (total, group) {
        return total +
            group.items.fold(0, (subtotal, item) => subtotal + item.price);
      });

  @override
  Widget build(BuildContext context) {
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
                          leading: Icon(Icons.camera_alt, color: Colors.black),
                          title: Text(group.photographer),
                        ),
                        Column(
                          children: group.items.map((item) {
                            return ListTile(
                              leading: Image.asset(item.imagePath,
                                  width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(item.title),
                              subtitle: Text("IDR ${item.price}"),
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
                              Text(
                                  "Total Price (${group.items.length} Content):"),
                              Text(
                                "IDR ${group.items.fold(0, (sum, item) => sum + item.price)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
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
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.orange),
            title: Text("Payment Option"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Qris"),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            onTap: () {
              // Implement payment option selection
            },
          ),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payments",
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  // Implement Place Order functionality
                },
                child: Text("Place Order"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutGroup {
  final String photographer;
  final List<CheckoutItem> items;

  CheckoutGroup({required this.photographer, required this.items});
}

class CheckoutItem {
  final String title;
  final int price;
  final String imagePath;

  CheckoutItem(this.title, this.price, this.imagePath);
}
