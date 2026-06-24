import 'package:cams/core/routes/app_pages.dart';
import 'package:cams/core/routes/app_routes.dart';
import 'package:cams/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const CAMS());
}

class CAMS extends StatelessWidget {
  const CAMS({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StorageService.isLoggedIn()
          ? AppRoutes.dashboard
          : AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
