import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cams/shared/layouts/navigation.dart';

import '../controllers/building_controller.dart';
import '../models/building_model.dart';
import '../widgets/building_dialog.dart';
import '../../../core/routes/app_routes.dart';

class BuildingScreen extends GetView<BuildingController> {
  const BuildingScreen({super.key});

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

            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1000,
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),

              columns: const [
                DataColumn2(label: Text('S no'), size: ColumnSize.S),

                DataColumn2(label: Text('Name')),

                DataColumn2(label: Text('Type')),

                DataColumn2(label: Text('Gender')),

                DataColumn2(label: Text('Status')),

                DataColumn2(label: Text('Actions'), size: ColumnSize.M),
              ],

              rows: controller.buildings.map((BuildingModel building) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        (controller.buildings.indexOf(building) + 1).toString(),
                      ),
                    ),

                    DataCell(Text(building.name)),

                    DataCell(Text(building.type.label)),

                    DataCell(Text(building.genderRestriction.label)),

                    DataCell(
                      Chip(
                        label: Text(building.status ? 'Active' : 'Inactive'),
                      ),
                    ),

                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.dialog(BuildingDialog(building: building));
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
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
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
