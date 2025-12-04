import 'dart:convert';

List<RouletteBet> rouletteBetFromMap(String str) =>
    List<RouletteBet>.from(json.decode(str).map((x) => RouletteBet.fromMap(x)));

String rouletteBetToMap(List<RouletteBet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RouletteBet {
  final num amt;
  final num digit;

  RouletteBet({
    required this.amt,
    required this.digit,
  });

  factory RouletteBet.fromMap(Map<String, dynamic> json) => RouletteBet(
        amt: json["amt"],
        digit: json["digit"],
      );

  Map<String, dynamic> toMap() => {
        "amt": amt,
        "digit": digit,
      };
}
