import 'package:flutter/material.dart';

class EditBankAccountScreen extends StatefulWidget {
  final String accountName;
  final String accountNumber;
  final String bankName;

  const EditBankAccountScreen({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  }) : super(key: key);

  @override
  _EditBankAccountScreenState createState() => _EditBankAccountScreenState();
}

class _EditBankAccountScreenState extends State<EditBankAccountScreen> {
  late TextEditingController _accountNameController;
  late TextEditingController _accountNumberController;
  String? _selectedBankName;

  final List<String> _bankNames = [
    'SEABANK',
    'Bank Syariah Indonesia (BSI)',
    'Bank Mandiri',
    'Bank Central Asia (BCA)',
    'Bank Rakyat Indonesia (BRI)',
  ];

  @override
  void initState() {
    super.initState();
    _accountNameController = TextEditingController(text: widget.accountName);
    _accountNumberController =
        TextEditingController(text: widget.accountNumber);
    _selectedBankName = widget.bankName;
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bank Account'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _accountNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Account Number',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'Bank Name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedBankName,
              items: _bankNames.map((String bankName) {
                return DropdownMenuItem<String>(
                  value: bankName,
                  child: Text(bankName),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBankName = newValue;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
