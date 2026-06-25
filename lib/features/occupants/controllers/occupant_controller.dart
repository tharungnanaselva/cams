import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/occupant_model.dart';
import '../services/occupant_service.dart';

class OccupantController extends GetxController {
  final OccupantService _service = Get.find();

  final occupants = <OccupantModel>[].obs;

  final isLoading = false.obs;

  final isSaving = false.obs;

  final horizontalController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadOccupants();
  }

  Future<void> loadOccupants() async {
    try {
      isLoading.value = true;

      occupants.value = await _service.getOccupants();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOccupant(Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.createOccupant(data);

      await loadOccupants();

      Get.back();

      Get.snackbar(
        'Success',
        'Occupant created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateOccupant(int id, Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.updateOccupant(id, data);

      await loadOccupants();

      Get.back();

      Get.snackbar(
        'Success',
        'Occupant updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteOccupant(int id) async {
    try {
      await _service.deleteOccupant(id);

      await loadOccupants();

      Get.snackbar(
        'Success',
        'Occupant deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    horizontalController.dispose();
    super.onClose();
  }
}
