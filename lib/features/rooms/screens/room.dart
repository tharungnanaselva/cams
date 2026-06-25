import 'package:cams/shared/datatable/actions.dart';
import 'package:cams/shared/datatable/datatable.dart';
import 'package:cams/shared/datatable/plain_chip.dart';
import 'package:cams/shared/datatable/table_actions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/layouts/navigation.dart';

import '../controllers/room_controller.dart';
import '../widgets/room_dialog.dart';

class RoomScreen extends GetView<RoomController> {
  const RoomScreen({super.key});

  List<DataColumn2> _columns() {
    return const [
      DataColumn2(label: Text('S No'), size: ColumnSize.S),
      DataColumn2(label: Text('Building'), size: ColumnSize.S),
      DataColumn2(label: Text('Room No'), size: ColumnSize.S),
      DataColumn2(label: Text('Room Type'), size: ColumnSize.S),
      DataColumn2(label: Text('Capacity'), size: ColumnSize.S),
      DataColumn2(label: Text('Gender'), size: ColumnSize.S),
      DataColumn2(label: Text('Status'), size: ColumnSize.S),
      DataColumn2(label: Text('Actions'), size: ColumnSize.S),
    ];
  }

  List<DataRow> _rows() {
    return controller.rooms.asMap().entries.map((entry) {
      final index = entry.key;
      final room = entry.value;

      return DataRow(
        cells: [
          DataCell(Text('${index + 1}')),

          DataCell(Text(room.buildingName)),

          DataCell(Text(room.roomNumber)),

          DataCell(Text(room.roomType.label)),

          DataCell(Text(room.capacity.toString())),

          DataCell(Text(room.genderRestriction.label)),

          DataCell(PlainStatusBadge(status: room.status.label)),

          DataCell(
            TableActionMenu(
              actions: [
                TableAction(
                  title: 'Edit',
                  icon: Icons.edit,
                  onTap: () {
                    Get.dialog(RoomDialog(room: room));
                  },
                ),

                TableAction(
                  title: 'Delete',
                  icon: Icons.delete,
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Delete Room',
                      middleText: 'Are you sure?',

                      textConfirm: 'Delete',

                      textCancel: 'Cancel',

                      onConfirm: () {
                        Get.back();

                        controller.deleteRoom(room.id);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationPanel(
      currentRoute: AppRoutes.rooms,
      child: Scaffold(
        appBar: AppBar(title: const Text('Rooms')),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.dialog(const RoomDialog());
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Room'),
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.rooms.isEmpty) {
            return const Center(child: Text('No Rooms Found'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ResponsiveDataTable(
              minWidth: 1300,

              columns: _columns(),

              rows: _rows(),
            ),
          );
        }),
      ),
    );
  }
}
