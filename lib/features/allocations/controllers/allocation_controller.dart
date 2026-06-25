import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../buildings/models/building_model.dart';
import '../../buildings/services/building_service.dart';

import '../../rooms/models/room_model.dart';
import '../../rooms/services/room_service.dart';

import '../../occupants/models/occupant_model.dart';
import '../../occupants/services/occupant_service.dart';

import '../models/allocation_model.dart';
import '../services/allocation_service.dart';

class AllocationController extends GetxController {
  final AllocationService _allocationService = Get.find();
  final BuildingService _buildingService = Get.find();
  final RoomService _roomService = Get.find();
  final OccupantService _occupantService = Get.find();

  final allocations = <AllocationModel>[].obs;

  final buildings = <BuildingModel>[].obs;
  final rooms = <RoomModel>[].obs;
  final occupants = <OccupantModel>[].obs;

  final filteredRooms = <RoomModel>[].obs;
  final filteredOccupants = <OccupantModel>[].obs;

  final isLoading = false.obs;
  final isSaving = false.obs;

  final selectedBuildingId = RxnInt();
  final selectedRoomId = RxnInt();
  final selectedOccupantId = RxnInt();

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;

      final results = await Future.wait([
        _allocationService.getAllocations(),
        _buildingService.getBuildings(),
        _roomService.getRooms(),
        _occupantService.getOccupants(),
      ]);

      allocations.value = results[0] as List<AllocationModel>;
      buildings.value = results[1] as List<BuildingModel>;
      rooms.value = results[2] as List<RoomModel>;
      occupants.value = results[3] as List<OccupantModel>;

      filteredRooms.assignAll(rooms);
      filteredOccupants.assignAll(occupants);
    } finally {
      isLoading.value = false;
    }
  }

  void buildingChanged(int? id) {
    selectedBuildingId.value = id;

    selectedRoomId.value = null;

    filteredRooms.value = rooms.where((e) => e.buildingId == id).toList();
  }

  void roomChanged(int? id) {
    selectedRoomId.value = id;
  }

  void occupantChanged(int? id) {
    selectedOccupantId.value = id;
  }

  int get totalAllocations => allocations.length;

  int get activeAllocations =>
      allocations.where((e) => e.status == "active").length;

  int get cancelledAllocations =>
      allocations.where((e) => e.status == "cancelled").length;

  Future<void> createAllocation(Map<String, dynamic> payload) async {
    try {
      isSaving.value = true;

      await _allocationService.createAllocation(payload);

      await loadInitialData();

      Get.back();

      Get.snackbar(
        "Success",
        "Room allocated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data?['message'] ?? e.message ?? "Something went wrong";
        final errors =
            e.response?.data?['errors'] ??
            '\n${e.response?.data?['errors']}' ??
            "Something went wrong";

        Get.snackbar(message, errors, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateAllocation(int id, Map<String, dynamic> payload) async {
    try {
      isSaving.value = true;

      await _allocationService.updateAllocation(id, payload);

      await loadInitialData();

      Get.back();

      Get.snackbar(
        "Success",
        "Allocation updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data?['message'] ?? e.message ?? "Something went wrong";
        final errors =
            e.response?.data?['errors'] ??
            '\n${e.response?.data?['errors']}' ??
            "Something went wrong";

        Get.snackbar(message, errors, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> cancelAllocation(int id) async {
    try {
      await _allocationService.cancelAllocation(id);

      await loadInitialData();

      Get.snackbar(
        "Success",
        "Allocation cancelled",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data?['message'] ?? e.message ?? "Something went wrong";
        final errors =
            e.response?.data?['errors'] ??
            '\n${e.response?.data?['errors']}' ??
            "Something went wrong";

        Get.snackbar(message, errors, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> deleteAllocation(int id) async {
    try {
      await _allocationService.deleteAllocation(id);

      await loadInitialData();

      Get.snackbar(
        "Success",
        "Allocation deleted",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data?['message'] ?? e.message ?? "Something went wrong";
        final errors =
            e.response?.data?['errors'] ??
            '\n${e.response?.data?['errors']}' ??
            "Something went wrong";

        Get.snackbar(message, errors, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
