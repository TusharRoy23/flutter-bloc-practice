import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_api/meta_api.dart';
import 'package:meta_api/src/model/user.dart';
import 'package:mocktail/mocktail.dart';

import 'resource/fake_response.dart';

class MockAuthApiSevice extends Mock implements MetaAuthApiClient {}

class MockResponse extends Mock implements Response {}

void main() {
  late final MockAuthApiSevice _mockAuthApiSevice;

  setUpAll(() {
    _mockAuthApiSevice = MockAuthApiSevice();
  });

  group('Auth Test - ', () {
    test('Successfully Logged in', () async {
      // Arrange
      final mockResponse = MockResponse();
      // Act
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(loginResult);
      when(() => _mockAuthApiSevice.doLogin(username: '', password: ''))
          .thenAnswer((_) async => userResult);

      final actualResponse =
          await _mockAuthApiSevice.doLogin(username: '', password: '');

      // Assert
      expect(actualResponse, const TypeMatcher<User>());
    });
  });
}
