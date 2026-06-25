import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/occupant_controller.dart';
import '../models/occupant_model.dart';

class OccupantDialog extends StatefulWidget {
  final OccupantModel? occupant;

  const OccupantDialog({super.key, this.occupant});

  @override
  State<OccupantDialog> createState() => _OccupantDialogState();
}

class _OccupantDialogState extends State<OccupantDialog> {
  final _formKey = GlobalKey<FormState>();

  final OccupantController controller = Get.find();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final departmentController = TextEditingController();

  String gender = 'male';
  String occupantType = 'student';

  @override
  void initState() {
    super.initState();

    if (widget.occupant != null) {
      nameController.text = widget.occupant!.name;
      emailController.text = widget.occupant!.email;
      phoneController.text = widget.occupant!.phone;
      departmentController.text = widget.occupant!.department;

      gender = widget.occupant!.gender.value;
      occupantType = widget.occupant!.occupantType.value;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.occupant == null ? 'Add Occupant' : 'Edit Occupant'),

      content: SizedBox(
        width: 450,

        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                /// Name
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }

                    if (!GetUtils.isEmail(value)) {
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// Phone
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone is required';
                    }

                    if (value.length != 10) {
                      return 'Enter valid phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                /// Gender
                DropdownButtonFormField<String>(
                  initialValue: gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('Male')),

                    DropdownMenuItem(value: 'female', child: Text('Female')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                /// Occupant Type
                DropdownButtonFormField<String>(
                  initialValue: occupantType,
                  decoration: const InputDecoration(
                    labelText: 'Occupant Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'student', child: Text('Student')),

                    DropdownMenuItem(
                      value: 'employee',
                      child: Text('Employee'),
                    ),

                    DropdownMenuItem(value: 'guest', child: Text('Guest')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      occupantType = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                /// Department
                TextFormField(
                  controller: departmentController,
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),

        Obx(() {
          return FilledButton(
            onPressed: controller.isSaving.value
                ? null
                : () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final payload = {
                      'name': nameController.text.trim(),

                      'email': emailController.text.trim(),

                      'phone': phoneController.text.trim(),

                      'gender': gender,

                      'occupant_type': occupantType,

                      'department': departmentController.text.trim(),
                    };

                    if (widget.occupant == null) {
                      await controller.createOccupant(payload);
                    } else {
                      await controller.updateOccupant(
                        widget.occupant!.id,
                        payload,
                      );
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
