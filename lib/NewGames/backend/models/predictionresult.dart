import 'dart:convert';

class PredictionResult {
  final int id;
  final String roundId;
  final DateTime dateTime;
  final String result;

  PredictionResult({
    required this.id,
    required this.roundId,
    required this.dateTime,
    required this.result,
  });

  // Factory constructor to create a PredictionResult from a map
  factory PredictionResult.fromMap(Map<String, dynamic> map) {
    return PredictionResult(
      id: map['id'],
      roundId: map['roundid'],
      dateTime: DateTime.parse(map['DateTim']),
      result: map['Result'],
    );
  }

  // Method to convert a PredictionResult to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roundid': roundId,
      'DateTim': dateTime.toIso8601String(),
      'Result': result,
    };
  }

  // Method to create a list of PredictionResult from a JSON string
  static List<PredictionResult> fromJson(String str) =>
      List<PredictionResult>.from(
        json.decode(str).map((x) => PredictionResult.fromMap(x)),
      );

  // Method to convert a list of PredictionResult to a JSON string
  static String toJson(List<PredictionResult> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
