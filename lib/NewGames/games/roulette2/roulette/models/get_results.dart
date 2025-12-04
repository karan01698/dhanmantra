import 'dart:convert';

List<Last5Results> last5ResultsFromMap(String str) => List<Last5Results>.from(
    json.decode(str).map((x) => Last5Results.fromMap(x)));

String last5ResultsToMap(List<Last5Results> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Last5Results {
  final int id;
  final String result;
  final DateTime time;
  final String gamename;

  Last5Results({
    required this.id,
    required this.result,
    required this.time,
    required this.gamename,
  });

  factory Last5Results.fromMap(Map<String, dynamic> json) => Last5Results(
        id: json["id"],
        result: json["Result"],
        time: DateTime.parse(json["Time"]),
        gamename: json["Gamename"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Result": result,
        "Time": time.toIso8601String(),
        "Gamename": gamename,
      };
}

List<GetResults> getResultsFromMap(String str) =>
    List<GetResults>.from(json.decode(str).map((x) => GetResults.fromMap(x)));

String getResultsToMap(List<GetResults> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetResults {
  final Result result;

  GetResults({
    required this.result,
  });

  factory GetResults.fromMap(Map<String, dynamic> json) => GetResults(
        result: resultValues.map[json["Result"]]!,
      );

  Map<String, dynamic> toMap() => {
        "Result": resultValues.reverse[result],
      };
}

enum Result { lost, won }

final resultValues = EnumValues({"Lost": Result.lost, "Won": Result.won});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
