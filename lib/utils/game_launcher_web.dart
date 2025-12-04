import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

void launchWebGame(String url) {
  html.window.open(url, '_blank');

}
// Future<void>  launchWebGame(String url) async {
//   final uri = Uri.parse(url);
//
//   if (!await launchUrl(
//     uri,
//     mode: LaunchMode.externalApplication, // naya tab / browser me kholega
//   )) {
//     throw Exception("Could not launch $url");
//   }
// }

