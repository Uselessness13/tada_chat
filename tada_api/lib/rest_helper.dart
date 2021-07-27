import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tada_api/constants.dart';

class RestHelper {
  static late RestHelper _instance;

  late Dio _dio;

  factory RestHelper() {
    return RestHelper._internal();
  }

  static RestHelper internal() {
    _instance = RestHelper();
    return _instance;
  }

  RestHelper._internal() {
    _initDio();
  }

  Dio get _dioClient {
    _initDio();
    return _dio;
  }

  _initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: Constants.BASE_URL,
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );
    _dio = Dio();
    _dio.options = options;

    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
  }

  Future<Response> get(String path) async {
    return _dioClient.get(
      path,
    );
  }
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

_parseAndDecode(String response) {
  try {
    return jsonDecode(response);
  } catch (e) {
    rethrow;
  }
}
