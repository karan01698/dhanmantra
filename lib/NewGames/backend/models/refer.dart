import 'dart:convert';

List<GetReferData> getReferDataFromJson(String str) => List<GetReferData>.from(
  json.decode(str).map((x) => GetReferData.fromJson(x)),
);

String getReferDataToJson(List<GetReferData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetReferData {
  int id;
  String referCode;
  String friendReferCode;
  String phone;

  GetReferData({
    required this.id,
    required this.referCode,
    required this.friendReferCode,
    required this.phone,
  });

  factory GetReferData.fromJson(Map<String, dynamic> json) => GetReferData(
    id: json["id"],
    referCode: json["ReferCode"],
    friendReferCode: json["FriendReferCode"],
    phone: json["Phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ReferCode": referCode,
    "FriendReferCode": friendReferCode,
    "Phone": phone,
  };
}
