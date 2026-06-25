import 'package:get/get.dart';

import '../../buildings/services/building_service.dart';
import '../../occupants/services/occupant_service.dart';
import '../../rooms/services/room_service.dart';

import '../controllers/allocation_controller.dart';
import '../services/allocation_service.dart';

class AllocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllocationService>(() => AllocationService());

    Get.lazyPut<BuildingService>(() => BuildingService(), fenix: true);

    Get.lazyPut<RoomService>(() => RoomService(), fenix: true);

    Get.lazyPut<OccupantService>(() => OccupantService(), fenix: true);

    Get.lazyPut<AllocationController>(() => AllocationController());
  }
}
