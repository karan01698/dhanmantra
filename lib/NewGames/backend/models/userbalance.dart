import 'dart:convert';

List<UserBalance> userBalanceFromJson(String str) => List<UserBalance>.from(
  json.decode(str).map((x) => UserBalance.fromJson(x)),
);

String userBalanceToJson(List<UserBalance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBalance {
  final int id;
  final String phone;
  final String password;
  final String promoCode;
  final String name;
  final String email;
  final String balance;
  final String exposure;
  final String bonus;

  UserBalance({
    required this.id,
    required this.phone,
    required this.password,
    required this.promoCode,
    required this.name,
    required this.email,
    required this.balance,
    required this.exposure,
    required this.bonus,
  });

  factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
    id: json["id"] ?? 0,
    phone: json["Phone"] ?? "",
    password: json["Password"] ?? "",
    promoCode: json["Promocode"] ?? "",
    name: json["Name"] ?? "",
    email: json["Email"] ?? "",
    balance: json["Balance"] ?? "",
    exposure: json["Exposure"] ?? "",
    bonus: json["bonus"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Phone": phone,
    "Password": password,
    "Promocode": promoCode,
    "Name": name,
    "Email": email,
    "Balance": balance,
    "Exposure": exposure,
    "bonus": bonus,
  };
}
