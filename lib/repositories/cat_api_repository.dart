import 'package:flutter/material.dart';

import 'package:catbreeds/config/api/api_helper.dart';
import 'package:catbreeds/models/breed/breed.dart';

CatApiRepository get catRepository => CatApiRepository();

class CatApiRepository {
  factory CatApiRepository() => _instance;

  CatApiRepository._internal();

  static final CatApiRepository _instance = CatApiRepository._internal();

  /// getBread
  ///
  /// Get Breed from api
  ///
  /// return [breed] list
  Future<List<dynamic>> getBreeds() async {
    try {
      /// TODO: this can improve it
      final result = await ApiHelper().getBreeds();

      if (result.isEmpty) return [];

      return result.map((e) => Breed.fromJson(e)).toList();
    } catch (e) {
      debugPrint('failed in getBreeds repository: $e');

      return [];
    }
  }

  Future<List<dynamic>> getBreedsLimit({int page = 0, int limit = 5}) async {
    try {
      final result = await ApiHelper().getBreedsLimit(page: page, limit: limit);

      if (result.isEmpty) return [];

      return result.map((e) => Breed.fromJson(e)).toList();
    } catch (e) {
      debugPrint('failed in getBreeds repository: $e');

      return [];
    }
  }
}
