import 'package:dis_app/blocs/transaction/transaction_bloc.dart';
import 'package:dis_app/blocs/transaction/transaction_event.dart';
import 'package:dis_app/blocs/transaction/transaction_state.dart';
import 'package:dis_app/controllers/transaction_controller.dart';
import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/pages/transaction/payment_page.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Cart> selectedItems;

  const CheckoutScreen({Key? key, required this.selectedItems}) : super(key: key);

  Map<String, dynamic> processSelectedItems(List<Cart> selectedItems) {
    final Map<String, dynamic> result = {
      "details": [],
      "total": 0
    };

    final List<Map<String, dynamic>> displayData = [];

    final Map<String, List<Cart>> groupedBySeller = {};

    for (var item in selectedItems) {
      if (!groupedBySeller.containsKey(item.sellerId)) {
        groupedBySeller[item.sellerId] = [];
      }
      groupedBySeller[item.sellerId]!.add(item);
    }

    groupedBySeller.forEach((sellerId, items) {
      final total = items.fold(0.0, (sum, item) => sum + item.price);

      result["details"].add({
        "seller_id": sellerId,
        "items": items,
        "total": total
      });

      result["total"] += total;

      displayData.add({
        "name_seller": items.first.nameSeller,
        "details": items.map((item) => {
          "url": item.url,
          "name_photo": item.namePhoto,
          "price": item.price
        }).toList(),
        "subtotal": total
      });
    });

    result["displayData"] = displayData;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final processedData = processSelectedItems(selectedItems);
    final NumberFormat currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    
    return BlocProvider(
        create: (context) => TransactionBloc(transactionController: TransactionController()),
        child: Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
          backgroundColor: DisColors.primary,
        ),
        body: BlocListener<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionLoading) {
                DisHelperFunctions.showSnackBar(context, "Placing order...");
              }
              if (state is TransactionSuccess) {
                final transaction = state.data!;
                print(transaction);
                DisHelperFunctions.navigateToScreen(context, PaymentPage(), arguments: transaction);
              }
              if (state is TransactionFailure) {
                DisHelperFunctions.showSnackBar(context, state.message);
              }
            },
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: processedData["displayData"].length,
                      itemBuilder: (context, index) {
                        final seller = processedData["displayData"][index];
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
                                      "${seller["name_seller"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: (seller["details"] as List).map((item) {
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
                                                    child: Image.network(
                                                      item["url"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              item["url"],
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          item["name_photo"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          currencyFormat.format(item["price"]),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: DisColors.darkGrey,
                                          ),
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
                                          "${currencyFormat.format(seller["subtotal"])}",
                                          style:
                                          TextStyle(color: DisColors.textPrimary),
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
                            )
                        );
                      }
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price (${selectedItems.length} Items)",
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
                              "${currencyFormat.format(processedData["total"])}",
                              style: TextStyle(
                                color: DisColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ]
                    ),
                    SizedBox(height: 14,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<TransactionBloc, TransactionState>(
                            builder: (context, state) {
                              return ElevatedButton(
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
                                        Navigator.pop(context);
                                        final details = (processedData["details"] as List).map((item) {
                                          final sellerId = item["seller_id"];
                                          final total = item["total"];
                                          final details = (item["items"] as List<Cart>).map((item) {
                                            return Detail(
                                              sellerId: sellerId,
                                              photoIds: [item.photoId],
                                              total: item.price,
                                            );
                                          }).toList();
                                          return Detail(
                                            sellerId: sellerId,
                                            photoIds: details.map((e) => e.photoIds.first).toList(),
                                            total: total,
                                          );
                                        }).toList();
                                        final total = processedData["total"];
                                        context.read<TransactionBloc>().add(
                                            TransactionCreateEvent(
                                                details: details,
                                                total: total
                                            )
                                        );
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
                              );
                            }
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}