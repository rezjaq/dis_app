import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transaction = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final NumberFormat currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    final date = DateTime.parse(transaction['date']);

    Stream<int> countdownStream(DateTime endTime) async* {
      final int endTimeInSeconds = endTime.difference(DateTime.now()).inSeconds;
      if (endTimeInSeconds <= 0) {
        yield 0;
        return;
      }
      for (int i = endTimeInSeconds; i >= 0; i--) {
        await Future.delayed(Duration(seconds: 1));
        yield i;
      }
    }

    return Scaffold(
      backgroundColor: DisColors.white,
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: DisColors.black, fontWeight: FontWeight.bold, fontSize: DisSizes.fontSizeMd)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            DisHelperFunctions.navigateToRoute(context, '/home', initialIndex: 3);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: DisSizes.md),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: DisSizes.sm, horizontal: DisSizes.md),
              decoration: BoxDecoration(
                color: DisColors.white,
                borderRadius: BorderRadius.circular(DisSizes.sm),
                border: Border.all(color: DisColors.grey),
              ),
              child: Column(
                children: [
                  _itemDetailPayment("Total Payment", Text(currencyFormat.format(transaction["total"]), style: TextStyle(fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w700, color: DisColors.textPrimary))),
                  _itemDetailPayment("Complete Payment Before", Text(DisHelperFunctions.getFormattedDate(date), style: TextStyle(fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.bold, color: DisColors.black))),
                  _itemDetailPayment(
                      "Reference Number Expires In",
                      Row(
                        children: [
                          _itemCounter(10),
                          SizedBox(width: DisSizes.xs),
                          Text(':', style: TextStyle(
                              fontSize: DisSizes.fontSizeSm,
                              fontWeight: FontWeight.bold,
                              color: DisColors.black)),
                          SizedBox(width: DisSizes.xs),
                          _itemCounter(10),
                          SizedBox(width: DisSizes.xs),
                          Text(':', style: TextStyle(
                              fontSize: DisSizes.fontSizeSm,
                              fontWeight: FontWeight.bold,
                              color: DisColors.black)),
                          SizedBox(width: DisSizes.xs),
                          _itemCounter(10),
                        ],
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: DisSizes.lg),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Pay With', style: TextStyle(fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.bold)),
                  SizedBox(width: DisSizes.sm),
                  Image.asset("assets/images/qris.png", width: 48, height: 48),
                ],
              ),
            ),
            Image.network(transaction["payment"]["url"], width: 280, height: 280),
            SizedBox(height: DisSizes.lg),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 200,
                padding: EdgeInsets.symmetric(vertical: DisSizes.md, horizontal: DisSizes.sm),
                decoration: BoxDecoration(
                  color: DisColors.white,
                  borderRadius: BorderRadius.circular(DisSizes.sm),
                  border: Border.all(color: DisColors.textPrimary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined, color: DisColors.textPrimary),
                    SizedBox(width: DisSizes.sm),
                    Text('Download QR Code', style: TextStyle(fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.bold, color: DisColors.textPrimary)),
                  ],
                ),
              ),
            ),
            SizedBox(height: DisSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Payment Completed?', style: TextStyle(fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w500)),
                TextButton(onPressed: () {}, child: Text('Check Status', style: TextStyle(fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.bold, color: DisColors.textPrimary))),
              ],
            ),
            SizedBox(height: DisSizes.md),
            Image.asset('assets/images/carabayarqris 1.jpg', width: DisHelperFunctions.screenWidth(context) * 0.7, height: DisHelperFunctions.screenHeight(context) * 0.5),
          ],
        ),
      ),
    );
  }

  Container _itemCounter(int value) {
    return Container(
      alignment: Alignment.center,
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: DisColors.darkerGrey,
        borderRadius: BorderRadius.circular(DisSizes.xs),
      ),
      child: Text(value < 10 ? '0$value' : '$value', style: TextStyle(fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.bold, color: DisColors.white)),
    );
  }

  Container _itemDetailPayment(String title, Widget widget) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: DisSizes.sm),
      margin: EdgeInsets.only(bottom: DisSizes.sm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: DisColors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w600)),
          widget,
        ],
      ),
    );
  }
}