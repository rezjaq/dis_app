import 'package:dis_app/common/widgets/Checkbox.dart';

import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisCartPhotoItem extends StatelessWidget {
  // if you want to use imageUrl
  // final String imageUrl;
  final String imageAssetPath;
  final String fileName;
  final String photographer;
  final double price;
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChange;

  const DisCartPhotoItem({
    Key? key,
    // required this.imageUrl,
    required this.imageAssetPath,
    required this.fileName,
    required this.photographer,
    required this.price,
    this.isChecked = false,
    required this.onCheckedChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format price for IDR
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(price);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: DisColors.softGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox
          DisCheckbox(
            initialValue: isChecked,
            onChanged: onCheckedChange,
          ),
          SizedBox(width: 8.0),

          // Image Url
          //  ClipRRect(
          //   borderRadius: BorderRadius.circular(8.0),
          //   child: Image.network(
          //     imageUrl,
          //     width: 85,
          //     height: 85,
          //     fit: BoxFit.cover,
          //   ),
          //  ),

          // Image Path
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageAssetPath,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.0),

          // Text content (file name, photographer, price)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  photographer,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: DisColors.darkGrey,
                  ),
                ),
                Text(
                  formattedPrice, // Harga dalam format IDR
                  style: TextStyle(
                    fontSize: 14.0,
                    color: DisColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
