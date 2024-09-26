import 'package:flutter/material.dart';

class CustomPngIcon extends StatelessWidget {
  final String iconPath;
  final double size;

  const CustomPngIcon({
    super.key,
    required this.iconPath,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(iconPath, width: size, height: size);
  }
}
