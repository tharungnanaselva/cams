import 'package:cams/core/api/exceptions.dart';
import 'package:cams/core/services/storage_service.dart';
import 'package:dio/dio.dart';

import 'api_constants.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = StorageService.getToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          String message = "Something went wrong";

          switch (e.response?.statusCode) {
            case 400:
              message = e.response?.data["message"] ?? "Bad Request";
              break;

            case 401:
              message = e.response?.data["message"] ?? "Unauthorized";
              break;

            case 403:
              message = e.response?.data["message"] ?? "Forbidden";
              break;

            case 404:
              message = e.response?.data["message"] ?? "Resource not found";
              break;

            case 422:
              message = _validationMessage(e.response?.data);
              break;

            case 500:
              message = e.response?.data["message"] ?? "Internal Server Error";
              break;

            default:
              message =
                  e.response?.data["message"] ?? e.message ?? "Unknown Error";
          }

          handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              error: ApiException(
                message: message,
                statusCode: e.response?.statusCode,
              ),
            ),
          );
        },
      ),
    );
  }

  String _validationMessage(dynamic data) {
    if (data == null) {
      return "Validation failed";
    }

    if (data["errors"] == null) {
      return data["message"] ?? "Validation failed";
    }

    final errors = data["errors"] as Map<String, dynamic>;

    return errors.values.map((e) => (e as List).first.toString()).join("\n");
  }
}
