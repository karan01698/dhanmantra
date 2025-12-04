import 'package:flutter/material.dart';
import '../../../../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../../../../main.dart';
import '../../../othergames/jodi/first_screen.dart';
import '../../../othergames/jodi/tabs.dart';
import '../../widget/outside/scrolling_card.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// class GameResultModel {
//   final int id;
//   final String gameName;
//   final String result;
//
//   GameResultModel({
//     required this.id,
//     required this.gameName,
//     required this.result,
//   });
//
//   factory GameResultModel.fromJson(Map<String, dynamic> json) {
//     return GameResultModel(
//       id: json['ID'],
//       gameName: json['GameName'],
//       result: json['Result'],
//     );
//   }
// }
//
//
// class GameResultController extends GetxController {
//   var results = <String, String>{}.obs;
//
//   Future<void> fetchResult(String gameName) async {
//     try {
//       final token = 'ADFHNSAMALOUAAKL';
//       final url = Uri.parse(
//         'https://dhanmantragame.com/APIs/WebService1.asmx/ShowResults?token=$token&GameName=$gameName',
//       );
//
//       logPrint('🔍 Fetching result for: $gameName');
//       final response = await http.get(url);
//       logPrint('🌐 Response status: ${response.statusCode}');
//       logPrint('📦 Raw response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         logPrint('✅ Decoded JSON: $jsonData');
//
//         if (jsonData is List && jsonData.isNotEmpty) {
//           final result = GameResultModel.fromJson(jsonData.first);
//           results[result.gameName] = result.result;
//           logPrint('🎯 Result saved: ${result.gameName} => ${result.result}');
//         } else {
//           logPrint('⚠️ No data found in the response list for $gameName');
//         }
//       } else {
//         logPrint('❌ Failed to fetch result for $gameName, Status: ${response.statusCode}');
//       }
//     } catch (e, stacktrace) {
//       logPrint('💥 Error fetching result for $gameName: $e');
//       logPrint(stacktrace);
//     }
//   }
// }
//
// // GameData model can also be in a separate file
// class GameData {
//   final String title;
//   final String timing;
//   final String imagePath;
//
//   GameData({
//     required this.title,
//     required this.timing,
//     required this.imagePath,
//   });
// }
//
// class ScrollRow extends StatelessWidget {
//   ScrollRow({super.key});
//   final controller = Get.put(GameResultController());
//
//   final List<GameData> games = [
//     GameData(title: 'DESAWAR', timing: '08:00 AM - 04:00 AM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'GALI', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'GHAZIYABAD', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'RAJASTHAN', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'LUCKNOW', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'SHALIMAR', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//     GameData(title: 'MUMBAI', timing: '05:00 PM - 11:00 PM', imagePath: 'https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // Only call once!
//     Future.microtask(() {
//       for (var game in games) {
//         controller.fetchResult(game.title);
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView(
//               children: games.map((game) {
//                 final result = controller.results[game.title] ?? 'Loading...';
//                 return Column(
//                   children: [
//                     GameCardSc(
//                       title: game.title,
//                       timing: game.timing,
//                       imagePath: game.imagePath,
//                       onPlayPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CustomTabScreen(gameTitle: game.title),
//                           ),
//                         );
//                       },
//                     ),
//                     Text(
//                       'Result: $result',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../othergames/jodi/first_screen.dart';
import '../../../othergames/jodi/tabs.dart';
import '../../widget/outside/scrolling_card.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// MODEL
class GameResultModel {
  final int id;
  final String gameName;
  final String result;

  GameResultModel({
    required this.id,
    required this.gameName,
    required this.result,
  });

  factory GameResultModel.fromJson(Map<String, dynamic> json) {
    return GameResultModel(
      id: json['ID'],
      gameName: json['GameName'],
      result: json['Result'],
    );
  }
}

// CONTROLLER
class GameResultController extends GetxController {
  var results = <String, String>{}.obs;
  var games = <MatkaGame>[].obs;
  var isLoading = false.obs;
  final String token = "ADFHNSAMALOUAAKL";
  Future<void> fetchResult(String gameName) async {
    try {
      final token = 'ADFHNSAMALOUAAKL';
      final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/ShowResults?token=$token&GameName=Desawar',
      );

      logPrint('🔍 Fetching result for: $gameName');
      final response = await http.get(url);
      logPrint('🌐 Response status: ${response.statusCode}');
      logPrint('📦 Raw response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        logPrint('✅ Decoded JSON: $jsonData');

        if (jsonData is List && jsonData.isNotEmpty) {
          final result = GameResultModel.fromJson(jsonData.first);
          results[result.gameName] = result.result;
          logPrint('🎯 Result saved: ${result.gameName} => ${result.result}');
        } else {
          logPrint('⚠️ No data found in the response list for $gameName');
        }
      } else {
        logPrint('❌ Failed to fetch result for $gameName, Status: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      logPrint('💥 Error fetching result for $gameName: $e');
      print(stacktrace);
    }
  }
}

class GameCardSc extends StatelessWidget {
  final String imagePath;
  final String gameName;
  final String openTime;
  final String closeTime;
  final String resultTime;
  final String result;
  final VoidCallback onPlayPressed;

  const GameCardSc({
    super.key,
    required this.imagePath,
    required this.gameName,
    required this.openTime,
    required this.closeTime,
    required this.resultTime,
    required this.result,
    required this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        border: Border.all(color: Colors.yellow, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🖼 Fixed Image
          Image.network(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),

          // 📄 Expanded Column (text content)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🕹 Game Name
                Text(
                  gameName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                // 📊 Show Result Count as Text

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Result: $result", // 👈 direct number text
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // ⏰ Timings
                Text(
                  "Open: $openTime | Close: $closeTime\nResult: $resultTime",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),


          // ▶️ Play Button
          IconButton(
            onPressed: onPlayPressed,
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey[800],
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}


class ScrollRow extends StatelessWidget {
  ScrollRow({super.key});

  final gameController = Get.put(MatkaGameController());


  final String staticImage =
      "https://i.postimg.cc/DyJWzSfw/Screenshot-2025-06-23-162905-removebg-preview-1.png";

  DateTime _parseTime(String time) {
    try {
      final parts = time.split(":");
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    } catch (e) {
      return DateTime.now();
    }
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent, // screen dark na ho
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text("Info", style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (gameController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: gameController.games.length,
          itemBuilder: (context, index) {
            final game = gameController.games[index];

            // final DateTime open = _parseTime(game.openTime);
            // final DateTime close = _parseTime(game.closeTime);
            // final DateTime now = DateTime.now();

            return GameCardSc(
              imagePath: staticImage,
              gameName: game.gameName,
              openTime: game.openTime,
              closeTime: game.closeTime,
              resultTime: game.resultTime,
              result: game.result,
                // onPlayPressed: () {
                //
                //   final DateTime now = DateTime.now(); // ✅ fresh time on button press
                //   final DateTime open = _parseTime(game.openTime);
                //   final DateTime close = _parseTime(game.closeTime);
                //
                //   if (now.isBefore(open)) {
                //     _showDialog(context, "Game will start at ${game.openTime}");
                //   } else if (now.isAfter(open) && now.isBefore(close)) {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => CustomTabScreen(
                //           gameTitle: game.gameName,
                //           closeTime: game.closeTime,
                //         ),
                //       ),
                //     );
                //   } else if (now.isAfter(close)) {
                //     _showDialog(context, "Game time is over");
                //   }
                // }
                onPlayPressed: () {
                  final DateTime now = DateTime.now(); // ✅ fresh time on button press
                  DateTime open = _parseTime(game.openTime);
                  DateTime close = _parseTime(game.closeTime);

                  // ✅ handle next-day close case
                  if (close.isBefore(open)) {
                    close = close.add(const Duration(days: 1));
                  }

                  if (now.isBefore(open)) {
                    _showDialog(context, "Game will start at ${game.openTime}");
                  } else if (now.isAfter(open) && now.isBefore(close)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomTabScreen(
                          gameTitle: game.gameName,
                          openTime: game.openTime,
                          closeTime: game.closeTime,

                        ),
                      ),
                    );
                  } else if (now.isAfter(close)) {
                    _showDialog(context, "Game time is over");
                  }
                }



            );
          },
        );
      }),
    );
  }
}




class MatkaGameController extends GetxController {
  var games = <MatkaGame>[].obs;
  var isLoading = false.obs;

  final String token = "ADFHNSAMALOUAAKL";

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  Future<void> fetchGames() async {
    try {
      isLoading(true);
      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/MatkaGames?token=$token",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        games.value = data.map((e) => MatkaGame.fromJson(e)).toList();
      } else {
        logPrint("Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      logPrint("Error fetching games: $e");
    } finally {
      isLoading(false);
    }
  }
}

