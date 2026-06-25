import 'package:cams/features/allocations/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/allocation_controller.dart';

class AllocationStats extends GetView<AllocationController> {
  const AllocationStats({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double cardWidth;

    if (width > 1400) {
      cardWidth = (width - 120) / 4;
    } else if (width > 900) {
      cardWidth = (width - 80) / 4.2;
    } else {
      cardWidth = width;
    }

    return Obx(() {
      return Wrap(
        spacing: 20,
        runSpacing: 20,

        children: [
          SizedBox(
            width: cardWidth,
            child: StatusCard(
              title: "Allocations",
              value: controller.totalAllocations.toString(),
              icon: Icons.assignment,
              color: Colors.blue,
            ),
          ),

          SizedBox(
            width: cardWidth,
            child: StatusCard(
              title: "Active",
              value: controller.activeAllocations.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
          ),

          SizedBox(
            width: cardWidth,
            child: StatusCard(
              title: "Cancelled",
              value: controller.cancelledAllocations.toString(),
              icon: Icons.cancel,
              color: Colors.red,
            ),
          ),
        ],
      );
    });
  }
}
