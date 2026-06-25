import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/occupant_model.dart';

class OccupantService {
  final Dio _dio = ApiClient().dio;

  Future<List<OccupantModel>> getOccupants() async {
    final response = await _dio.get('/occupants');

    return (response.data['data'] as List)
        .map((e) => OccupantModel.fromJson(e))
        .toList();
  }

  Future<void> createOccupant(Map<String, dynamic> data) async {
    await _dio.post('/occupants', data: data);
  }

  Future<void> updateOccupant(int id, Map<String, dynamic> data) async {
    await _dio.put('/occupants/$id', data: data);
  }

  Future<void> deleteOccupant(int id) async {
    await _dio.delete('/occupants/$id');
  }
}
