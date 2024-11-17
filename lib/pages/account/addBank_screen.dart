import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AddbankScreen extends StatefulWidget {
  @override
  _AddbankScreenState createState() => _AddbankScreenState();
}

class _AddbankScreenState extends State<AddbankScreen> {
  final _bankAccountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();

  final _bankAccountNumberFocusNode = FocusNode();
  final _accountNumberFocusNode = FocusNode();
  final _bankNameFocusNode = FocusNode();

  @override
  void dispose() {
    _bankAccountNameController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    _bankAccountNumberFocusNode.dispose();
    _accountNumberFocusNode.dispose();
    _bankAccountNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Bank Account',
          style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Full Name',
              style: TextStyle(color: Colors.yellow), // Warna kuning
            ),
            const SizedBox(height: 10),
            _buildTextFormField(_bankAccountNameController,
                'Name of the bank account', _bankAccountNumberFocusNode),
            const SizedBox(height: 20),
            const Text(
              'Account Number',
              style: TextStyle(color: Colors.yellow), // Warna kuning
            ),
            const SizedBox(height: 10),
            _buildTextFormField(_accountNumberController, 'Add account number',
                _accountNumberFocusNode),
            const SizedBox(height: 20),
            const Text(
              'Bank Name',
              style: TextStyle(color: Colors.yellow), // Warna kuning
            ),
            const SizedBox(height: 10),
            _buildTextFormField(
                _bankNameController, 'Add bank name', _bankNameFocusNode),
            const SizedBox(
                height: 30), // Jarak antara elemen terakhir dan tombol
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: DisColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText, FocusNode focusNode,
      {bool obscureText = false}) {
    return Focus(
      focusNode: focusNode,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: labelText,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        onTap: () {
          setState(() {});
        },
      ),
    );
  }
}
