import 'package:cams/features/rooms/models/option_model.dart';

class RoomModel {
  final int id;
  final int buildingId;
  final String buildingName;
  final String roomNumber;
  final OptionModel roomType;
  final int capacity;
  final OptionModel genderRestriction;
  final OptionModel status;

  RoomModel({
    required this.id,
    required this.buildingId,
    required this.buildingName,
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
    required this.genderRestriction,
    required this.status,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      buildingId: json['building_id'],
      buildingName: json['building_name'] ?? '',
      roomNumber: json['room_number'],
      roomType: OptionModel.fromJson(json['room_type']),
      capacity: json['capacity'],
      genderRestriction: OptionModel.fromJson(json['gender_restriction']),
      status: OptionModel.fromJson(json['status']),
    );
  }
}
