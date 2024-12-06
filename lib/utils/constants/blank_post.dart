import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisBlankPost extends StatelessWidget {
  final VoidCallback onUpload;

  const DisBlankPost({Key? key, required this.onUpload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/noPost.svg',
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            "Start Posting",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "You haven't shared anything yet.\nStart posting and share your moments!.",
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
              "Upload Post",
              style: TextStyle(fontSize: 16, color: DisColors.white),
            ),
          ),
        ],
      ),
    );
  }
}