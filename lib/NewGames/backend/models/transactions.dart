import 'dart:convert';

List<TransactionsHistory> transactionsHistoryFromJson(String str) =>
    List<TransactionsHistory>.from(
      json.decode(str).map((x) => TransactionsHistory.fromJson(x)),
    );

String transactionsHistoryToJson(List<TransactionsHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionsHistory {
  int id;
  String transactionid;
  String transactionamount;
  DateTime transactiondate;
  String accountnumber;
  String ifsc;
  String branch;
  String upi;
  String type;
  String phone;

  TransactionsHistory({
    required this.id,
    required this.transactionid,
    required this.transactionamount,
    required this.transactiondate,
    required this.accountnumber,
    required this.ifsc,
    required this.branch,
    required this.upi,
    required this.type,
    required this.phone,
  });

  factory TransactionsHistory.fromJson(Map<String, dynamic> json) =>
      TransactionsHistory(
        id: json["id"],
        transactionid: json["transactionid"],
        transactionamount: json["transactionamount"],
        transactiondate: DateTime.parse(json["transactiondate"]),
        accountnumber: json["Accountnumber"],
        ifsc: json["IFSC"],
        branch: json["Branch"],
        upi: json["UPI"],
        type: json["Type"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transactionid": transactionid,
    "transactionamount": transactionamount,
    "transactiondate": transactiondate.toIso8601String(),
    "Accountnumber": accountnumber,
    "IFSC": ifsc,
    "Branch": branch,
    "UPI": upi,
    "Type": type,
    "Phone": phone,
  };
}
