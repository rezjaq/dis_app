import 'package:flutter/material.dart';
import 'package:dis_app/utils/constants/colors.dart';

class DisBuildRow extends StatelessWidget {
  final String label;
  final String value;

  const DisBuildRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: DisColors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: DisColors.black,
          ),
        ),
      ],
    );
  }
}