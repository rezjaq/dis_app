import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class WithdrawalHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdrawal History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: DisSizes.fontSizeMd),),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: List.generate(10, (index) => _cardWithdrawalHistory(context)),
          ),
        ),
      ),
    );
  }

  Container _cardWithdrawalHistory(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DisColors.grey,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: DisColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.credit_score, color: DisColors.white,),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            width: DisHelperFunctions.screenWidth(context) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("BNI", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.w600),),
                    Text("-IDR 100.000", style: TextStyle(color: DisColors.error, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w500),),
                  ],
                ),
                Text("Withdrawal", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.normal),),
                Text("11 Nov 2024 09:20 ", style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.normal),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}