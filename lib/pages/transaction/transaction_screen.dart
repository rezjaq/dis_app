import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.white,
      appBar: AppBar(
        backgroundColor: DisColors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Transaction", style: TextStyle(color: DisColors.black)),
            IconButton(onPressed: () {
              DisHelperFunctions.navigateToRoute(context, "/balance");
            }, icon: Icon(Icons.account_balance_wallet_rounded, color: DisColors.black,)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: List.generate(5, (index) => Container(
            margin: EdgeInsets.only(bottom: 12.0),
            child: _cardTransaction(),
          )),
        ),
      ),
    );
  }

  Container _cardTransaction() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DisColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: DisColors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, color: DisColors.black,),
                    SizedBox(width: 8.0),
                    Text("Photo", style: TextStyle(color: DisColors.black)),
                  ],
                ),
                Text("Completed", style: TextStyle(color: DisColors.success, fontWeight: FontWeight.w600, fontSize: DisSizes.fontSizeXs),),
              ],
            ),
            SizedBox(height: 12.0),
            Column(
              children: List.generate(5, (index) => Container(
                margin: EdgeInsets.only(bottom: 12.0),
                child: _transactionItem(),
              )),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("11 Nov 2024 09:19", style: TextStyle(fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.w500, color: DisColors.darkGrey),),
                const SizedBox(width: 4.0),
                Text("Total 100 Item: IDR 2.500.000.000", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w500),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _transactionItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: DisColors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            image: DecorationImage(
              image: AssetImage("assets/images/dummies/content.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DisHelperFunctions.truncateText("HSDN1312_DAJDWQJ21_DAWQ1.jpg", 20), style: TextStyle(color: DisColors.black, fontWeight: FontWeight.w600, fontSize: DisSizes.fontSizeMd),),
              SizedBox(height: 4.0),
              Text("IDR 2.500.000", style: TextStyle(color: DisColors.darkerGrey, fontSize: DisSizes.fontSizeXs),),
            ],
          ),
        ),
      ],
    );
  }
}