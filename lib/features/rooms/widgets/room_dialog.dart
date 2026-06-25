import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buildings/models/building_model.dart';
import '../../buildings/services/building_service.dart';
import '../controllers/room_controller.dart';
import '../models/room_model.dart';

class RoomDialog extends StatefulWidget {
  final RoomModel? room;

  const RoomDialog({super.key, this.room});

  @override
  State<RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends State<RoomDialog> {
  final _formKey = GlobalKey<FormState>();

  final RoomController controller = Get.find();

  final BuildingService buildingService = BuildingService();

  final roomNumberController = TextEditingController();
  final capacityController = TextEditingController();

  List<BuildingModel> buildings = [];

  int? buildingId;

  String roomType = 'single';

  String gender = 'male';

  String status = 'available';

  @override
  void initState() {
    super.initState();

    loadBuildings();

    if (widget.room != null) {
      roomNumberController.text = widget.room!.roomNumber;
      capacityController.text = widget.room!.capacity.toString();

      buildingId = widget.room!.buildingId;
      roomType = widget.room!.roomType.value;
      gender = widget.room!.genderRestriction.value;
      status = widget.room!.status.value;
    }
  }

  Future<void> loadBuildings() async {
    buildings = await buildingService.getBuildings();
    setState(() {});
  }

  @override
  void dispose() {
    roomNumberController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.room == null ? 'Add Room' : 'Edit Room'),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Building
                DropdownButtonFormField<int>(
                  initialValue: buildingId,
                  decoration: const InputDecoration(
                    labelText: 'Building',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select building';
                    }
                    return null;
                  },
                  items: buildings
                      .map(
                        (building) => DropdownMenuItem(
                          value: building.id,
                          child: Text(building.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      buildingId = value;
                    });
                  },
                ),

                const SizedBox(height: 15),

                /// Room Number
                TextFormField(
                  controller: roomNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Room Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room number required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// Room Type
                DropdownButtonFormField<String>(
                  initialValue: roomType,
                  decoration: const InputDecoration(
                    labelText: 'Room Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'single', child: Text('Single')),
                    DropdownMenuItem(value: 'double', child: Text('Double')),
                    DropdownMenuItem(value: 'triple', child: Text('Triple')),
                    DropdownMenuItem(
                      value: 'dormitory',
                      child: Text('Dormitory'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      roomType = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                /// Capacity
                TextFormField(
                  controller: capacityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Capacity',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Capacity required';
                    }

                    if (int.tryParse(value) == null) {
                      return 'Invalid number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// Gender
                DropdownButtonFormField<String>(
                  initialValue: gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender Restriction',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('Male')),
                    DropdownMenuItem(value: 'female', child: Text('Female')),
                    DropdownMenuItem(value: 'mixed', child: Text('Mixed')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                /// Status
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'available',
                      child: Text('Available'),
                    ),
                    DropdownMenuItem(
                      value: 'occupied',
                      child: Text('Occupied'),
                    ),
                    DropdownMenuItem(
                      value: 'reserved',
                      child: Text('Reserved'),
                    ),
                    DropdownMenuItem(
                      value: 'maintenance',
                      child: Text('Maintenance'),
                    ),
                    DropdownMenuItem(value: 'blocked', child: Text('Blocked')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),

        Obx(() {
          return ElevatedButton(
            onPressed: controller.isSaving.value
                ? null
                : () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final payload = {
                      'building_id': buildingId,
                      'room_number': roomNumberController.text.trim(),
                      'room_type': roomType,
                      'capacity': int.parse(capacityController.text),
                      'gender_restriction': gender,
                      'status': status,
                    };

                    if (widget.room == null) {
                      await controller.createRoom(payload);
                    } else {
                      await controller.updateRoom(widget.room!.id, payload);
                    }
                  },
            child: controller.isSaving.value
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          );
        }),
      ],
    );
  }
}
