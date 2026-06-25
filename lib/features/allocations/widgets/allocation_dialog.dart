import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buildings/models/building_model.dart';
import '../../occupants/models/occupant_model.dart';
import '../../rooms/models/room_model.dart';

import '../controllers/allocation_controller.dart';
import '../models/allocation_model.dart';

class AllocationDialog extends StatefulWidget {
  final AllocationModel? allocation;

  const AllocationDialog({super.key, this.allocation});

  @override
  State<AllocationDialog> createState() => _AllocationDialogState();
}

class _AllocationDialogState extends State<AllocationDialog> {
  final controller = Get.find<AllocationController>();

  final _formKey = GlobalKey<FormState>();

  int? buildingId;
  int? roomId;
  int? occupantId;

  @override
  void initState() {
    super.initState();

    if (widget.allocation != null) {
      buildingId = widget.allocation!.room.buildingId;
      roomId = widget.allocation!.room.id;
      occupantId = widget.allocation!.occupant.id;

      controller.buildingChanged(buildingId);
      controller.roomChanged(roomId);
      controller.occupantChanged(occupantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Allocate Room",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                Obx(() {
                  return DropdownButtonFormField<int>(
                    initialValue: buildingId,
                    decoration: const InputDecoration(
                      labelText: "Building",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.buildings.map((BuildingModel building) {
                      return DropdownMenuItem(
                        value: building.id,
                        child: Text(building.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        buildingId = value;
                        roomId = null;
                      });

                      controller.buildingChanged(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Select Building";
                      }
                      return null;
                    },
                  );
                }),

                const SizedBox(height: 18),

                Obx(() {
                  return DropdownButtonFormField<int>(
                    initialValue: roomId,
                    decoration: const InputDecoration(
                      labelText: "Room",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.filteredRooms.map((RoomModel room) {
                      return DropdownMenuItem(
                        value: room.id,
                        child: Text(room.roomNumber),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        roomId = value;
                      });

                      controller.roomChanged(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Select Room";
                      }
                      return null;
                    },
                  );
                }),

                const SizedBox(height: 18),

                Obx(() {
                  return DropdownButtonFormField<int>(
                    initialValue: occupantId,
                    decoration: const InputDecoration(
                      labelText: "Occupant",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.occupants.map((OccupantModel occupant) {
                      return DropdownMenuItem(
                        value: occupant.id,
                        child: Text(occupant.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        occupantId = value;
                      });

                      controller.occupantChanged(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Select Occupant";
                      }
                      return null;
                    },
                  );
                }),

                const SizedBox(height: 25),

                Obx(() {
                  if (controller.selectedRoomId.value == null) {
                    return const SizedBox();
                  }

                  final room = controller.rooms.firstWhere(
                    (e) => e.id == controller.selectedRoomId.value,
                  );

                  return Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _info("Building", room.buildingName),

                          _info("Room", room.roomNumber),

                          _info("Capacity", room.capacity.toString()),

                          _info("Room Type", room.roomType.label),

                          _info("Gender", room.genderRestriction.label),

                          _info("Status", room.status.label),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text("Cancel"),
                    ),

                    const SizedBox(width: 10),

                    Obx(() {
                      return FilledButton(
                        onPressed: controller.isSaving.value
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                final payload = {
                                  "room_id": roomId,
                                  "occupant_id": occupantId,
                                };

                                if (widget.allocation == null) {
                                  await controller.createAllocation(payload);
                                } else {
                                  await controller.updateAllocation(
                                    widget.allocation!.id,
                                    payload,
                                  );
                                }
                              },
                        child: controller.isSaving.value
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Allocate"),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
