import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta_api/src/base_api_client.dart';
import 'package:meta_api/src/model/token.dart';
import 'package:meta_api/src/model/user.dart';
import 'package:meta_api/src/model/user_info.dart';

class AuthenticationFailure implements Exception {}

class UserNotFound implements Exception {}

class MetaAuthApiClient {
  var storage = FlutterSecureStorage();
  final BaseApiClient _baseApiClient;
  MetaAuthApiClient({BaseApiClient? baseApiClient})
      : _baseApiClient = baseApiClient ?? BaseApiClient();

  Future<User?> doLogin({String username = '', String password = ''}) async {
    try {
      var response = await _baseApiClient.post(
        'auth/signin/',
        jsonEncode({'username': username, 'password': password}),
      );

      Map<String, dynamic> userMap = jsonDecode(response.body);
      await storage.write(
          key: 'accessToken', value: 'Bearer ' + userMap['accessToken']);
      await storage.write(key: 'refreshToken', value: userMap['refreshToken']);

      Token token = Token(
        accessToken: userMap['accessToken'],
        refreshToken: userMap['refreshToken'],
      );
      UserInfo userInfo = UserInfo(
        address: userMap['user']['user_info']['address'],
        petName: userMap['user']['user_info']['petName'],
        photo: userMap['user']['user_info']['photo'],
        userId: userMap['user']['user_info']['id'],
      );
      User users = User(
        token: token,
        userInfo: userInfo,
        username: userMap['user']['username'],
      );
      var user = User.fromJson(users.toJson());
      return user;
    } catch (_) {
      throw UserNotFound();
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      var response = await _baseApiClient.get('user/');
      return jsonDecode(response.body);
    } catch (_) {
      throw UserNotFound();
    }
  }

  doLogout() async {
    try {
      var response = await _baseApiClient.get('auth/logout/');
      storage.deleteAll();
    } catch (_) {
      throw AuthenticationFailure();
    }
  }
}
