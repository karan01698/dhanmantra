import 'dart:convert';

class QRData {
  final int id;
  final String qrImage;
  final String upi;

  QRData({required this.id, required this.qrImage, required this.upi});

  factory QRData.fromJson(Map<String, dynamic> json) {
    return QRData(
      id: json['id'],
      qrImage: json['QR1'], // Ensure this matches your API key
      upi: json['UPI'],
    );
  }

  static List<QRData> fromJsonList(String str) {
    final jsonData = json.decode(str);
    return List<QRData>.from(jsonData.map((x) => QRData.fromJson(x)));
  }
}
