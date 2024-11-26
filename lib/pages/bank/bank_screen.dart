import 'package:dis_app/pages/bank/addBank_screen.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dis_app/utils/constants/colors.dart';

class BankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank Account List",
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DisSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/noBankAccount.svg',
                height: DisSizes.imageSize,
              ),
              SizedBox(height: DisSizes.lg),
              // Title Text
              Text(
                "No Bank Account Linked",
                style: TextStyle(
                  fontSize: DisSizes.fontSizeXx,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DisSizes.sm),
              // Subtitle Text
              Text(
                "Add a bank account to start withdrawing your commission.",
                style: TextStyle(
                  fontSize: DisSizes.fontSizeSm,
                  color: DisColors.darkerGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: DisSizes.xl),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBankScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DisColors.primary,
                  padding: EdgeInsets.symmetric(
                      horizontal: DisSizes.lg, vertical: DisSizes.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Add Bank Account",
                  style: TextStyle(
                    color: DisColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: DisSizes.md,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
