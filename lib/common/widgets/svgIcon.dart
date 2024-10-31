import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double width;
  final double height;

  const SvgIcon({
    Key? key,
    required this.assetName,
    this.color,
    this.width = 24.0,
    this.height = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      color: color,
      width: width,
      height: height,
    );
  }
}