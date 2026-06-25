import 'package:get/get.dart';

import '../controllers/occupant_controller.dart';
import '../services/occupant_service.dart';

class OccupantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OccupantService>(() => OccupantService());

    Get.lazyPut<OccupantController>(() => OccupantController());
  }
}
