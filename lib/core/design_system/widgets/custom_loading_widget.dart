import 'package:flutter/material.dart';
import '../theme/custom_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? height;
  final Color color;
  final double strokeWidth;

  final Color? backgroundColor;

  const CustomLoadingWidget({
    super.key,
    this.height,
    this.color = CustomColors.darkBlue,
    this.backgroundColor,
    this.strokeWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(color: backgroundColor ?? CustomColors.black.withOpacity(0.3)),
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(color: color, strokeWidth: strokeWidth),
      ),
    );
  }
}
