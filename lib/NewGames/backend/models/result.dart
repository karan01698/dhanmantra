import 'dart:convert';

List<AviatorResults> aviatorResultsFromJson(String str) =>
    List<AviatorResults>.from(
      json.decode(str).map((x) => AviatorResults.fromJson(x)),
    );

String aviatorResultsToJson(List<AviatorResults> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AviatorResults {
  int id;
  String result;

  AviatorResults({required this.id, required this.result});

  factory AviatorResults.fromJson(Map<String, dynamic> json) =>
      AviatorResults(id: json["id"], result: json["Result"]);

  Map<String, dynamic> toJson() => {"id": id, "Result": result};
}
