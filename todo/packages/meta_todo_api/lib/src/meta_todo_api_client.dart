import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoRequestFailure implements Exception {}

class MetaTodoApiClient {
  final http.Client _httpClient;
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  MetaTodoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List> fetchTodoList() async {
    final url = Uri.parse('$_baseUrl?_limit=15');
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      throw TodoRequestFailure();
    }

    final todoJson = jsonDecode(response.body) as List;
    return todoJson.toList();
  }
}
