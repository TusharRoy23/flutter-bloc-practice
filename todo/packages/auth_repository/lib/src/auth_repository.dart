import 'dart:async';
import 'dart:developer';

import 'package:auth_repository/src/enums/authentication_status.dart';
import 'package:auth_repository/src/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta_api/meta_api.dart';

class AuthenticationFailure implements Exception {}

class UserNotFound implements Exception {}

class AuthRepository {
  final MetaAuthApiClient _authApiClient;
  final _controller = StreamController<AuthenticationStatus>();
  final _tokenController = StreamController<User>();
  var storage = FlutterSecureStorage();

  AuthRepository({MetaAuthApiClient? authApiClient})
      : _authApiClient = authApiClient ?? MetaAuthApiClient();

  Stream<AuthenticationStatus> get status async* {
    var accessToken = await storage.read(key: 'accessToken');
    await Future<void>.delayed(const Duration(seconds: 1));
    yield accessToken!.isNotEmpty
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<User> get token async* {
    var accessToken = await storage.read(key: 'accessToken');
    var refreshToken = await storage.read(key: 'refreshToken');

    await Future<void>.delayed(const Duration(seconds: 1));
    yield User.token(
      accessToken: accessToken!,
      refreshToken: refreshToken!,
    );
    yield* _tokenController.stream;
  }

  Future<User?> doLogin(String username, String password) async {
    try {
      final userInfo = await _authApiClient.doLogin(
        username: username,
        password: password,
      );
      if (userInfo!.username!.isNotEmpty) {
        _controller.add(AuthenticationStatus.authenticated);

        _tokenController.add(
          User.token(
            accessToken: userInfo.token!.accessToken!,
            refreshToken: userInfo.token!.refreshToken!,
          ),
        );

        return User(
          accessToken: userInfo.token!.accessToken!,
          refreshToken: userInfo.token!.refreshToken!,
          userId: userInfo.userInfo!.userId!,
          username: userInfo.username!,
          petName: userInfo.userInfo!.petName,
          photo: userInfo.userInfo!.photo,
        );
      }
      return null;
    } catch (e) {
      throw UserNotFound();
    }
  }

  doLogout() async {
    try {
      await _authApiClient.doLogout();
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (e) {
      throw AuthenticationFailure();
    }
  }

  Future<User> getUser() async {
    try {
      var user = await _authApiClient.getUser();
      return User(
        username: 'username',
        userId: user['id'],
        address: user['address'],
        petName: user['petName'],
        photo: user['photo'],
      );
    } catch (e) {
      throw UserNotFound();
    }
  }

  void dispose() {
    _controller.close();
    _tokenController.close();
  }
}
