import 'package:dis_app/utils/constants/colors.dart';
import 'package:dis_app/utils/constants/sizes.dart';
import 'package:dis_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class DisCardHistory extends StatelessWidget {
  final String url;
  final String title;
  final String amount;
  final String username;
  final String date;
  final bool isIncome;

  const DisCardHistory({
    Key? key,
    required this.url,
    required this.title,
    required this.amount,
    required this.username,
    required this.date,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: DisColors.grey,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0,),
          Container(
            width: DisHelperFunctions.screenWidth(context) * 0.575,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DisHelperFunctions.truncateText(title, 12), style: TextStyle(color: DisColors.black, fontSize: DisSizes.fontSizeMd, fontWeight: FontWeight.w500),),
                    Text("${isIncome ? "+" : "-"}IDR ${amount}", style: TextStyle(color: isIncome ? DisColors.success : DisColors.error, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.normal),),
                  ],
                ),
                SizedBox(height: 4.0,),
                Text(DisHelperFunctions.truncateText(username, 24), style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.normal),),
                SizedBox(height: 4.0,),
                Text(date, style: TextStyle(color: DisColors.darkGrey, fontSize: DisSizes.fontSizeSm, fontWeight: FontWeight.normal),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}