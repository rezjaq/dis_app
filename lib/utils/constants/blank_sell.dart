import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisBlankSell extends StatelessWidget {
  final VoidCallback onUpload;

  const DisBlankSell({Key? key, required this.onUpload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/noSell.svg',
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            "Start Selling",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "You haven't listed any items for sale yet.\nStart selling and reach more buyers.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: DisColors.black),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onUpload,
            style: ElevatedButton.styleFrom(
              backgroundColor: DisColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Upload Sell",
              style: TextStyle(fontSize: 16, color: DisColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
