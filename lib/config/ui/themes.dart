import 'package:catbreeds/config/ui/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData app = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
  );
}
