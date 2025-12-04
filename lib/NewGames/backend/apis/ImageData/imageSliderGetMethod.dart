import 'dart:convert';
import 'package:sattagames/NewGames/backend/utils.dart';
import 'package:http/http.dart' as http;
import 'banners.dart';

Future<List<ImageData>> fetchImages() async {
  final response = await http.get(
    Uri.parse(
      '$baseurl/ImageSlider?token=RMNAJAMDNAFJNFTAMI',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => ImageData.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load images');
  }
}
