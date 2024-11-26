import 'package:dis_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

enum IconPosition { left, right, none }

class DisCustomInputField extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? placeholder;
  final double width;
  // final double height;
  final IconPosition iconPosition;
  final TextEditingController? controller;
  final Color focusColor;
  final Color hoverColor;
  final int maxLength;

  const DisCustomInputField({
    Key? key,
    this.label,
    this.icon,
    this.placeholder,
    // this.height = 60.0,
    this.width = double.infinity,
    this.iconPosition = IconPosition.none,
    this.controller,
    this.focusColor = DisColors.primary,
    this.hoverColor = DisColors.darkGrey,
    this.maxLength = 300, // Set max character limit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Set the desired width
      // height: height, // Set the desired height
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: DisColors.darkGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: hoverColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: focusColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: hoverColor),
          ),
          prefixIcon: iconPosition == IconPosition.left && icon != null
              ? Icon(icon, color: DisColors.darkGrey)
              : null,
          suffixIcon: iconPosition == IconPosition.right && icon != null
              ? Icon(icon, color: DisColors.darkGrey)
              : null,
          counterText: '', // Suppress default counter to use custom format
        ),
        cursorColor: focusColor,
        buildCounter: (context,
                {required currentLength, maxLength, required isFocused}) =>
            Text(
          '$currentLength/$maxLength',
          style: const TextStyle(fontSize: 12, color: DisColors.darkGrey),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLength: maxLength,
//       decoration: InputDecoration(
//         hintText: placeholder,
//         hintStyle: TextStyle(color: DisColors.darkGrey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: hoverColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: focusColor, width: 2.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           borderSide: BorderSide(color: hoverColor),
//         ),
//         prefixIcon: iconPosition == IconPosition.left && icon != null
//             ? Icon(icon, color: DisColors.darkGrey)
//             : null,
//         suffixIcon: iconPosition == IconPosition.right && icon != null
//             ? Icon(icon, color: DisColors.darkGrey)
//             : null,
//         counterText: '', // Suppress default counter to use custom format
//       ),
//       cursorColor: focusColor,
//       buildCounter: (context,
//               {required currentLength, maxLength, required isFocused}) =>
//           Text(
//         '$currentLength/$maxLength',
//         style: const TextStyle(fontSize: DisSizes.fontSizeXs, color: DisColors.darkGrey),
//       ),
//     );
//   }
// }
