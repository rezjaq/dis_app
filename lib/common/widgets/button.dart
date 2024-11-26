import 'package:dis_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DisButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool showIcon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final bool showStroke;
  final Color strokeColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double width;

  DisButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon,
    this.showIcon = false,
    this.showStroke = false,
    this.strokeColor = DisColors.primary,
    this.backgroundColor = DisColors.primary,
    this.textColor = DisColors.black,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14.0,
    this.width = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: strokeColor,
                width: 2.0,
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon && icon != null) ...[
                Icon(icon, color: textColor),
                SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ));
  }
}