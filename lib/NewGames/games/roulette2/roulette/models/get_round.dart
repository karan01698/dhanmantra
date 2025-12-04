import 'dart:convert';

List<GetRound> getRoundFromMap(String str) =>
    List<GetRound>.from(json.decode(str).map((x) => GetRound.fromMap(x)));

String getRoundToMap(List<GetRound> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetRound {
  final int id;
  final String roundid;
  final String gamename;
  final String roundstatus;
  final String roundresult;
  final String roundtime;

  GetRound({
    required this.id,
    required this.roundid,
    required this.gamename,
    required this.roundstatus,
    required this.roundresult,
    required this.roundtime,
  });

  factory GetRound.fromMap(Map<String, dynamic> json) => GetRound(
        id: json["id"],
        roundid: json["Roundid"],
        gamename: json["Gamename"],
        roundstatus: json["roundstatus"],
        roundresult: json["roundresult"],
        roundtime: json["roundtime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Roundid": roundid,
        "Gamename": gamename,
        "roundstatus": roundstatus,
        "roundresult": roundresult,
        "roundtime": roundtime,
      };
}
