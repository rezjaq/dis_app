import 'package:dis_app/blocs/auth/auth_bloc.dart';
import 'package:dis_app/blocs/transaction/transaction_bloc.dart';
import 'package:dis_app/blocs/transaction/transaction_event.dart';
import 'package:dis_app/blocs/transaction/transaction_state.dart';
import 'package:dis_app/blocs/user/user_bloc.dart';
import 'package:dis_app/blocs/user/user_event.dart';
import 'package:dis_app/blocs/user/user_state.dart';
import 'package:dis_app/controllers/transaction_controller.dart';
import 'package:dis_app/controllers/user_controller.dart';
import 'package:dis_app/models/transaction_model.dart';
import 'package:dis_app/pages/auth/register_screen.dart';
import 'package:dis_app/pages/transaction/transaction_history.dart';
import 'package:dis_app/pages/withdraw/withdraw_screen.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/cardHistory.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  double balance = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserGetEvent());
  }

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
        centerTitle: true,
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
                          BlocProvider(
                            create: (context) =>
                                UserBloc(userController: UserController())
                                  ..add(UserGetEvent()),
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserSuccess) {
                                  balance = state.data!['balance'];
                                  final balanceFormatted = NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'IDR ')
                                      .format(balance);
                                  return Text(
                                    balanceFormatted,
                                    style: TextStyle(
                                        color: DisColors.black,
                                        fontSize: DisSizes.fontSizeXl,
                                        fontWeight: FontWeight.w500),
                                  );
                                }
                                return Text(
                                  "IDR -",
                                  style: TextStyle(
                                    color: DisColors.black,
                                    fontSize: DisSizes.fontSizeLg,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
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
                            DisHelperFunctions.navigateToScreen(context, WithdrawScreen(balance: balance,));
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
                    child: BlocProvider(
                        create: (context) => TransactionBloc(transactionController: TransactionController())..add(TransactionListBySellerEvent()),
                        child: BlocBuilder<TransactionBloc, TransactionState>(
                          builder: (context, state) {
                            if (state is TransactionSuccess) {
                              final transactions = (state.data!["data"] as List).map((e) => TransactionHistorySeller.fromJson(e)).toList();
                              if (transactions.isNotEmpty) {
                                return _transactionItem(transactions);
                              }
                            }
                            if (state is TransactionLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return _blankLatestTransactionHistory();
                          },
                        )
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _blankLatestTransactionHistory() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Transaction History", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12.0),
          Text("You haven't made any transaction yet. Start selling or buying now! ", style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeSm), textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          SvgPicture.asset(
            'assets/images/no_latest_history.svg',
            height: DisHelperFunctions.screenHeight(context) * 0.25,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  DisHelperFunctions.navigateToRoute(context, '/home');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: DisColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: DisColors.primary, width: 2.0),
                  ),
                  child: Text("Start Sell", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w600),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  DisHelperFunctions.navigateToRoute(context, '/home');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: DisColors.primary,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: DisColors.primary, width: 2.0),
                  ),
                  child: Text("Start Buy", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w600),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Column _transactionItem(List<TransactionHistorySeller> transactions) {
    return Column(
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
                            TransactionHistoryScreen(transactions: transactions,)),
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
                transactions.length <= 4 ? transactions.length : 4,
                    (index) => DisCardHistory(
                  url: transactions[index].photoUrl,
                  title: transactions[index].photoName,
                  amount: transactions[index].price.toString(),
                  username: transactions[index].username,
                  date: DisHelperFunctions.getFormattedDate(transactions[index].date),
                ),
              ),
            )
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
                      TransactionHistoryScreen(transactions: transactions,),
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
    );
  }
}