import 'package:get/get.dart';

import '../models/building_model.dart';
import '../services/building_service.dart';

class BuildingController extends GetxController {
  final BuildingService _service = Get.find<BuildingService>();

  final buildings = <BuildingModel>[].obs;

  final isLoading = false.obs;

  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBuildings();
  }

  Future<void> loadBuildings() async {
    try {
      isLoading.value = true;

      buildings.value = await _service.getBuildings();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createBuilding(Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.createBuilding(data);

      await loadBuildings();

      Get.back();

      Get.snackbar(
        'Success',
        'Building created',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateBuilding(int id, Map<String, dynamic> data) async {
    try {
      isSaving.value = true;

      await _service.updateBuilding(id, data);

      await loadBuildings();

      Get.back();

      Get.snackbar(
        'Success',
        'Building updated',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteBuilding(int id) async {
    try {
      await _service.deleteBuilding(id);

      await loadBuildings();

      Get.snackbar(
        'Success',
        'Building deleted',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
