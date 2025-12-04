import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

// For web only
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class GameLauncherHandler {
  /// Opens a game URL in a platform-safe way.
  static Future<void> launchGame(String url) async {
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
