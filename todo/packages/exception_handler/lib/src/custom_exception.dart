import 'package:dio/dio.dart';

class GetRequestException implements Exception {
  List<dynamic> message;

  GetRequestException({
    required this.message,
  });
}

class PostRequestException implements Exception {
  List<dynamic> message;

  PostRequestException({
    required this.message,
  });
}

class PatchRequestException implements Exception {
  List<dynamic> message;

  PatchRequestException({
    required this.message,
  });
}

class DeleteRequestException implements Exception {
  List<dynamic> message;

  DeleteRequestException({
    required this.message,
  });
}

class DioException implements Exception {
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = ["Request to API server was cancelled"];
        break;
      case DioErrorType.connectTimeout:
        message = ["Connection timeout with API server"];
        break;
      case DioErrorType.other:
        message = [
          "Connection to API server failed due to internet connection"
        ];
        break;
      case DioErrorType.receiveTimeout:
        message = ["Receive timeout in connection with API server"];
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = ["Send timeout in connection with API server"];
        break;
      default:
        message = ["Something went wrong"];
        break;
    }
  }

  List<dynamic> message = [];

  List<dynamic> _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:

      case 401:
        return error["message"] is String
            ? [error["message"]]
            : error["message"];
      case 404:
        return error["message"];
      case 500:
        return ['Internal server error'];
      default:
        return ['Oops something went wrong'];
    }
  }
}
