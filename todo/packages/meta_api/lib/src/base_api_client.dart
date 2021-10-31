import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class BaseApiClient {
  final http.Client _httpClient;
  var storage = FlutterSecureStorage();
  static const _baseUrl = 'http://10.0.2.2:3000/api/';

  BaseApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Map<String, String> get header {
    return {
      'Content-Type': 'application/json',
    };
  }

  Uri makeUrl(String url) => Uri.parse(_baseUrl + url);

  Future<http.Response> commonGetway({
    String method = 'GET',
    bool auth = true,
    String url = "",
    String body = "",
  }) async {
    var response;
    try {
      var accessToken = auth ? await storage.read(key: 'accessToken') : '';
      var request = new http.Request(method, makeUrl(url));
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      if (auth) request.headers[HttpHeaders.authorizationHeader] = accessToken!;
      if (body.isNotEmpty) request.body = body;

      var streamResp = await _httpClient.send(request);
      response = _response(await http.Response.fromStream(streamResp));
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:

      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }

  Future<http.Response> get(String url, [bool auth = true]) async {
    // var value = await sendingRequest('get', url, '', true);
    // log('value: $value');
    // return value;
    return await commonGetway(method: 'GET', auth: auth, url: url);
  }

  Future<http.Response> post(String url, String body,
      [bool auth = false]) async {
    // return await sendingRequest(
    //   'post',
    //   url,
    //   body,
    // );
    return await commonGetway(method: 'POST', auth: auth, url: url, body: body);
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

  Future<http.Response?> sendingRequest(String httpRequest, String url,
      [String body = '', bool auth = false]) async {
    var accessToken = auth ? await storage.read(key: 'accessToken') : '';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };
    if (httpRequest == 'get') {
      var response = await _httpClient.get(
        makeUrl(url),
        headers: auth ? headers : header,
      );

      if (response.statusCode == 401 && accessToken.isNotEmpty) {
        // unauthorized
        await sendingRefreshToken(httpRequest, url, body, auth);
      } else {
        log('receive response: ${response.body}');
        return response;
      }
    } else if (httpRequest == 'post') {
      var response = await _httpClient.post(
        makeUrl(url),
        body: body,
        headers: auth ? headers : header,
      );

      if (response.statusCode == 401 && accessToken.isNotEmpty) {
        // unauthorized
        await sendingRefreshToken(httpRequest, url, body, auth);
      } else {
        return response;
      }
    } else if (httpRequest == 'patch') {
      var response = await _httpClient.patch(
        makeUrl(url),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 401 && accessToken.isNotEmpty) {
        // unauthorized
        await sendingRefreshToken(httpRequest, url, body, auth);
      } else {
        return response;
      }
    } else if (httpRequest == 'delete') {
      var response = await _httpClient.delete(
        makeUrl(url),
        headers: headers,
      );
      if (response.statusCode == 401 && accessToken.isNotEmpty) {
        // unauthorized
        await sendingRefreshToken(httpRequest, url, body, auth);
      } else {
        return response;
      }
    }
  }

  Future<void> sendingRefreshToken(String httpRequest, String url,
      [String body = '', bool auth = false]) async {
    var refreshToken = await storage.read(key: 'refreshToken');
    var accessToken = await storage.read(key: 'accessToken');

    var response = await _httpClient.post(
      makeUrl('auth/refresh-token/'),
      body: jsonEncode({'refresh_token': refreshToken}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken!,
      },
    );
    if (response.statusCode != 401) {
      Map<String, dynamic> value = jsonDecode(response.body);
      await storage.write(
          key: 'accessToken', value: 'Bearer ' + value['accessToken']!);
      await storage.write(key: 'refreshToken', value: value['refreshToken']!);
      sendingRequest(httpRequest, url, body, auth);
    }
    return null;
  }
}
