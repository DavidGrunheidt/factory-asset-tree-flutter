import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String iconPath;
  final double size;

  const CustomSvgIcon({
    super.key,
    required this.iconPath,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconPath, width: size, height: size);
  }
}
