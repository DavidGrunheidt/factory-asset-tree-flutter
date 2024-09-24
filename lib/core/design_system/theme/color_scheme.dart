import 'package:flutter/material.dart';

import 'custom_colors.dart';

const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: CustomColors.black,
  onPrimary: CustomColors.white,
  secondary: CustomColors.black,
  onSecondary: CustomColors.white,
  error: CustomColors.error,
  onError: CustomColors.white,
  surface: CustomColors.white,
  onSurface: CustomColors.black,
);

final darkColorScheme = colorScheme.copyWith(brightness: Brightness.dark);
