import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/building_model.dart';

class BuildingService {
  final Dio _dio = ApiClient().dio;

  Future<List<BuildingModel>> getBuildings() async {
    final response = await _dio.get('/buildings');

    return (response.data['data'] as List)
        .map((e) => BuildingModel.fromJson(e))
        .toList();
  }

  Future<void> createBuilding(Map<String, dynamic> data) async {
    await _dio.post('/buildings', data: data);
  }

  Future<void> updateBuilding(int id, Map<String, dynamic> data) async {
    await _dio.put('/buildings/$id', data: data);
  }

  Future<void> deleteBuilding(int id) async {
    await _dio.delete('/buildings/$id');
  }
}
