import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../models/room_model.dart';

class RoomService {
  final Dio _dio = ApiClient().dio;

  Future<List<RoomModel>> getRooms() async {
    final response = await _dio.get('/rooms');

    return (response.data['data'] as List)
        .map((e) => RoomModel.fromJson(e))
        .toList();
  }

  Future<void> createRoom(Map<String, dynamic> data) async {
    await _dio.post('/rooms', data: data);
  }

  Future<void> updateRoom(int id, Map<String, dynamic> data) async {
    await _dio.put('/rooms/$id', data: data);
  }

  Future<void> deleteRoom(int id) async {
    await _dio.delete('/rooms/$id');
  }

  Future<void> getBuildings() async {
    await _dio.get('/buildings');
  }
}
