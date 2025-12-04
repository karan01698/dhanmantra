import 'dart:convert';

List<Probablity> probablityFromJson(String str) =>
    List<Probablity>.from(json.decode(str).map((x) => Probablity.fromJson(x)));

String probablityToJson(List<Probablity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Probablity {
  int id;
  String gamename;
  int min;
  int max;

  Probablity({
    required this.id,
    required this.gamename,
    required this.min,
    required this.max,
  });

  factory Probablity.fromJson(Map<String, dynamic> json) {
    // Handle Probability value flexibly
    List<String> probRange = json["Prob"].split(RegExp(r"\s*-\s*"));
    int minValue = int.parse(probRange[0]);
    int maxValue = int.parse(probRange[1]);

    return Probablity(
      id: json["id"],
      gamename: json["Gamename"],
      min: minValue,
      max: maxValue,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "Gamename": gamename,
    "Prob": "$min-$max", // Ensuring consistent format
  };
}