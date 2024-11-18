import 'package:dis_app/pages/auth/register_screen.dart';
import 'package:dis_app/pages/transaction/transaction_history.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/cardHistory.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  List<Map<String, dynamic>> transactions = [
    {
      "url": "assets/images/dummies/content.jpg",
      "title": "Photo Bunda Maya Estianty",
      "amount": "999.999",
      "username": "parman",
      "date": "11 Nov 2024 09:19",
      "isIncome": true,
    },
    {
      "url": "assets/images/dummies/content.jpg",
      "title": "Photo Bunda Maya Estianty",
      "amount": "999.999",
      "username": "parman",
      "date": "11 Nov 2024 09:19",
      "isIncome": false,
    },
    {
      "url": "assets/images/dummies/content.jpg",
      "title": "Photo Bunda Maya Estianty",
      "amount": "999.999",
      "username": "parman",
      "date": "11 Nov 2024 09:19",
      "isIncome": true,
    },
    {
      "url": "assets/images/dummies/content.jpg",
      "title": "Photo Bunda Maya Estianty",
      "amount": "999.999",
      "username": "parman",
      "date": "11 Nov 2024 09:19",
      "isIncome": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DisColors.white,
      appBar: AppBar(
        title: Text(
          "My Balance",
          style: TextStyle(
              color: DisColors.black,
              fontWeight: FontWeight.bold,
              fontSize: DisSizes.fontSizeMd),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            child: ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                color: DisColors.primary,
              ),
            ),
          ),
          SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Balance",
                            style: TextStyle(
                                color: DisColors.black,
                                fontSize: DisSizes.fontSizeMd,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "IDR 100.000.000",
                            style: TextStyle(
                                color: DisColors.black,
                                fontSize: DisSizes.fontSizeXl,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          DisHelperFunctions.navigateToRoute(
                              context, '/history-withdrawal');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: DisColors.black,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Withdrawal History",
                                style: TextStyle(
                                  color: DisColors.black,
                                  fontSize: DisSizes.fontSizeSm,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    width: DisHelperFunctions.screenWidth(context) * 0.7,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            DisHelperFunctions.navigateToRoute(
                                context, '/bank-account');
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.account_balance,
                                color: DisColors.textPrimary,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Bank Account",
                                style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.fontSizeSm,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DisHelperFunctions.navigateToRoute(
                                context, '/withdraw');
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.balance_sharp,
                                color: DisColors.textPrimary,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Withdraw",
                                style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.fontSizeSm,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    width: DisHelperFunctions.screenWidth(context) * 0.85,
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
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
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
                            children: [
                              Text(
                                "Transaction History",
                                style: TextStyle(
                                  color: DisColors.black,
                                  fontSize: DisSizes.fontSizeMd,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionHistoryScreen()),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: DisColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: List.generate(
                                transactions.length,
                                (index) => DisCardHistory(
                                      url: transactions[index]["url"],
                                      title: transactions[index]["title"],
                                      amount: transactions[index]["amount"],
                                      username: transactions[index]["username"],
                                      date: transactions[index]["date"],
                                      isIncome: transactions[index]["isIncome"],
                                    )),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: DisColors.grey, width: 2.0)),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionHistoryScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "See More",
                                  style: TextStyle(
                                    color: DisColors.darkGrey,
                                    fontSize: DisSizes.fontSizeMd,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: DisColors.darkGrey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
