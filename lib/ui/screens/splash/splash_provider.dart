import 'dart:math';

import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  SplashProvider() {
    _rndValue = _random.nextInt(_catImageIds.length);
  }

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
