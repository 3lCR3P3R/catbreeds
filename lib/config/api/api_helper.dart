import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:catbreeds/config/api/api_const.dart';
import 'package:catbreeds/config/env.dart';

class ApiHelper {
  factory ApiHelper() {
    return _singleton;
  }

  ApiHelper._internal();
  static final ApiHelper _singleton = ApiHelper._internal();

  final Map<String, String> _headers = {
    'Access-Control-Allow-Origin': '*',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<http.Response> _get({
    required String url,
    Map<String, String>? header,
  }) async {
    final headers = {
      ..._headers,
      if (header != null) ...header,
    };

    final http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> getBreeds() async {
    try {
      final response = await _get(url: ApiConst.breedsPath, header: {
        'x-api-key': Env.apiKey,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      debugPrint('failed in getBreeds: $e');
      return [];
    }
  }

  Future<dynamic> getBreedsLimit({int page = 0, int limit = 5}) async {
    try {
      final response = await _get(
          url: '${ApiConst.breedsPath}?limit=$limit&page=$page',
          header: {
            'x-api-key': Env.apiKey,
          });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];
    } catch (e) {
      debugPrint('failed in getBreeds: $e');
      return [];
    }
  }
}
