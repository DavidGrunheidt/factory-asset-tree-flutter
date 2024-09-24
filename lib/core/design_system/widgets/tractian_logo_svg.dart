import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_assets.dart';

class TractianLogoSvg extends StatelessWidget {
  final double screenWidthPercentage;
  final double maxWidth;
  final String logoAssetPath;

  const TractianLogoSvg({
    super.key,
    this.screenWidthPercentage = 0.3,
    this.maxWidth = 300,
    this.logoAssetPath = AppAssets.tractianHorizontalWhiteLogo,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidth = MediaQuery.sizeOf(context).width * screenWidthPercentage;
    return SvgPicture.asset(
      logoAssetPath,
      width: min(logoWidth, maxWidth),
      semanticsLabel: 'Enterprise Journal Logo',
    );
  }
}
