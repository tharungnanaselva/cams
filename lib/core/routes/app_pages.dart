import 'package:cams/auth/screens/login.dart';
import 'package:cams/auth/bindings/auth_binding.dart';
import 'package:cams/features/buildings/screens/building.dart';
import 'package:cams/features/dashboard/bindings/dashboard_binding.dart';
import 'package:cams/features/buildings/bindings/building_binding.dart';
import 'package:cams/features/dashboard/screens/dashboard.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),

    GetPage(
      name: AppRoutes.buildings,
      page: () => const BuildingScreen(),
      binding: BuildingBinding(),
    ),

    GetPage(
      name: AppRoutes.rooms,
      page: () => const BuildingScreen(),
      binding: BuildingBinding(),
    ),

    GetPage(
      name: AppRoutes.occupants,
      page: () => const BuildingScreen(),
      binding: BuildingBinding(),
    ),

    GetPage(
      name: AppRoutes.allocations,
      page: () => const BuildingScreen(),
      binding: BuildingBinding(),
    ),
  ];
}
