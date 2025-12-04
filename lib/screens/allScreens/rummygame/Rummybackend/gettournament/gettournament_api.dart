import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../main.dart';
import 'tournament_model.dart'; // Your model file

class TournamentService {
  static Future<List<TournamentModel>> fetchTournament() async {
    final url = Uri.parse("https://dhanmantragame.com/APIs/WebService1.asmx/GetTournament");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "token": "BETLAJDNDNDBARKXTER",
        "TournamentID": "TNS",
      },
    );

    logPrint("Status code: ${response.statusCode}");
    logPrint("📦 Raw Response:\n${response.body}");

    if (response.statusCode == 200) {
      // Decode and map JSON list to TournamentModel list
      final List<dynamic> jsonData = jsonDecode(response.body);
      final tournaments = jsonData.map((item) => TournamentModel.fromJson(item)).toList();
      logPrint("✅ Parsed Tournament List: ${tournaments.length} items");
      return tournaments;
    } else {
      throw Exception('❌ Failed to load tournaments. Status: ${response.statusCode}');
    }
  }
}
