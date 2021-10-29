import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BaseApiClient {
  final http.Client _httpClient;
  var storage = FlutterSecureStorage();
  static const _baseUrl = 'http://10.0.2.2:3000/api/';

  BaseApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // Future<Map<String, String>> get authHeader async {
  //   var accessToken = await storage.read(key: 'accessToken');
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': accessToken!,
  //   };
  // }

  // Future<String?> getVal() async {
  //   var accessToken = await storage.read(key: 'accessToken');
  //   return accessToken;
  // }

  // Future<Map<String, String>> authH() async {
  //   var accessToken = await storage.read(key: 'accessToken');
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': accessToken!,
  //   };
  // }

  Map<String, String> get header {
    return {
      'Content-Type': 'application/json',
    };
  }

  Uri makeUrl(String url) => Uri.parse(_baseUrl + url);

  Future<http.Response> get(String url, [bool auth = true]) async {
    var accessToken = await storage.read(key: 'accessToken');
    return await _httpClient.get(
      makeUrl(url),
      // headers: auth ? authHeader : header,
      headers: auth
          ? {
              'Content-Type': 'application/json',
              'Authorization': accessToken!,
            }
          : header,
    );
  }

  Future<http.Response> post(String url, String body,
      [bool auth = false]) async {
    var accessToken = await storage.read(key: 'accessToken');
    return await _httpClient.post(
      makeUrl(url),
      body: body,
      headers: auth
          ? {
              'Content-Type': 'application/json',
              'Authorization': accessToken!,
            }
          : header,
    );
  }

  Future<http.Response> patch(String url, String body) async {
    var accessToken = await storage.read(key: 'accessToken');
    return await _httpClient.patch(
      makeUrl(url),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken!,
      },
    );
  }

  Future<http.Response> delete(String url) async {
    var accessToken = await storage.read(key: 'accessToken');
    return await _httpClient.delete(
      makeUrl(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken!,
      },
    );
  }
}
