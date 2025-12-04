import 'dart:convert';

class Mode {
  final int id;
  final String mode1;

  Mode({
    required this.id,
    required this.mode1,
  });

  factory Mode.fromMap(Map<String, dynamic> json) => Mode(
        id: json["id"],
        mode1: json["Mode1"],
      );
}

List<Mode> getModeFromMap(String jsonStr) {
  final List<dynamic> jsonData = json.decode(jsonStr);
  return jsonData.map((item) => Mode.fromMap(item)).toList();
}
