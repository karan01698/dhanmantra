import 'package:sattagames/NewGames/backend/utils.dart';
import 'package:http/http.dart' as http;

import '../../models/Qrimage.dart';

Future<List<QRData>> fetchQRData() async {
  final String url =
      "$baseurl/QR?token=RMNAJAMDNAFJNFTAMI";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return QRData.fromJsonList(response.body);
    } else {
      throw Exception('Failed to load QR data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
