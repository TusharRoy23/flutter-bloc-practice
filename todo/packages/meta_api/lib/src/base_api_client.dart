import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta_api/src/interceptor/api_interceptor.dart';
import 'constant/endpoints.dart';

class BaseApiClient {
  var storage = FlutterSecureStorage();

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: EndPoints.connectionTimeout,
        receiveTimeout: EndPoints.receiveTimeout),
  )..interceptors.add(ApiInterceptors());

  Future<dynamic> get(String url, [bool auth = true]) async {
    try {
      Response response = await _dio.get(
        url,
        options: dio.Options(
          headers: {"requiresToken": true},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception();
    }
  }

  Future<Map<String, dynamic>?> post(String url, String body,
      [bool auth = false]) async {
    try {
      Response response = await _dio.post(url, data: body);
      return response.data;
    } on DioError catch (e) {
      final errMsg = DioException.fromDioError(e);
      throw PostRequestException(message: errMsg.message);
    }
  }

  Future<Map<String, dynamic>?> patch(String url, String body) async {
    try {
      Response response = await _dio.patch(url, data: body);
      return response.data;
    } on DioError catch (e) {
      final errMsg = DioException.fromDioError(e);
      throw PatchRequestException(message: errMsg.message);
    }
  }

  Future<Map<String, dynamic>?> delete(String url) async {
    try {
      Response response = await _dio.delete(url);
      return response.data;
    } on DioError catch (e) {
      final errMsg = DioException.fromDioError(e);
      throw DeleteRequestException(message: errMsg.message);
    }
  }
}
