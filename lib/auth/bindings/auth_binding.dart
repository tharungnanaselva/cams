import 'package:cams/auth/controllers/login_controller.dart';
import 'package:cams/auth/services/auth_service.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());

    Get.lazyPut<LoginController>(() => LoginController());
  }
}
