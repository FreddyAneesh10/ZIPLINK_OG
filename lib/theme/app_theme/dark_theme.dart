import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Colors.red,
    secondary: Colors.blue,
    surface: AppColors.black,
  ),
  scaffoldBackgroundColor: AppColors.black,
);
