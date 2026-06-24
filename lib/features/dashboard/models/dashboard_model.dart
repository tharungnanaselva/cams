import 'room_status_summary_model.dart';

class DashboardModel {
  final int totalBuildings;
  final int totalRooms;
  final int occupiedRooms;
  final int vacantRooms;
  final int totalOccupants;

  final RoomStatusSummaryModel roomStatusSummary;

  DashboardModel({
    required this.totalBuildings,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.vacantRooms,
    required this.totalOccupants,
    required this.roomStatusSummary,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalBuildings: json['total_buildings'] ?? 0,

      totalRooms: json['total_rooms'] ?? 0,

      occupiedRooms: json['occupied_rooms'] ?? 0,

      vacantRooms: json['vacant_rooms'] ?? 0,

      totalOccupants: json['total_occupants'] ?? 0,

      roomStatusSummary: RoomStatusSummaryModel.fromJson(
        json['room_status_summary'] ?? {},
      ),
    );
  }
}
