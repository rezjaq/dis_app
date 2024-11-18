import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class ConfirmTransactionScreen extends StatelessWidget {
  final String amount;
  final Map<String, dynamic> bankDetails;

  ConfirmTransactionScreen({
    required this.amount,
    required this.bankDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Transaction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total Amount To Withdraw',
                      style: TextStyle(
                        color: DisColors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'IDR $amount',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: DisColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: DisColors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Withdraw Amount', 'IDR $amount'),
                  const SizedBox(height: 8),
                  _buildRow('Withdraw To', bankDetails['name']),
                  const SizedBox(height: 8),
                  _buildRow('Bank Name', bankDetails['bank']),
                  const SizedBox(height: 8),
                  _buildRow('Account Number', bankDetails['accountNumber']),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final int withdrawAmount = int.tryParse(amount) ?? 0;
                  final int availableBalance = bankDetails['balance'] ?? 0;

                  if (withdrawAmount < 10000) {
                    _showErrorDialog(
                      context,
                      "Minimum withdrawal amount is IDR 10,000.",
                    );
                    return;
                  }

                  if (withdrawAmount > availableBalance) {
                    _showErrorDialog(
                      context,
                      "Insufficient balance. Please check your account.",
                    );
                    return;
                  }

                  final bool success = await _simulateTransaction();

                  if (success) {
                    _showSuccessDialog(context);
                  } else {
                    _showErrorDialog(
                      context,
                      "Transaction failed. Please try again.",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DisColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Withdraw Now',
                  style: TextStyle(
                    fontSize: 16,
                    color: DisColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: DisColors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: DisColors.black,
          ),
        ),
      ],
    );
  }

  Future<bool> _simulateTransaction() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: DisColors.success,
              size: 80.0,
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Success!",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: const Text(
          "Your commission has been transferred to your bank account.",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DisColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  color: DisColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Column(
          children: [
            const Icon(Icons.error, color: DisColors.error, size: 80.0),
            const SizedBox(height: 16.0),
            const Text(
              "Failed!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(message),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DisColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Retry",
                style: TextStyle(
                  color: DisColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
