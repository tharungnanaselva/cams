import 'package:cams/features/allocations/layouts/allocation_status.dart';
import 'package:cams/features/allocations/widgets/allocation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/layouts/navigation.dart';

import '../controllers/allocation_controller.dart';
import '../widgets/allocation_dialog.dart';

class AllocationScreen extends GetView<AllocationController> {
  const AllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationPanel(
      currentRoute: AppRoutes.allocations,

      child: Scaffold(
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: controller.loadInitialData,

            child: ListView(
              padding: const EdgeInsets.all(24),

              children: [
                _header(context),

                const SizedBox(height: 20),

                AllocationStats(),

                const SizedBox(height: 20),

                const Text(
                  "Current Allocations",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                _allocationGrid(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Room Allocation",

              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 6),

            Text("Assign hostel rooms to occupants"),
          ],
        ),

        width > 600
            ? FilledButton.icon(
                icon: const Icon(Icons.add),

                label: const Text("Allocate Room"),

                onPressed: () {
                  Get.dialog(const AllocationDialog());
                },
              )
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Get.dialog(const AllocationDialog());
                },
              ),
      ],
    );
  }

  Widget _allocationGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;

    if (width > 1400) {
      crossAxisCount = 3;
    } else if (width > 900) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: controller.allocations.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,

        crossAxisSpacing: 20,

        mainAxisSpacing: 20,

        // childAspectRatio: width > 700
        //     ? 1.6
        //     : width > 1100
        //     ? 1.2
        //     : 1.0,
      ),

      itemBuilder: (_, index) {
        return AllocationCard(allocation: controller.allocations[index]);
      },
    );
  }
}
