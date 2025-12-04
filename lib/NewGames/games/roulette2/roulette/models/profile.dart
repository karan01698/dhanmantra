import 'dart:convert';

List<GetProfile> getProfileFromMap(String str) =>
    List<GetProfile>.from(json.decode(str).map((x) => GetProfile.fromMap(x)));

String getProfileToMap(List<GetProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetProfile {
  final int id;
  final String phone;
  final String passwords;
  final String balance;
  final String atype;

  GetProfile({
    required this.id,
    required this.phone,
    required this.passwords,
    required this.balance,
    required this.atype,
  });

  factory GetProfile.fromMap(Map<String, dynamic> json) => GetProfile(
        id: json["id"],
        phone: json["Phone"],
        passwords: json["Passwords"],
        balance: json["Balance"],
        atype: json["Atype"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Phone": phone,
        "Passwords": passwords,
        "Balance": balance,
        "Atype": atype,
      };
}
