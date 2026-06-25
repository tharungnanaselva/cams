import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/room_model.dart';
import '../services/room_service.dart';

class RoomController extends GetxController {
  final RoomService _service = Get.find();

  final rooms = <RoomModel>[].obs;

  final isLoading = false.obs;

  final isSaving = false.obs;

  final horizontalController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    loadRooms();
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;

      rooms.value = await _service.getRooms();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createRoom(Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.createRoom(data);

      await loadRooms();

      Get.back();

      Get.snackbar(
        "Success",
        "Room created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateRoom(int id, Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.updateRoom(id, data);

      await loadRooms();

      Get.back();

      Get.snackbar(
        "Success",
        "Room updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteRoom(int id) async {
    try {
      await _service.deleteRoom(id);

      await loadRooms();

      Get.snackbar(
        "Success",
        "Room deleted",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    horizontalController.dispose();
    super.onClose();
  }
}
