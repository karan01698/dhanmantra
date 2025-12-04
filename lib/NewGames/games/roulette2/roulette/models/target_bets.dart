import 'dart:convert';

List<TargetBet> targetBetFromMap(String str) =>
    List<TargetBet>.from(json.decode(str).map((x) => TargetBet.fromMap(x)));

String targetBetToMap(List<TargetBet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TargetBet {
  final int betOn;
  final num totalAmount;

  TargetBet({
    required this.betOn,
    required this.totalAmount,
  });

  factory TargetBet.fromMap(Map<String, dynamic> json) => TargetBet(
        betOn: json["BetOn"],
        totalAmount: json["TotalAmount"],
      );

  Map<String, dynamic> toMap() => {
        "BetOn": betOn,
        "TotalAmount": totalAmount,
      };
}
