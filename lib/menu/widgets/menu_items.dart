import 'package:flutter/material.dart';

import 'menu_model.dart';
import '../../core/routes/app_routes.dart';

class MenuItems {
  static const items = [
    MenuItem(
      title: 'Dashboard',
      icon: Icons.dashboard,
      route: AppRoutes.dashboard,
    ),

    MenuItem(
      title: 'Buildings',
      icon: Icons.apartment,
      route: AppRoutes.buildings,
    ),

    MenuItem(title: 'Rooms', icon: Icons.meeting_room, route: AppRoutes.rooms),

    MenuItem(
      title: 'Occupants',
      icon: Icons.people,
      route: AppRoutes.occupants,
    ),

    MenuItem(
      title: 'Allocations',
      icon: Icons.assignment,
      route: AppRoutes.allocations,
    ),
  ];
}
