import 'dart:convert';
import 'dart:developer';
import 'package:meta_api/src/base_api_client.dart';

class TodoRequestFailure implements Exception {}

class MetaTodoApiClient {
  final BaseApiClient _baseApiClient;

  MetaTodoApiClient({BaseApiClient? baseApiClient})
      : _baseApiClient = baseApiClient ?? BaseApiClient();

  Future<List?> fetchTodoList() async {
    try {
      var response = await _baseApiClient.get('todo/');

      final todoJson = jsonDecode(response.body) as List;
      return todoJson.toList();
    } catch (e) {
      log('error: $e');
      throw TodoRequestFailure();
    }
  }
}
