class OptionModel {
  final String value;
  final String label;

  OptionModel({required this.value, required this.label});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(value: json['value'], label: json['label']);
  }
}
