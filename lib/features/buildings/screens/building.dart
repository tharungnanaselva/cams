import 'package:cams/shared/datatable/actions.dart';
import 'package:cams/shared/datatable/chips.dart';
import 'package:cams/shared/datatable/datatable.dart';
import 'package:cams/shared/datatable/table_actions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cams/shared/layouts/navigation.dart';

import '../controllers/building_controller.dart';
import '../widgets/building_dialog.dart';
import '../../../core/routes/app_routes.dart';

class BuildingScreen extends GetView<BuildingController> {
  const BuildingScreen({super.key});

  List<DataColumn2> _columns() {
    return const [
      DataColumn2(label: Text("S No"), size: ColumnSize.S),
      DataColumn2(label: Text("Name")),
      DataColumn2(label: Text("Type")),
      DataColumn2(label: Text("Gender")),
      DataColumn2(label: Text("Status")),
      DataColumn2(label: Text("Actions")),
    ];
  }

  List<DataRow> _rows() {
    return controller.buildings.asMap().entries.map((entry) {
      final index = entry.key;
      final building = entry.value;

      return DataRow(
        cells: [
          DataCell(Text("${index + 1}")),
          DataCell(Text(building.name)),
          DataCell(Text(building.type.label)),
          DataCell(Text(building.genderRestriction.label)),
          DataCell(StatusBadge(active: building.status)),
          DataCell(
            TableActionMenu(
              actions: [
                TableAction(
                  title: "Edit",
                  icon: Icons.edit,
                  onTap: () {
                    Get.dialog(BuildingDialog(building: building));
                  },
                ),
                TableAction(
                  title: "Delete",
                  icon: Icons.delete,
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Delete Building',

                      middleText: 'Are you sure?',

                      textConfirm: 'Delete',

                      textCancel: 'Cancel',

                      onConfirm: () {
                        Get.back();

                        controller.deleteBuilding(building.id);
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
      currentRoute: AppRoutes.buildings,
      child: Scaffold(
        appBar: AppBar(title: const Text('Buildings')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.dialog(const BuildingDialog());
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Building'),
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.buildings.isEmpty) {
            return const Center(child: Text('No Buildings Found'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),

            child: ResponsiveDataTable(columns: _columns(), rows: _rows()),
          );
        }),
      ),
    );
  }
}
