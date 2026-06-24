class RoomStatusSummaryModel {
  final int available;
  final int occupied;
  final int reserved;
  final int blocked;
  final int maintenance;

  RoomStatusSummaryModel({
    required this.available,
    required this.occupied,
    required this.reserved,
    required this.blocked,
    required this.maintenance,
  });

  factory RoomStatusSummaryModel.fromJson(Map<String, dynamic> json) {
    return RoomStatusSummaryModel(
      available: json['available'] ?? 0,
      occupied: json['occupied'] ?? 0,
      reserved: json['reserved'] ?? 0,
      blocked: json['blocked'] ?? 0,
      maintenance: json['maintenance'] ?? 0,
    );
  }
}
