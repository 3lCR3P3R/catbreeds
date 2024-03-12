import 'package:flutter/material.dart';

class Weight {
  String? imperial;
  String? metric;

  Weight({this.imperial, this.metric});

  factory Weight.fromJson(Map<String, dynamic> json) {
    try {
      return Weight(
        imperial: json['imperial'],
        metric: json['metric'],
      );
    } catch (e) {
      debugPrint('failed in Breed Weight fromJson $e');

      return Weight();
    }
  }

  Map<String, dynamic> toJson() => {
        'imperial': imperial,
        'metric': metric,
      };
}
