import 'package:get/get.dart';

import '../controllers/building_controller.dart';
import '../services/building_service.dart';

class BuildingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuildingService>(() => BuildingService());

    Get.lazyPut<BuildingController>(() => BuildingController());
  }
}
