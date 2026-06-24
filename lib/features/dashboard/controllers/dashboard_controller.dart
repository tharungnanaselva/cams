import 'package:cams/features/dashboard/models/dashboard_model.dart';
import 'package:cams/features/dashboard/services/dashboard_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();

  final isLoading = true.obs;

  final dashboard = Rxn<DashboardModel>();

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      dashboard.value = await _service.getDashboard();

      update();
    } finally {
      isLoading.value = false;
    }
  }
}
