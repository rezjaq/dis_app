import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      imageUrl: 'assets/images/dummies/content.jpg',
      filename: 'img_1239.JPG',
      username: 'anggi202',
      date: '11 Nov 2024 09:20',
      amount: 15000,
      isCredit: true,
    ),
    Transaction(
      imageUrl: 'assets/images/dummies/dummy_1.jpg',
      filename: 'dsc76543.JPG',
      username: 'photographer_jatim',
      date: '09 Nov 2024 09:00',
      amount: 1500,
      isCredit: false,
    ),
    Transaction(
      imageUrl: 'assets/images/dummies/dummy_2.jpg',
      filename: 'dsc22466.JPG',
      username: 'lidya123',
      date: '08 Nov 2024 07:20',
      amount: 2500000,
      isCredit: true,
    ),
    // Add more transactions as needed
  ];

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
        itemCount: transactions.length * 10,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          final transaction = transactions[index % transactions.length];
          return TransactionTile(
              transaction: transaction, currencyFormat: currencyFormat);
        },
      ),
      backgroundColor: Color(0xFFF8F8F8),
    );
  }
}

class Transaction {
  final String imageUrl;
  final String filename;
  final String username;
  final String date;
  final int amount;
  final bool isCredit;

  Transaction({
    required this.imageUrl,
    required this.filename,
    required this.username,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
}

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
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
          child: Image.asset(
            transaction.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        transaction.filename,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transaction.username,
              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          SizedBox(height: 4),
          Text(transaction.date,
              style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
      trailing: Text(
        '${transaction.isCredit ? '+' : '-'}IDR ${currencyFormat.format(transaction.amount)}', // Use the currency formatter
        style: TextStyle(
          color: transaction.isCredit ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
