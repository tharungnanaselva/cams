import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/building_controller.dart';
import '../models/building_model.dart';

class BuildingDialog extends StatefulWidget {
  final BuildingModel? building;

  const BuildingDialog({super.key, this.building});

  @override
  State<BuildingDialog> createState() => _BuildingDialogState();
}

class _BuildingDialogState extends State<BuildingDialog> {
  final controller = Get.find<BuildingController>();

  final nameController = TextEditingController();

  String type = 'student_hostel';

  String genderRestriction = 'male';

  bool status = true;

  @override
  void initState() {
    super.initState();

    if (widget.building != null) {
      nameController.text = widget.building!.name;

      type = widget.building!.type.value;

      genderRestriction = widget.building!.genderRestriction.value;

      status = widget.building!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.building == null ? 'Add Building' : 'Edit Building'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Building Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              initialValue: type,
              items: const [
                DropdownMenuItem(
                  value: 'student_hostel',
                  child: Text('Student Hostel'),
                ),
                DropdownMenuItem(
                  value: 'employee_quarters',
                  child: Text('Employee Quarters'),
                ),
                DropdownMenuItem(
                  value: 'guest_house',
                  child: Text('Guest House'),
                ),
              ],
              onChanged: (value) {
                type = value!;
              },
              decoration: const InputDecoration(
                labelText: 'Building Type',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              initialValue: genderRestriction,
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'mixed', child: Text('Mixed')),
              ],
              onChanged: (value) {
                genderRestriction = value!;
              },
              decoration: const InputDecoration(
                labelText: 'Gender Restriction',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: status,
              title: const Text('Active'),
              onChanged: (value) {
                setState(() {
                  status = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isSaving.value
                ? null
                : () {
                    final payload = {
                      'name': nameController.text,
                      'type': type,
                      'gender_restriction': genderRestriction,
                      'status': status,
                    };

                    if (widget.building == null) {
                      controller.createBuilding(payload);
                    } else {
                      controller.updateBuilding(widget.building!.id, payload);
                    }
                  },
            child: controller.isSaving.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ),
      ],
    );
  }
}
