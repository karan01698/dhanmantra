import 'dart:convert';

List<PrevBetModel> prevBetModelFromMap(String str) => List<PrevBetModel>.from(
    json.decode(str).map((x) => PrevBetModel.fromMap(x)));

String prevBetModelToMap(List<PrevBetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PrevBetModel {
  final int id;
  final String gameid;
  final String amount;

  PrevBetModel({
    required this.id,
    required this.gameid,
    required this.amount,
  });

  factory PrevBetModel.fromMap(Map<String, dynamic> json) => PrevBetModel(
        id: json["id"],
        gameid: json["gameid"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "gameid": gameid,
        "amount": amount,
      };
}
