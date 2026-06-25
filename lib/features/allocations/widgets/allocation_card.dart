import 'package:cams/features/allocations/widgets/allocation_dialog.dart';
import 'package:cams/shared/datatable/actions.dart';
import 'package:cams/shared/datatable/plain_chip.dart';
import 'package:cams/shared/datatable/table_actions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/allocation_controller.dart';
import '../models/allocation_model.dart';

class AllocationCard extends StatelessWidget {
  final AllocationModel allocation;

  const AllocationCard({super.key, required this.allocation});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllocationController>();

    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    allocation.occupant.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allocation.occupant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        allocation.occupant.occupantType.label,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                TableActionMenu(
                  actions: [
                    TableAction(
                      title: "Edit",
                      icon: Icons.edit,
                      onTap: () {
                        Get.dialog(AllocationDialog(allocation: allocation));
                      },
                    ),

                    TableAction(
                      title: "Cancel Allocation",
                      icon: Icons.cancel_outlined,
                      onTap: () {
                        Get.defaultDialog(
                          title: "Cancel Allocation",

                          middleText: "Are you sure?",

                          textConfirm: "Yes",

                          textCancel: "No",

                          onConfirm: () {
                            Get.back();

                            controller.cancelAllocation(allocation.id);
                          },
                        );
                      },
                    ),

                    TableAction(
                      title: "Delete",
                      icon: Icons.delete,
                      onTap: () {
                        Get.defaultDialog(
                          title: "Delete Allocation",

                          middleText: "Delete permanently?",

                          textConfirm: "Delete",

                          textCancel: "Cancel",

                          onConfirm: () {
                            Get.back();

                            controller.deleteAllocation(allocation.id);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 18),

            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 10),

            _infoRow(Icons.apartment, allocation.room.building),

            const SizedBox(height: 10),

            _infoRow(Icons.meeting_room, "Room ${allocation.room.roomNumber}"),

            const SizedBox(height: 10),

            _infoRow(Icons.hotel, allocation.room.roomType.label),

            const SizedBox(height: 10),

            _infoRow(Icons.people, allocation.room.genderRestriction.label),

            const Spacer(),

            Divider(color: Colors.grey.shade300),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey.shade600,
                ),

                const SizedBox(width: 8),

                Text(DateFormat("dd MMM yyyy").format(allocation.allocatedAt)),

                const Spacer(),

                PlainStatusBadge(status: allocation.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),

        const SizedBox(width: 10),

        Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
