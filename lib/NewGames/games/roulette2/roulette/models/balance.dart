import 'dart:convert';

List<Balance> balanceFromMap(String str) =>
    List<Balance>.from(json.decode(str).map((x) => Balance.fromMap(x)));

String balanceToMap(List<Balance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Balance {
  final int id;
  final String walletPoints;
  final String loginid;

  Balance({
    required this.id,
    required this.walletPoints,
    required this.loginid,
  });

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
        id: json["id"],
        walletPoints: json["WalletPoints"],
        loginid: json["Loginid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "WalletPoints": walletPoints,
        "Loginid": loginid,
      };
}
