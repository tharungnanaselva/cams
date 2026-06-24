import 'package:cams/features/dashboard/controllers/dashboard_controller.dart';
import 'package:cams/features/dashboard/widgets/occupancy_pie_chart.dart';
import 'package:cams/features/dashboard/widgets/summary_bar_chart.dart';
import 'package:cams/shared/layouts/navigation.dart';
import 'package:cams/shared/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationPanel(
      currentRoute: AppRoutes.dashboard,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.dashboard.value == null) {
          return const Center(child: Text('No data found'));
        }

        final data = controller.dashboard.value!;

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),

              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 1000
                    ? 5
                    : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                crossAxisSpacing: 20,
                mainAxisSpacing: 20,

                children: [
                  DashboardCard(
                    title: 'Buildings',
                    value: data.totalBuildings.toString(),
                    icon: Icons.apartment,
                  ),

                  DashboardCard(
                    title: 'Rooms',
                    value: data.totalRooms.toString(),
                    icon: Icons.meeting_room,
                  ),

                  DashboardCard(
                    title: 'Occupied',
                    value: data.occupiedRooms.toString(),
                    icon: Icons.people,
                  ),

                  DashboardCard(
                    title: 'Vacant',
                    value: data.vacantRooms.toString(),
                    icon: Icons.bed,
                  ),

                  DashboardCard(
                    title: 'Occupants',
                    value: data.totalOccupants.toString(),
                    icon: Icons.person,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MediaQuery.of(context).size.width > 1000
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: OccupancyPieChart(data: data),
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: SummaryBarChart(data: data),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: OccupancyPieChart(data: data),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          height: 400,
                          child: SummaryBarChart(data: data),
                        ),
                      ],
                    ),
            ),
          ],
        );
      }),
    );
  }
}
