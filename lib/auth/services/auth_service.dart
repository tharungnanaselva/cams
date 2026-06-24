import 'package:cams/core/api/api_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (_) {
      throw Exception('Something went wrong');
    }
  }

  Exception _handleDioException(DioException e) {
    if (e.response != null) {
      return Exception(e.response?.data['message'] ?? 'Request failed');
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');

      case DioExceptionType.receiveTimeout:
        return Exception('Server timeout');

      case DioExceptionType.connectionError:
        return Exception('Unable to connect to server');

      default:
        return Exception('Unexpected error occurred');
    }
  }
}
