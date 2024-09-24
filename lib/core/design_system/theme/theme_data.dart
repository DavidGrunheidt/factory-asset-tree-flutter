import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'custom_colors.dart';

final themeData = ThemeData(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: CustomColors.white,
);

final darkThemeData = themeData.copyWith(colorScheme: darkColorScheme);
