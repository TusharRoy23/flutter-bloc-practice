import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:meta_todo_api/src/models/model.dart';

class TodoRequestFailure implements Exception {}

class MetaTodoApiClient {
  final http.Client _httpClient;
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  MetaTodoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List> fetchTodoList() async {
    final url = Uri.parse('$_baseUrl?_limit=10');
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      throw TodoRequestFailure();
    }

    final todoJson = jsonDecode(response.body) as List;
    return todoJson.toList();
  }
}
