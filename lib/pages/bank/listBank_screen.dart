import 'package:dis_app/pages/bank/bankDetail_screen.dart';
import 'package:flutter/material.dart';

class BankAccountListScreen extends StatelessWidget {
  final List<Map<String, String>> bankAccounts = [
    {
      'accountNumber': '901803692999',
      'name': 'KAMALA HARRIS',
      'bank': 'SEABANK',
    },
    {
      'accountNumber': '202503692999',
      'name': 'KAMALA HARRIS',
      'bank': 'Bank Syariah Indonesia (BSI)',
    },
    {
      'accountNumber': '7651803692999',
      'name': 'KAMALA HARRIS',
      'bank': 'Bank Mandiri',
    },
    {
      'accountNumber': '901803692999',
      'name': 'KAMALA HARRIS',
      'bank': 'Bank Central Asia (BCA)',
    },
    {
      'accountNumber': '777803692999',
      'name': 'KAMALA HARRIS',
      'bank': 'Bank Rakyat Indonesia (BRI)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account List'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add your add button action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: bankAccounts.length,
        itemBuilder: (context, index) {
          final account = bankAccounts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BankAccountDetailScreen(
                    accountName: account['name']!,
                    accountNumber: account['accountNumber']!,
                    bankName: account['bank']!,
                  ),
                ),
              );
            },
            child: Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account['accountNumber']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account['name']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account['bank']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
