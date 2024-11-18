import 'package:dis_app/pages/bank/editBank_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BankAccountDetailScreen extends StatelessWidget {
  final String accountName;
  final String accountNumber;
  final String bankName;

  const BankAccountDetailScreen({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Detail'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account Detail',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: DisColors.success,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBankAccountScreen(
                                  accountName: accountName,
                                  accountNumber: accountNumber,
                                  bankName: bankName,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: DisColors.error,
                          ),
                          onPressed: () {
                            _showDeleteConfirmation(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: DisColors.darkerGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  accountName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Number',
                  style: TextStyle(
                    fontSize: 14,
                    color: DisColors.darkerGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  accountNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bank Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: DisColors.darkerGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bankName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // tolong jadikan component makasih hehe
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Bank Account?'),
          content: const Text(
            'Are you sure want to delete this bank account?',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: DisColors.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                // Add your delete logic here
                Navigator.pop(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: DisColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
