import 'dart:convert';

List<GetTransactions> getTransactionsFromMap(String str) =>
    List<GetTransactions>.from(
        json.decode(str).map((x) => GetTransactions.fromMap(x)));

String getTransactionsToMap(List<GetTransactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetTransactions {
  final int id;
  final String tid;
  final String amount;
  final String date;
  final String status;
  final String phone;

  GetTransactions({
    required this.id,
    required this.tid,
    required this.amount,
    required this.date,
    required this.status,
    required this.phone,
  });

  factory GetTransactions.fromMap(Map<String, dynamic> json) => GetTransactions(
        id: json["id"],
        tid: json["Tid"],
        amount: json["Amount"],
        date: json["Date"],
        status: json["Status"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "Tid": tid,
        "Amount": amount,
        "Date": date,
        "Status": status,
        "Phone": phone,
      };
}
