import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'custom_colors.dart';
import 'custom_text_style.dart';

final themeData = ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: CustomColors.white,
    appBarTheme: AppBarTheme(
      titleTextStyle: CustomTextStyle.robotoRegularLg.copyWith(color: CustomColors.white),
      iconTheme: IconThemeData(color: CustomColors.white),
    ));

final darkThemeData = themeData.copyWith(colorScheme: darkColorScheme);
