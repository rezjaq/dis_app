import 'package:dis_app/common/widgets/Checkbox.dart';
import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DisCartPhotoItem extends StatelessWidget {
  final String imageUrl;
  final String fileName;
  final String photographer;
  final double price; // Price is of type double
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChange;

  const DisCartPhotoItem({
    Key? key,
    required this.imageUrl,
    required this.fileName,
    required this.photographer,
    required this.price, // Accepts a double value for price
    this.isChecked = false,
    required this.onCheckedChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: DisColors.softGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items vertically centered
        children: [
          // Checkbox
          DisCheckbox(
            initialValue: isChecked,
            onChanged: onCheckedChange,
          ),
          SizedBox(width: 8.0), // Space between checkbox and image

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.0), // Space between image and text content

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
                // Format the double price as a string
                Text(
                  '\$${price.toStringAsFixed(2)}', // Ensures two decimal places
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
