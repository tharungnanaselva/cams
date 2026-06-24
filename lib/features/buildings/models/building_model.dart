import 'option_model.dart';

class BuildingModel {
  final int id;
  final String name;
  final OptionModel type;
  final OptionModel genderRestriction;
  final bool status;

  BuildingModel({
    required this.id,
    required this.name,
    required this.type,
    required this.genderRestriction,
    required this.status,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      name: json['name'],
      type: OptionModel.fromJson(json['type']),
      genderRestriction: OptionModel.fromJson(json['gender_restriction']),
      status: json['status'],
    );
  }
}
