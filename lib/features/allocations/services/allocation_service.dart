import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/allocation_model.dart';

class AllocationService {
  final Dio _dio = ApiClient().dio;

  Future<List<AllocationModel>> getAllocations() async {
    final response = await _dio.get('/allocations');

    return (response.data['data'] as List)
        .map((e) => AllocationModel.fromJson(e))
        .toList();
  }

  Future<void> createAllocation(Map<String, dynamic> data) async {
    await _dio.post('/allocations', data: data);
  }

  Future<void> updateAllocation(int id, Map<String, dynamic> data) async {
    await _dio.put('/allocations/$id', data: data);
  }

  Future<void> deleteAllocation(int id) async {
    await _dio.delete('/allocations/$id');
  }

  Future<void> cancelAllocation(int id) async {
    await _dio.post('/allocations/$id/cancel');
  }
}
