import 'package:cams/features/allocations/models/option_model.dart';

class AllocationModel {
  final int id;
  final AllocationRoom room;
  final AllocationOccupant occupant;
  final DateTime allocatedAt;
  final String status;

  AllocationModel({
    required this.id,
    required this.room,
    required this.occupant,
    required this.allocatedAt,
    required this.status,
  });

  factory AllocationModel.fromJson(Map<String, dynamic> json) {
    return AllocationModel(
      id: json['id'],
      room: AllocationRoom.fromJson(json['room']),
      occupant: AllocationOccupant.fromJson(json['occupant']),
      allocatedAt: DateTime.parse(json['allocated_at']),
      status: json['status'],
    );
  }
}

class AllocationRoom {
  final int id;
  final int buildingId;
  final String building;
  final String roomNumber;
  final int capacity;
  final OptionModel roomType;
  final OptionModel genderRestriction;
  final OptionModel status;

  AllocationRoom({
    required this.id,
    required this.buildingId,
    required this.building,
    required this.roomNumber,
    required this.capacity,
    required this.roomType,
    required this.genderRestriction,
    required this.status,
  });

  factory AllocationRoom.fromJson(Map<String, dynamic> json) {
    return AllocationRoom(
      id: json['id'],
      buildingId: json['building_id'],
      building: json['building'],
      roomNumber: json['room_number'],
      capacity: json['capacity'],
      roomType: OptionModel.fromJson(json['room_type']),
      genderRestriction: OptionModel.fromJson(json['gender_restriction']),
      status: OptionModel.fromJson(json['status']),
    );
  }
}

class AllocationOccupant {
  final int id;
  final String name;
  final OptionModel gender;
  final OptionModel occupantType;

  AllocationOccupant({
    required this.id,
    required this.name,
    required this.gender,
    required this.occupantType,
  });

  factory AllocationOccupant.fromJson(Map<String, dynamic> json) {
    return AllocationOccupant(
      id: json['id'],
      name: json['name'],
      gender: OptionModel.fromJson(json['gender']),
      occupantType: OptionModel.fromJson(json['occupant_type']),
    );
  }
}
