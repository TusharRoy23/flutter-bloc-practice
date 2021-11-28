import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_api/meta_api.dart';
import 'package:meta_api/src/base_api_client.dart';
import 'package:mocktail/mocktail.dart';

import 'resource/fake_response.dart';
import 'package:matcher/matcher.dart';

class MockClientService extends Mock implements BaseApiClient {}

class MockResponse extends Mock implements Response {}

void main() {
  late final MockClientService _mockClientService;
  setUpAll(
    () {
      Environment().initConfig(
        String.fromEnvironment(
          'ENVIRONMENT',
          defaultValue: Environment.DEV,
        ),
      );
      _mockClientService = MockClientService();
    },
  );

  group('Sign In', () {
    test(
      'successfully',
      () async {
        //Arrange
        MockResponse mockResponse = MockResponse();
        //Act
        when(() => mockResponse.statusCode).thenReturn(200);
        // when(() => mockResponse.data).thenReturn(loginData);
        when(
          () => _mockClientService.post(
            'auth/signin/',
            jsonEncode(
              {'username': '', 'password': ''},
            ),
          ),
        ).thenAnswer((_) async => Future.value(
            loginResult)); // This is actually stubbing the Mock value

        var actual = await _mockClientService.post(
            'auth/signin/',
            jsonEncode(
                {'username': '', 'password': ''})); // Receiving the Mock value

        //Assert
        expect(actual, const TypeMatcher<Map<String, dynamic>>());
        verify(
          () => _mockClientService.post(
            'auth/signin/',
            jsonEncode(
              {'username': '', 'password': ''},
            ),
          ),
        ).called(1);
      },
    );

    test('Failed', () async {
      // Arrange

      // Act
      when(
        () => _mockClientService.post(
          'auth/signin/',
          jsonEncode(
            {'username': '', 'password': ''},
          ),
        ),
      ).thenThrow(PostRequestException(message: ['invalid credentials']));
      /*
        We put direct function in *expect()* because we don't want to 
        receive the response instead we are throwing the exception 
      */
      expect(
        () => _mockClientService.post(
          'auth/signin/',
          jsonEncode(
            {'username': '', 'password': ''},
          ),
        ),
        throwsA(isA<PostRequestException>()),
      );
    });
  });
}
