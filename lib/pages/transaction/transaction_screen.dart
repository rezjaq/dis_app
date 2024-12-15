import 'package:dis_app/blocs/transaction/transaction_event.dart';
import 'package:dis_app/blocs/transaction/transaction_state.dart';
import 'package:dis_app/models/photo_model.dart';
import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/pages/findme/findme_screen.dart';
import 'package:dis_app/pages/transaction/payment_page.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../blocs/transaction/transaction_bloc.dart';
import '../../controllers/transaction_controller.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Map<String, dynamic> data = {
    "pending": {
      "text": "Waiting for payment",
      "color": DisColors.warning,
    },
    "paid": {
      "text": "Completed",
      "color": DisColors.success,
    },
    "failed": {
      "text": "Cancelled",
      "color": DisColors.error,
    },
    "expired": {
      "text": "Cancelled",
      "color": DisColors.error,
    },
    "cancelled": {
      "text": "Cancelled",
      "color": DisColors.error,
    },
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(transactionController: TransactionController())..add(TransactionListByBuyerEvent()),
      child: Scaffold(
        backgroundColor: DisColors.white,
        appBar: AppBar(
          backgroundColor: DisColors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Transaction", style: TextStyle(color: DisColors.black)),
              IconButton(onPressed: () {
                DisHelperFunctions.navigateToRoute(context, "/balance");
              }, icon: Icon(Icons.account_balance_wallet_rounded, color: DisColors.black,)),
            ],
          ),
        ),
        body: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionSuccess) {
                final transactions = (state.data!['data'] as List).map((e) => TransactionHistory.fromJson(e)).toList();
                return transactions.isNotEmpty ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: List.generate(transactions.length, (index) => Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: _cardTransaction(transactions[index]),
                      )),
                    )
                ) : Center(child: _blankTransactionHistory(),);
              }
              if (state is TransactionLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: _blankTransactionHistory());
            }
        ),
      ),
    );
  }

  Widget _blankTransactionHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Image.asset(
            "assets/images/no_purchase_history.jpg",
            width: DisHelperFunctions.screenWidth(context) * 0.75,
            height: DisHelperFunctions.screenWidth(context) * 0.75,
          ),
          const SizedBox(height: 16.0),
          Text("No Transaction History", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeLg, fontWeight: FontWeight.bold),),
          SizedBox(height: 8.0),
          Text("You haven't made any purchases yet. Find your picture and start shopping", style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeMd), textAlign: TextAlign.center,),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              DisHelperFunctions.navigateToRoute(context, '/home');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: DisColors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Start Buy", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.w600),),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _cardTransaction(TransactionHistory transaction) {
    final formatCurrency = NumberFormat.currency(locale: "id_ID", symbol: "IDR ", decimalDigits: 0);

    return GestureDetector(
      onTap: () async {
        print("Transaction ID: ${transaction.id}");
        final transactionBloc = BlocProvider.of<TransactionBloc>(context);
        transactionBloc.add(TransactionGetEvent(id: transaction.id));

        await for (final state in transactionBloc.stream) {
          if (state is TransactionGetSuccess) {
            final transaction = state.data;
            print("Transaction: $transaction");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(),
                settings: RouteSettings(arguments: transaction),
              ),
            );
            break;
          } else if (state is TransactionFailure) {
            print("Error fetching transaction");
            break;
          }
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: DisColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: DisColors.black.withOpacity(0.2),
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.camera_alt_outlined, color: DisColors.black,),
                      SizedBox(width: 8.0),
                      Text("Photo", style: TextStyle(color: DisColors.black)),
                    ],
                  ),
                  Text(data[transaction.status]["text"], style: TextStyle(color: data[transaction.status]["color"], fontWeight: FontWeight.w600, fontSize: DisSizes.fontSizeXs),),
                ],
              ),
              SizedBox(height: 12.0),
              Column(
                children: transaction.details.isNotEmpty ? transaction.details.map((detail) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle, color: DisColors.black,),
                          SizedBox(width: 8.0),
                          Text(detail.username, style: TextStyle(color: DisColors.black, fontWeight: FontWeight.w600, fontSize: DisSizes.fontSizeMd)),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        children: detail.photos.isNotEmpty ? detail.photos.map((photo) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.0),
                            child: _transactionItem(photo),
                          );
                        }).toList() : [Text("No photos available")],
                      ),
                    ],
                  );
                }).toList() : [Text("No details available")],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DisHelperFunctions.getFormattedDate(transaction.date), style: TextStyle(fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.w500, color: DisColors.darkGrey),),
                  const SizedBox(width: 4.0),
                  Text("Total: ${formatCurrency.format(transaction.total)}", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w500),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _transactionItem(PhotoHistory photo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: DisColors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            image: photo.url != null && photo.url.isNotEmpty
                ? DecorationImage(
              image: NetworkImage(photo.url),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: photo.url == null || photo.url.isEmpty
              ? Icon(Icons.broken_image, color: DisColors.darkerGrey)
              : null,
        ),
        SizedBox(width: 20.0),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DisHelperFunctions.truncateText(photo.name, 20), style: TextStyle(color: DisColors.black, fontWeight: FontWeight.w600, fontSize: DisSizes.fontSizeMd),),
              SizedBox(height: 4.0),
              Text("IDR ${photo.price}", style: TextStyle(color: DisColors.darkerGrey, fontSize: DisSizes.fontSizeXs),),
            ],
          ),
        ),
      ],
    );
  }
}