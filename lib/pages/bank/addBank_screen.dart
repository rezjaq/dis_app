import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class AddBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Bank Account",
          style: TextStyle(color: DisColors.black),
        ),
        centerTitle: true,
        backgroundColor: DisColors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DisColors.black),
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
            // Full Name Field
            Text(
              "Full Name",
              style: TextStyle(fontSize: 14.0, color: DisColors.primary),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Bank account's name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Account Number Field
            Text(
              "Account Number",
              style: TextStyle(fontSize: 14.0, color: DisColors.primary),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Add account number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            // Bank Name Field
            Text(
              "Bank Name",
              style: TextStyle(fontSize: 14.0, color: DisColors.primary),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              hint: Text("Add bank name"),
              items: [
                DropdownMenuItem(
                  value: "Bank A",
                  child: Text("Bank A"),
                ),
                DropdownMenuItem(
                  value: "Bank B",
                  child: Text("Bank B"),
                ),
                DropdownMenuItem(
                  value: "Bank C",
                  child: Text("Bank C"),
                ),
              ],
              onChanged: (value) {
                // Handle selection
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: Column(
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: DisColors.success, size: 85.0),
                          SizedBox(height: 16.0),
                          Text("Success!",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      content: Text("Your new bank account has been added"),
                      actions: [
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, '/BankAccountListScreen');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DisColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DisColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: DisColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
