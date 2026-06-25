import 'package:cams/features/occupants/models/option_model.dart';

class OccupantModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final OptionModel gender;
  final OptionModel occupantType;
  final String department;

  OccupantModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.occupantType,
    required this.department,
  });

  factory OccupantModel.fromJson(Map<String, dynamic> json) {
    return OccupantModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: OptionModel.fromJson(json['gender']),
      occupantType: OptionModel.fromJson(json['occupant_type']),
      department: json['department'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender.value,
      'occupant_type': occupantType.value,
      'department': department,
    };
  }
}
