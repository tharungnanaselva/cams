import 'package:cams/shared/datatable/actions.dart';
import 'package:cams/shared/datatable/datatable.dart';
import 'package:cams/shared/datatable/table_actions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../shared/layouts/navigation.dart';

import '../controllers/occupant_controller.dart';
import 'package:cams/features/occupants/widgets/occupant_dialog.dart';

class OccupantScreen extends GetView<OccupantController> {
  const OccupantScreen({super.key});

  List<DataColumn2> _columns() {
    return const [
      DataColumn2(label: Text('S No'), size: ColumnSize.S),
      DataColumn2(label: Text('Name'), size: ColumnSize.S),
      DataColumn2(label: Text('Email'), size: ColumnSize.S),
      DataColumn2(label: Text('Phone'), size: ColumnSize.S),
      DataColumn2(label: Text('Gender'), size: ColumnSize.S),
      DataColumn2(label: Text('Type'), size: ColumnSize.S),
      DataColumn2(label: Text('Department'), size: ColumnSize.S),
      DataColumn2(label: Text('Actions'), size: ColumnSize.S),
    ];
  }

  List<DataRow> _rows() {
    return controller.occupants.asMap().entries.map((entry) {
      final index = entry.key;
      final occupant = entry.value;

      return DataRow(
        cells: [
          DataCell(Text('${index + 1}')),

          DataCell(Text(occupant.name)),

          DataCell(Text(occupant.email)),

          DataCell(Text(occupant.phone)),

          DataCell(Text(occupant.gender.label)),

          DataCell(Text(occupant.occupantType.label)),

          DataCell(Text(occupant.department)),

          DataCell(
            TableActionMenu(
              actions: [
                TableAction(
                  title: 'Edit',

                  icon: Icons.edit,

                  onTap: () {
                    Get.dialog(OccupantDialog(occupant: occupant));
                  },
                ),

                TableAction(
                  title: 'Delete',

                  icon: Icons.delete,

                  onTap: () {
                    Get.defaultDialog(
                      title: 'Delete Occupant',

                      middleText:
                          'Are you sure you want to delete this occupant?',

                      textConfirm: 'Delete',

                      textCancel: 'Cancel',

                      onConfirm: () {
                        Get.back();

                        controller.deleteOccupant(occupant.id);
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
      currentRoute: AppRoutes.occupants,

      child: Scaffold(
        appBar: AppBar(title: const Text('Occupants')),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.dialog(const OccupantDialog());
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Occupant'),
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.occupants.isEmpty) {
            return const Center(child: Text('No Occupants Found'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),

            child: ResponsiveDataTable(
              minWidth: 1400,

              columns: _columns(),

              rows: _rows(),
            ),
          );
        }),
      ),
    );
  }
}
