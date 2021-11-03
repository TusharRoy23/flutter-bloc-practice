import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta_api/src/constant/endpoints.dart';

class ApiInterceptors extends Interceptor {
  var storage = FlutterSecureStorage();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: EndPoints.connectionTimeout,
      receiveTimeout: EndPoints.receiveTimeout,
    ),
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('requiresToken')) {
      var accessToken = await storage.read(key: 'accessToken');
      // options.headers.addAll({"Authorization": accessToken});
      options.headers.addAll({HttpHeaders.authorizationHeader: accessToken});
    }

    log('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    log('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');

    if (error.requestOptions.headers.containsKey('requiresToken') &&
        error.response?.statusCode == 401) {
      var accessToken = await storage.read(key: 'accessToken');
      var refreshToken = await storage.read(key: 'refreshToken');

      try {
        var response = await _dio.post(
          'auth/refresh-token/',
          data: jsonEncode({
            'refresh_token': refreshToken,
          }),
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: accessToken,
              HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        );

        Map<String, dynamic> value = response.data;
        await storage.write(
            key: 'accessToken', value: 'Bearer ' + value['accessToken']);
        await storage.write(key: 'refreshToken', value: value['refreshToken']);

        error.requestOptions.headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer ' + value['accessToken'],
          HttpHeaders.contentTypeHeader: "application/json",
        });

        final req = await _dio.request(
          error.requestOptions.path,
          options: dio.Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers,
          ),
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters,
        );

        return handler.resolve(req);
      } catch (_) {
        storage.deleteAll();
      }
    }
    super.onError(error, handler);
  }
}
