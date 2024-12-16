import 'package:dis_app/blocs/withdraw/withdraw_bloc.dart';
import 'package:dis_app/blocs/withdraw/withdraw_state.dart';
import 'package:dis_app/controllers/withdraw_controller.dart';
import 'package:dis_app/models/withdraw_model.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/withdraw/withdraw_event.dart';

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
          child: BlocProvider(
              create: (context) => WithdrawBloc(withdrawController: WithdrawController())..add(ListWithdrawEvent(page: 1, size: 10)),
            child: BlocBuilder<WithdrawBloc, WithdrawState>(
              builder: (context, state) {
                if (state is WithdrawListSuccess) {
                  final withdrawals = state.data;
                  return Column(
                    children: List.generate(withdrawals.length, (index) => _cardWithdrawalHistory(context, withdrawals[index])),
                  );
                } else if (state is WithdrawFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Container _cardWithdrawalHistory(BuildContext context, Withdraw withdrawal) {
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
                    Text(withdrawal.bank!, style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.w600),),
                    Text("-${_formatCurrency(withdrawal.amount)}", style: TextStyle(color: DisColors.error, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.w500),),
                  ],
                ),
                Text("Withdrawal", style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.normal),),
                Text(DisHelperFunctions.getFormattedDate(withdrawal.createdAt), style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeXs, fontWeight: FontWeight.normal),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    return formatter.format(amount);
  }
}