import 'package:cams/auth/screens/login.dart';
import 'package:cams/auth/bindings/auth_binding.dart';
import 'package:cams/features/allocations/bindings/allocation_binding.dart';
import 'package:cams/features/allocations/screens/allocation.dart';
import 'package:cams/features/buildings/screens/building.dart';
import 'package:cams/features/dashboard/bindings/dashboard_binding.dart';
import 'package:cams/features/buildings/bindings/building_binding.dart';
import 'package:cams/features/dashboard/screens/dashboard.dart';
import 'package:cams/features/occupants/bindings/occupant_binding.dart';
import 'package:cams/features/occupants/screens/occupant.dart';
import 'package:cams/features/rooms/bindings/room_binding.dart';
import 'package:cams/features/rooms/screens/room.dart';
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
      page: () => const RoomScreen(),
      binding: RoomBinding(),
    ),

    GetPage(
      name: AppRoutes.occupants,
      page: () => const OccupantScreen(),
      binding: OccupantBinding(),
    ),

    GetPage(
      name: AppRoutes.allocations,
      page: () => const AllocationScreen(),
      binding: AllocationBinding(),
    ),
  ];
}
