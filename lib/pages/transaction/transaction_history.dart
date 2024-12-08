import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<TransactionHistorySeller> transactions;

  TransactionHistoryScreen({Key? key, required this.transactions}) : super(key: key);

  final NumberFormat currencyFormat = NumberFormat('#,###', 'id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: transactions.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          final transaction = transactions[index % transactions.length];
          return TransactionTile(
              transaction: transaction, currencyFormat: currencyFormat);
        },
      ),
      backgroundColor: DisColors.white,
    );
  }
}

class TransactionTile extends StatelessWidget {
  final TransactionHistorySeller transaction;
  final NumberFormat currencyFormat;

  const TransactionTile(
      {Key? key, required this.transaction, required this.currencyFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            transaction.photoUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        transaction.photoName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transaction.username,
              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          SizedBox(height: 4),
          Text(DisHelperFunctions.getFormattedDate(transaction.date),
              style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
      trailing: Text(
        '+IDR ${currencyFormat.format(transaction.price)}', // Use the currency formatter
        style: TextStyle(
          color: DisColors.success,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
