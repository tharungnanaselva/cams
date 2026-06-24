import 'package:cams/core/api/api_client.dart';
import 'package:cams/features/dashboard/models/dashboard_model.dart';
import 'package:dio/dio.dart';

class DashboardService {
  final Dio _dio = ApiClient().dio;

  Future<DashboardModel> getDashboard() async {
    final response = await _dio.get('/dashboard');

    return DashboardModel.fromJson(response.data['data']);
  }
}
