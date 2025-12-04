import 'dart:convert';

List<InvestedAmount> investedAmountFromMap(String str) =>
    List<InvestedAmount>.from(
        json.decode(str).map((x) => InvestedAmount.fromMap(x)));

String investedAmountToMap(List<InvestedAmount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class InvestedAmount {
  final dynamic column1;

  InvestedAmount({
    required this.column1,
  });

  factory InvestedAmount.fromMap(Map<String, dynamic> json) => InvestedAmount(
        column1: json["Column1"],
      );

  Map<String, dynamic> toMap() => {
        "Column1": column1,
      };
}
