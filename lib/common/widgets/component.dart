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

class DisCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final String label;

  const DisCheckbox({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
    this.activeColor = DisColors.primary,
    this.checkColor = DisColors.white,
    this.label = '',
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<DisCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: _onCheckboxChanged,
          activeColor: widget.activeColor,
          checkColor: widget.checkColor,
        ),
        if (widget.label.isNotEmpty)
          Text(widget.label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class DisPopupDialog extends StatelessWidget {
  final String title;
  final String content;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  const DisPopupDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: DisColors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: DisColors.black,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onPrimaryPressed,
                child: Text(
                  primaryButtonText,
                  style: TextStyle(
                    color: DisColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSecondaryPressed,
                child: Text(
                  secondaryButtonText,
                  style: TextStyle(
                    color: DisColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DisChartPhotoItem extends StatelessWidget {
  final String imageUrl;
  final String fileName;
  final String photographer;
  final String price;
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChange;

  const DisChartPhotoItem({
    Key? key,
    required this.imageUrl,
    required this.fileName,
    required this.photographer,
    required this.price,
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
        children: [
          // Checkbox
          DisCheckbox(
            initialValue: isChecked,
            onChanged: onCheckedChange,
          ),

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

          // Spacer
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
                  price,
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
