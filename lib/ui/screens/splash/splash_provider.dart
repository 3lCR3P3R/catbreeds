import 'dart:math';
import 'package:catbreeds/config/routes/router_path.dart';
import 'package:flutter/material.dart';

import 'package:catbreeds/main.dart';

class SplashProvider with ChangeNotifier {
  SplashProvider() {
    _setRandomValue();
    _goHome();
  }

  void _setRandomValue() => _rndValue = _random.nextInt(_catImageIds.length);

  void _goHome() => Future.delayed(
        const Duration(milliseconds: 1500),
        () => Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          AppRoutes.home,
          (route) => false,
        ),
      );

  final Random _random = Random();
  int _rndValue = 0;

  final List<String> _catImageIds = [
    '0XYvRd7oD',
    'xnsqonbjW',
    'k71ULYfRr',
    '13MkvUreZ',
    'ozEvzdVM-',
    // 'O3btzLlsO', // dont 'work' because is png
  ];

  String getImageByRandomId() {
    return 'https://cdn2.thecatapi.com/images/${_catImageIds[_rndValue]}.jpg';
  }
}
