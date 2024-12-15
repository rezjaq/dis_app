import 'package:dis_app/blocs/chart/chart_bloc.dart';
import 'package:dis_app/blocs/chart/chart_event.dart';
import 'package:dis_app/blocs/chart/chart_state.dart';
import 'package:dis_app/common/widgets/chartPhotoItem.dart';
import 'package:dis_app/controllers/cart_controller.dart';
import 'package:dis_app/models/cart_model.dart';
import 'package:dis_app/pages/findme/checkout.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartController: CartController())..add(ListCartItem()),
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
              if (state is CartLoading) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (state is CartSuccess) {
                final data = (state.data!["data"] as List).map((e) => Cart.fromJson(e)).toList();
                final selectedItems = data.where((element) => state.selectedItems.contains(element)).toList();
                final totalPrice = selectedItems.fold(0.0, (double sum, item) => sum + item.price);
                return Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: data.every((element) => state.selectedItems.contains(element)),
                        activeColor: DisColors.primary,
                        onChanged: (value) {
                          BlocProvider.of<CartBloc>(context).add(SelectAllCartItem(
                              isSelected: value ?? false
                          ));
                        },
                      ),
                      title: Text(
                        "Select All",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      tileColor: Colors.white,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: data.length > 0 ? (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                child: Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      alignment: Alignment.centerRight,
                                      color: DisColors.error,
                                      child: Icon(Icons.delete, color: Colors.white),
                                    ),
                                    onDismissed: (direction) {
                                      BlocProvider.of<CartBloc>(context).add(RemoveCartItem(
                                          photoId: data[index].photoId
                                      ));
                                    },
                                    child: DisCartPhotoItem(
                                      imageAssetPath: data[index].url,
                                      fileName: data[index].namePhoto,
                                      photographer: data[index].nameSeller,
                                      price: data[index].price,
                                      isChecked: state.selectedItems.contains(data[index]),
                                      onCheckedChange: (value) {
                                        BlocProvider.of<CartBloc>(context).add(SelectCartItem(
                                            cart: data[index],
                                            isSelected: value ?? false
                                        ));
                                      },
                                    )
                                ),
                              );
                            } : (context, index) {
                              return Center(child: Text("No Item in Cart"),);
                            }
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price (${selectedItems.length} Items)",
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
                                "IDR ${totalPrice.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: DisColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]
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
                            if (selectedItems.isEmpty) {
                              _showWarningDialog(context);
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(selectedItems: selectedItems)));
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
              }
              return Center(child: Text("Cannot Load Data"),);
            }
        ),
      ),
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
}