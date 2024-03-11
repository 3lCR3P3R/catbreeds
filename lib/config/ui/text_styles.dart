import 'package:catbreeds/config/ui/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle _baseFont = TextStyle(
    color: AppColors.primary,
  );

  static TextStyle header = _baseFont.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
}
