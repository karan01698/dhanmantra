import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'dart:html' as html;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/rommidapi_dart.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattitablet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';
import 'dart:ui' as ui; // Web ke liye
import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../../../../NewGames/backend/apis/methods.dart';
import '../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../main.dart';
import '../../../../utils/global_key_store.dart';
import '../../../../utils/jss.dart';
import '../../../../utils/navigation_utils.dart';
import '../../../../utils/navigation_utils_stub.dart';
import '../../../../utils/responsvie_web_mobile.dart';
import 'package:collection/collection.dart'; // for firstWhereOrNull / lastWhereOrNull
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AutoJoinBotsController extends GetxController {
  var isLoading = false.obs;
  var status = "".obs;
  var botsAdded = 0.obs;

  /// 🔹 Automatically call when controller is created
  @override
  void onInit() {
    super.onInit();
  // 👈 ek hi baar call hoga
  }

  Future<void> autoJoinBots(String roomId) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/AutoJoinBots?roomId=$roomId",
      );

      final response = await http.get(url);

      print("📦 RAW RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        // 🔥 STEP 1: saare JSON objects nikaalo
        final matches = RegExp(r'\{[^}]*\}').allMatches(response.body).toList();

        if (matches.isEmpty) {
          print("❌ NO JSON FOUND");
          return;
        }

        // 🔥 STEP 2: LAST JSON uthao (important)
        final lastJson = matches.last.group(0)!;

        print("🧹 CLEAN JSON (LAST) => $lastJson");

        // 🔥 STEP 3: decode
        final data = jsonDecode(lastJson);

        status.value = data["status"] ?? "";

        if (status.value == "bots_joined") {
          botsAdded.value = data["bots_added"] ?? 0;
        }

        print("✅ BOT STATUS => ${status.value}");
        print("🤖 BOTS ADDED => ${botsAdded.value}");
      }
    } catch (e) {
      print("❌ EXCEPTION => $e");
    } finally {
      isLoading.value = false;
    }
  }


}


class UserStatusResponse {
  final String message;

  UserStatusResponse({required this.message});

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) {
    return UserStatusResponse(
      message: json['message'] ?? '',
    );
  }
}

class UserStatusController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;

  Future<void> updateUserStatus({
    required String token,
    required String roomID,
    required String userPhone,
    required String userStatus,
  }) async {
    isLoading.value = true;

    final Uri url = Uri.parse(
      'https://dhanmantragame.com/APIs/WebService1.asmx/UpdateUserStatus',
    );
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');
    final Map<String, String> body = {
      'token': token,
      'RoomID': savedRoomId.toString(),
      'UserPhone': userPhone,
      'UserStatus': userStatus,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final result = UserStatusResponse.fromJson(jsonData);
        responseMessage.value = result.message;
        // Get.snackbar("Success", result.message);
      } else {
        Get.snackbar("Error", "Status Code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class IframeScreen extends StatelessWidget {
  final String url;

  const IframeScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int viewId) => html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Iframe Example")),
      body: HtmlElementView(viewType: url),
    );
  }
}

/// ✅ Method jo iframe ko chalata hai
Widget loadIframe(String url) {
  return IframeScreen(url: url);
}

class RoomPlayerModel {
  final String username;
  final String card1;
  final String card2;
  final String card3;
  final String userStatus;
  final String seenStatus;
  final String balance;
  final bool isPass;

  RoomPlayerModel({
    required this.username,
    required this.card1,
    required this.card2,
    required this.card3,
    required this.userStatus,
    required this.seenStatus,
    required this.balance,
    required this.isPass,
  });

  factory RoomPlayerModel.fromJson(Map<String, dynamic> json) {
    return RoomPlayerModel(
      username: json['Username'] ?? '',
      card1: json['Card1'] ?? '',
      card2: json['Card2'] ?? '',
      card3: json['Card3'] ?? '',
      userStatus: json['UserStatus']?.toString() ?? '',
      seenStatus: json['SeenStatus']?.toString() ?? '',
      balance: json['Balance'].toString() ?? '',
      isPass: json['IsTurn'] == true || json['IsTurn'] == 'true',
    );
  }
}

class RoomPlayerController extends GetxController {
  var message = ''.obs;
  var activeTurnUsername = ''.obs;
  var turnProgress = 1.0.obs;
  Timer? turnTimer;
  var currentUserPhone = ''.obs;
  var playerList = <RoomPlayerModel>[].obs;
  var isLoading = false.obs;
  var isGameStarting = false.obs;
  var countdown = 0.obs;
  var roomId = "TP_248953".obs;
  var hasGameStarted = false;
  var balance = ''.obs;
  bool modifiedThisTurn = false;
  late AudioPlayer _beepPlayer;
  late AudioPlayer _startPlayer;
  var usernameAll = <String>[].obs;
  var revealedUsername = ''.obs;
  var increasedThisTurn = false;// track karega ki + press hua ya nahi
  var decreasedThisTurn = false;
  var actionTaken = false;           // kya ek action liya gaya hai?
  var allowOppositeAction = false;   // kya opposite action allowed hai?
  final StreamController<String> _balanceStreamController =
      StreamController<String>.broadcast();
  final AutoJoinBotsController botsController =
  Get.put(AutoJoinBotsController());

  Stream<String> get balanceStream => _balanceStreamController.stream;
  RoomController removecontoller = Get.put(RoomController());

  void reveal(String username) {
    revealedUsername.value = username;
  }

  @override
  void onInit() {
    super.onInit();



    html.window.onBeforeUnload.listen((event) async {
      String? phone = await RegistrationController.getPhoneNumber();
      if (phone == null || phone.isEmpty) return;

      final prefs = await SharedPreferences.getInstance();
      final savedRoomId = prefs.getString('roomId');

      if (savedRoomId != null) {
        await removecontoller.removeUserBeforeStart(phone, savedRoomId);
      }
    });

    initRoomJoin();
    passTurn();
    startBalancePolling();
    _beepPlayer = AudioPlayer();
    _startPlayer = AudioPlayer();
    _initPhone();
    startPolling();
    ever(playerList, (_) {
      usernameAll.value = playerList.map((e) => e.username ?? '').toList();
    });

    // registerconteolrl.RummyloadUserProfile();
  }

  bool get isWaitingOrStarting =>
      playerList.length < 5 || (isGameStarting.value && countdown.value > 0);

  Future<void> clearGameSession() async {
    try {
      // 1️⃣ Timers stop
      turnTimer?.cancel();
      turnTimer = null;

      // 2️⃣ Streams close
      await _balanceStreamController.close();

      // 3️⃣ SharedPreferences clear (sirf game related)
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('roomId');
      await prefs.remove('chaalType');
      await prefs.remove('all_usernames');

      // Agar full clean chahiye ho to (OPTIONAL)
      // await prefs.clear();fi

      // 4️⃣ Controller states reset
      playerList.clear();
      activeTurnUsername.value = '';
      countdown.value = 0;
      isGameStarting.value = false;
      hasGameStarted = false;
      isWinnerShown = false;
      winnerFetched = false;

      logPrint("🧹 Game session cleared successfully");
    } catch (e) {
      logPrint("❌ Error clearing game session: $e");
    }
  }

  Future<void> fetchTotalBalance() async {
    final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/GetTotalBetByRoom");
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "RoomID": savedRoomId,

        },
      );

      if (response.statusCode == 200) {
        final match = RegExp(r'>(.*?)<').firstMatch(response.body);
        final newBalance = match?.group(1) ?? "0";

        _balanceStreamController.add(newBalance);
        logPrint("✅ Balance Updated: $newBalance");
      } else {
        _balanceStreamController.add("Error: ${response.statusCode}");
      }
    } catch (e) {
      _balanceStreamController.add("Error: $e");
    }
  }

  // Future<String> fetchTotalBalance() async {
  //   final url = Uri.parse(
  //       "https://dhanmantragame.com/APIs/WebService1.asmx/GetTotalBetByRoom");
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedRoomId = prefs.getString('roomId');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //       body: {"RoomID": savedRoomId},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final match = RegExp(r'>(.*?)<').firstMatch(response.body);
  //       final newBalance = match?.group(1) ?? "0";
  //
  //       _balanceStreamController.add(newBalance);
  //       return newBalance; // return string value
  //     } else {
  //       return "0";
  //     }
  //   } catch (e) {
  //     return "0";
  //   }
  // }
  var hasPlayedTurn = false.obs;

  Future<void> passTurn() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    isLoading.value = true;
    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/PassTurn?roomId=$savedRoomId');
    logPrint('hellelelelelekut');
    try {
      hasPlayedTurn.value = false;
      final response = await http.get(url);
      // activeTurnUsername.value = getNextPlayer();
      //
      // // 🔄 reset kar dena jab naya turn start ho
      // hasPlayedChaal.value = false;
      if (response.statusCode == 200) {
        // Parse XML
        final document = XmlDocument.parse(response.body);
        final result = document.findAllElements('string').first.text;

        message.value = result;
        logPrint("messsage ${message.value}");
        // usually "Turn Passed Successfully"
      } else {
        message.value = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      message.value = 'Failed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _initPhone() async {
    final phone = await RegistrationController.getPhoneNumber();
    if (phone != null) {
      currentUserPhone.value = phone;
    }
  }

  // void initRoomJoin() async {
  //   RoomController roomcontroller = Get.put(RoomController());
  //
  //   String? phone = await RegistrationController
  //       .getPhoneNumber(); // 🔹 Get saved phone number
  //   if (phone == null || phone.isEmpty) {
  //     logPrint("No saved phone number found.");
  //     return;
  //   }
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedRoomId = prefs.getString('roomId');
  //   roomcontroller.joinOrCreateRoom(phone, phone);
  //   await Get.find<AutoJoinBotsController>().autoJoinBots(savedRoomId);
  // }
  void initRoomJoin() async {
    final RoomController roomcontroller = Get.put(RoomController());
    final String? phone = await RegistrationController.getPhoneNumber();

    if (phone == null || phone.isEmpty) {
      logPrint("❌ No phone number found");
      return;
    }

    // 1️⃣ Pehle JOIN / CREATE ROOM
    await roomcontroller.joinOrCreateRoom(phone, phone);

    // 2️⃣ Ab roomId read karo (ab guaranteed milega)
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    if (savedRoomId == null || savedRoomId.isEmpty) {
      logPrint("❌ roomId still null, AutoBot nahi chalegi");
      return;
    }

    logPrint("🤖 AutoBot calling for roomId: $savedRoomId");

    // 3️⃣ Ab AutoBot call karo
    await Get.find<AutoJoinBotsController>().autoJoinBots(savedRoomId);
  }

  void startPolling() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchRoomPlayers();
    });
  }

  //   void startTurnTimer(String username) async {
  //     if (isGameStarting.value || playerList.length != 5) {
  //       return; // ✅ Timer tabhi chalega jab game start nahi ho raha ho + 5 players ho
  //     }
  //     if (activeTurnUsername.value == username && turnTimer != null && turnTimer!.isActive) {
  //       return; // Already running timer for same player, ignore polling
  //     }
  // logPrint ('usernameeee $username');
  //     turnTimer?.cancel();
  //     activeTurnUsername.value = username;
  //     turnProgress.value = 1.0;
  //
  //     const duration = Duration(seconds: 20);
  //     const tick = Duration(milliseconds: 100);
  //     int elapsed = 0;
  //
  //     turnTimer = Timer.periodic(tick, (timer) {
  //       elapsed += 100;
  //       turnProgress.value = 1 - (elapsed / duration.inMilliseconds);
  //
  //       if (elapsed >= duration.inMilliseconds) {
  //         timer.cancel();
  //         turnProgress.value = 0;
  //         passTurn(); // ⏰ Time's up
  //
  //       }
  //
  //     });
  //
  //   }

  bool turnCompleted = false; // ✅ New flag
//   void startTurnTimer(String username) {
//     if (isGameStarting.value || playerList.length != 5) return;
//
//     // Agar same player ke liye timer already chal raha hai → return
//     if (activeTurnUsername.value == username &&
//         turnTimer != null &&
//         turnTimer!.isActive) return;
//
//     turnTimer?.cancel();
//     activeTurnUsername.value = username;
//     turnProgress.value = 1.0;
//     turnCompleted = false; // reset
//     modifiedThisTurn = false;
//     increasedThisTurn = false;
//      // ✅ reset
//     decreasedThisTurn = false;  // ✅ reset
//     actionTaken = false;
//     allowOppositeAction = false;
//     const duration = Duration(seconds: 20);
//     const tick = Duration(milliseconds: 100);
//     int elapsed = 0;
//
//     turnTimer = Timer.periodic(tick, (timer) async {
//       elapsed += 100;
//       turnProgress.value = 1 - (elapsed / duration.inMilliseconds);
//
//       // Agar player ne chal chal di (isPass == false) → stop timer
//
//       // Agar time khatam
//       if (elapsed >= duration.inMilliseconds) {
//         timer.cancel();
//         turnProgress.value = 0;
//         int activePlayersCount =
//             playerList.where((p) => p.isPass == false).length;
//
//         if (activePlayersCount <= 1) {
//           turnTimer?.cancel();
//           logPrint("⚠ Last player bacha hai, passTurn ya pack nahi hoga.");
//           return;
//         }
//
//         await passTurn();
// ChaalAmountController Chaalcontroller = Get.put(ChaalAmountController());
//
//         // Chaalcontroller.setDisplayAmount();
//         // sirf tab pack kare jab chal nahi chali
//
//         final prefs = await SharedPreferences.getInstance();
//         final savedRoomId = prefs.getString('roomId');
//         String? phone = await RegistrationController.getPhoneNumber();
//
//         if (phone != null && phone.isNotEmpty && savedRoomId != null) {
//           int packedCount =
//               playerList.where((p) => p.userStatus == "packed").length;
//
//           if (packedCount < 4) {
//             final packPlayerController = Get.put(PackPlayerController());
//             await packPlayerController.packPlayer(username);
//           } else {
//             logPrint("🎯 4 players already packed, passTurn() नहीं चलेगा");
//           }
//         }
//       }
//     });
//   }
  void startTurnTimer(String username) {
    if (isGameStarting.value || playerList.length != 5) return;

    if (activeTurnUsername.value == username &&
        turnTimer != null &&
        turnTimer!.isActive) return;

    turnTimer?.cancel();
    activeTurnUsername.value = username;

    // Reset flags
    turnProgress.value = 1.0;
    turnCompleted = false;
    modifiedThisTurn = false;
    increasedThisTurn = false;
    decreasedThisTurn = false;
    actionTaken = false;
    allowOppositeAction = false;

    const int backendDurationSec = 23; // actual timer
    const int uiDurationSec = 20;      // what user sees
    const tick = Duration(milliseconds: 100);
    int elapsed = 0;

    turnTimer = Timer.periodic(tick, (timer) async {
      elapsed += 100;

      // UI progress (fixed 20s)
      int elapsedForUI = elapsed;
      if (elapsedForUI > uiDurationSec * 1000) elapsedForUI = uiDurationSec * 1000;

      turnProgress.value = 1 - (elapsedForUI / (uiDurationSec * 1000));

      // Agar player chal chuki hai → stop timer
      if (playerList
          .firstWhere((p) => p.username == username)
          .isPass ==
          false) {
        timer.cancel();
        turnProgress.value = 0;
        return;
      }

      // Agar backend 25s khatam → auto pack
      if (elapsed >= backendDurationSec * 1000) {
        timer.cancel();
        turnProgress.value = 0;

        int activePlayersCount =
            playerList.where((p) => p.isPass == false).length;

        if (activePlayersCount <= 1) {
          logPrint("⚠ Last player bacha hai, passTurn ya pack nahi hoga.");
          return;
        }

        await passTurn();

        final prefs = await SharedPreferences.getInstance();
        final savedRoomId = prefs.getString('roomId');
        String? phone = await RegistrationController.getPhoneNumber();

        if (phone != null && phone.isNotEmpty && savedRoomId != null) {
          int packedCount =
              playerList.where((p) => p.userStatus == "packed").length;

          if (packedCount < 4) {
            final packPlayerController = Get.put(PackPlayerController());
            await packPlayerController.packPlayer(username);
            logPrint("⏱ Player $username automatically packed after 25s!");
          } else {
            logPrint("🎯 4 players already packed, passTurn() nahi chalega");
          }
        }
      }
    });
  }


  int winnerApiCalls = 0;
  bool winnerFetched = false;

  void onUserPlayedMove() {
    turnCompleted = true;
    turnTimer?.cancel(); // stop timer so no auto-pack
  }

  void startBalancePolling() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      fetchTotalBalance(); // 👈 fetch balance every 3 seconds
    });
  }

  Future<void> fetchRoomPlayers() async {
    final currentTurn = playerList.firstWhereOrNull((p) => p.isPass == true);
    if (currentTurn != null) {
      if (activeTurnUsername.value != currentTurn.username) {
        startTurnTimer(currentTurn.username);
      }
    } else {
      activeTurnUsername.value = '';
      turnTimer?.cancel();
      turnProgress.value = 1.0;
      logPrint("❌ No current turn found (no player with isPass == true)");
    }
    isLoading(true);
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      return null;
    }
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');
    try {
      final url = Uri.parse(
          'https://dhanmantragame.com/APIs/WebService1.asmx/GetRoomPlayers?roomId=$savedRoomId&currentUserPhone=$phone');
      final response = await http.get(url);
      final body = response.body.trim();

      final xmlDoc = XmlDocument.parse(body);
      final stringElement = xmlDoc.findAllElements('string').firstOrNull;

      if (stringElement != null) {
        final jsonString = stringElement.innerText.trim();
        final decoded = json.decode(jsonString);

        logPrint("🧑‍💻 Total Players Fetched: ${decoded.length}");
        for (var player in decoded) {
          logPrint("➡️ Player Joined: ${player['name']} - ₹${player['balance']}");
        }
        if (decoded.isNotEmpty) {
          logPrint("🧾 Sample player data: ${decoded[0]}");

          List<String> allUsernames = [];

          for (var player in decoded) {
            final name = player['Username']; // double check this key!
            logPrint("➡️ Player Joined: $name");

            if (name != null && name is String && name.isNotEmpty) {
              allUsernames.add(name);
            }
          }

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('all_usernames', jsonEncode(allUsernames));
          logPrint("✅ Saved usernames: $allUsernames");
        }

        playerList.value =
            (decoded as List).map((e) => RoomPlayerModel.fromJson(e)).toList();

        await checkPlayerCount();
        int packedCount = playerList
            .where((p) => p.userStatus.toLowerCase() == "packed")
            .length;
        // if (packedCount >= playerList.length - 1 && playerList.length > 1) {
        //   // Means only one player is left (or all except one packed)
        //   logPrint("🎯 Only one player left — fetching winner...");
        //   await fetchWinnerAndShowAlert();
        // }
        if (!winnerFetched &&
            packedCount >= playerList.length - 1 &&
            playerList.length > 1) {
          logPrint("🎯 Only one player left — fetching winner...");
          winnerFetched = true; // prevent multiple calls
          await fetchWinnerAndShowAlert();

        }

        String? phones = await RegistrationController
            .getPhoneNumber(); // 🔹 Get saved phone number
        if (phones == null || phones.isEmpty) {
          logPrint("No saved phone number found.");

          return null;
        }
      }
    } catch (e) {
      logPrint("❌ Error fetching players: $e");
    } finally {
      isLoading(false);
    }
  }

  bool isWinnerShown = false; // controller ya state me rakho
  // Future<void> fetchWinnerAndShowAlert() async {
  //   if (isWinnerShown) return; // agar pehle dikhaya to return
  //   isWinnerShown = true;
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedRoomId = prefs.getString('roomId');
  //   try {
  //     final url = Uri.parse(
  //       "https://dhanmantragame.com/APIs/WebService1.asmx/GetTeenPattiWinner?roomId=$savedRoomId",
  //     );
  //     final response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       final xmlDoc = XmlDocument.parse(response.body);
  //       final stringElement = xmlDoc.findAllElements('string').firstOrNull;
  //       if (stringElement != null) {
  //         final data = json.decode(stringElement.innerText.trim());
  //         final winnerName = data['WinnerName'] ?? '';
  //         final phone = data['Phone'] ?? '';
  //
  //         logPrint("🏆 Winner: $winnerName ($phone)");
  //
  //         Get.dialog(
  //           Center(
  //             child: Container(
  //               padding: EdgeInsets.all(20),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.9),
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text("🏆 Winner",
  //                       style: TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.bold)),
  //                   SizedBox(height: 10),
  //                   Text("$winnerName\n📱 $phone"),
  //                   SizedBox(height: 15),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Get.back(); // Dialog band
  //                       Get.back(); // Screen se back
  //                     },
  //                     child: Text("OK"),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           barrierColor: Colors.transparent,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     logPrint("⚠ Exception fetching winner: $e");
  //   }
  // }
  Future<void> fetchWinnerAndShowAlerts() async {
    winnerApiCalls++;
    logPrint("🎯 Winner API called $winnerApiCalls times");
    if (isWinnerShown) return; // agar pehle dikhaya to return
    isWinnerShown = true;

    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');
    try {
      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/GetTeenPattiWinner?roomId=$savedRoomId",
      );
      final response = await http.get(url);
      logPrint("me respose hu ${response.body}");
      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringElement = xmlDoc.findAllElements('string').firstOrNull;
        if (stringElement != null) {
          final data = json.decode(stringElement.innerText.trim());
          final winnerName = data['WinnerName'] ?? '';
          final phone = data['Phone'] ?? '';

          // ✅ Fetch Total Balance
          await fetchTotalBalance();
          String totalBalance = await balanceStream.first;
          // kabhi error string aa sakti hai so safe parsing karo
          double total = double.tryParse(totalBalance) ?? 0.0;

          // ✅ 10% Deduction
          double deduction = total * 0.10;
          double finalAmount = total - deduction;

          logPrint(
              "🏆 Winner: $winnerName ($phone), Total: $total, After 10%: $finalAmount");

          Get.dialog(
            Stack(
              children: [
                // 🔹 Blur Background
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),

                // 🔹 Dialog Content
                Center(
                  child: Container(
                    width: 450,
                    height: 600,
                    // increase so content fits better
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ===== Winner Header =====
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.purple, Colors.pink],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.emoji_events, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "Winner",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ===== Winner Info =====
                        Text(
                          winnerName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "🏆 Won: ₹${finalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ===== SCROLLABLE PLAYER LIST =====
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: playerList.length,
                            itemBuilder: (context, index) {
                              final player = playerList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      child: Text(
                                        "${index + 1}.",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        player.username,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 100,
                                      height: 70,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          _buildCards(player.card1, -20, -30),
                                          _buildCards(player.card2, 0, 0),
                                          _buildCards(player.card3, 20, 30),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ===== OK Button =====
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          onPressed: () {
                            Get.until((route) => route.isFirst);
                            Get.back();
                            Get.back();
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            barrierColor: Colors.transparent,
          );
        }
      }
    } catch (e) {
      logPrint("⚠ Exception fetching winner: $e");
    }
  }
 // ye naya waala hai
  Future<void> fetchWinnerAndShowAlert() async {
    winnerApiCalls++;
    logPrint("🎯 Winner API called $winnerApiCalls times");

    if (isWinnerShown) return;
    isWinnerShown = true;

    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId') ?? '';

    try {
      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/GetTeenPattiWinner?roomId=$savedRoomId",
      );
      final response = await http.get(url);
      logPrint("📥 Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringElement = xmlDoc.findAllElements('string').firstOrNull;

        if (stringElement != null) {
          final extractedJson = stringElement.innerText.trim();
          logPrint("✅ Extracted JSON: $extractedJson");

          final data =
          extractedJson.isNotEmpty ? jsonDecode(extractedJson) : null;

          await fetchTotalBalance();
          String totalBalance = await balanceStream.first;

          double total = double.tryParse(totalBalance) ?? 0.0;

          // ✅ 10% Deduction
          double deduction = total * 0.10;
          double finalAmount = total - deduction;

          final winnerName = (data != null && data['WinnerName'] != null)
              ? data['WinnerName'].toString()
              : "No Winner Yet";

          final phone = (data != null && data['Phone'] != null)
              ? data['Phone'].toString()
              : "N/A";

          RoomPlayerModel? winnerPlayer =
          playerList.firstWhereOrNull((p) => p.username == winnerName);
          RoomPlayerModel? lastPlayer =
          playerList.lastWhereOrNull((p) => p.username != winnerName);

          // ✅ Dialog open after frame build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final dialogContext = GlobalContext.context; // ✅ ab yaha se lega
              if (dialogContext == null) {
                logPrint("❌ Dialog nahi khol paaye: GlobalContext null hai");
                return;
              }

              logPrint("ℹ️ Dialog open karne jaa rahe hain");

              showDialog(
                context: dialogContext,
                barrierDismissible: false,
                builder: (context) => WinnerDialog(
                  winnerName: winnerName,
                  finalAmount: finalAmount,
                  winnerPlayer: winnerPlayer,
                  lastPlayer: lastPlayer,
                ),
              ).then((_) {
                logPrint("✅ Dialog close ho gaya");
              }).catchError((e) {
                logPrint("⚠️ Dialog me error aaya: $e");
              });
            });


          }
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     // final dialogContext = navigatorKey.currentContext;
        //     // if (dialogContext == null) {
        //     //   logPrint("❌ Dialog nahi khol paaye: navigatorKey null hai");
        //     //   return;
        //     // }
        //
        //     showDialog(
        //       context:  Get.context!,
        //       barrierDismissible: false,
        //       builder: (context) =>
        //           WinnerDialog(
        //             winnerName: winnerName,
        //             finalAmount: finalAmount,
        //             winnerPlayer: winnerPlayer,
        //             lastPlayer: lastPlayer,
        //           ),
        //     );
        //   });
        // }
        else {
          logPrint("⚠️ Wrong screen, dialog nahi khola");
        }
      }
    } catch (e, stack) {
      logPrint("⚠ Exception fetching winner: $e");
      logPrint("yestatck $stack");
    }
  }

  // 🔹 Helper Widget (Winner / Last Player)

  // Future<void> checkPlayerCount() async {
  //   if (playerList.length == 5 && !isGameStarting.value && !hasGameStarted) {
  //     isGameStarting.value = true;
  //
  //     for (int i = 5; i >= 0; i--) {
  //       countdown.value = i;
  //
  //       if (i > 0) {
  //         _playBeep(); // 🔊 Beep during countdown
  //       } else {
  //         // 🧠 Countdown ends here — CALL API
  //         Get.put(ChaalController()).checkAndSendChaalOnEnter();
  //         await passTurn();
  //         // await _playGameStart();
  //       }
  //       await Future.delayed(const Duration(seconds: 1));
  //     }
  //
  //     hasGameStarted = true;
  //     isGameStarting.value = false;
  //     countdown.value = 0;
  //   }
  // }
  Future<void> checkPlayerCount() async {
    if (playerList.length == 5 && !isGameStarting.value && !hasGameStarted) {
      isGameStarting.value = true;

      for (int i = 5; i >= 0; i--) {
        countdown.value = i;

        if (i > 0) {
          _playBeep(); // 🔊 Sirf 5..1 tak beep
        } else {
          // ⏹️ Beep stop jab countdown = 0 ho jaye
          await _beepPlayer.stop();

          // 🧠 Countdown ends here — CALL API
          Get.put(ChaalController()).checkAndSendChaalOnEnter();
          await passTurn();
        }

        await Future.delayed(const Duration(seconds: 1));
      }

      hasGameStarted = true;
      isGameStarting.value = false;
      countdown.value = 0;
    }
  }

  void resetGame() {
    hasGameStarted = false;
    countdown.value = 0;
    isGameStarting.value = false;
  }

  Future<void> _playBeep() async {
    await _beepPlayer.play(AssetSource(
        'audio/mixkit-clock-countdown-bleeps-916.mp3')); // put file in assets/audio/
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<
        RoomController>(); // next time Get.to karega to onInit firse chalega
  }

// Future<void> _playGameStart() async {
//   await _startPlayer.play(AssetSource('audio/game_start.mp3'));
// }
}

bool isOnTeenPattiesScreen = false;

class TeenPattiTableWeb extends StatelessWidget {
  TeenPattiTableWeb({super.key});

  final RoomPlayerController Roomplayerscontroller =
      Get.put(RoomPlayerController());
  final RoomController controller = Get.put(RoomController());
  final AutoJoinBotsController botsController = Get.put(AutoJoinBotsController());
  @override
  Widget build(BuildContext context) {
    final AutoJoinBotsController botsController =
    Get.put(AutoJoinBotsController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<String> avatarUrls = [
      "https://static.vecteezy.com/system/resources/previews/054/297/644/non_2x/a-cartoon-man-wearing-headphones-and-sunglasses-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/054/078/735/non_2x/gamer-avatar-with-headphones-and-controller-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/054/298/667/non_2x/a-man-in-glasses-and-headphones-with-a-beard-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/059/466/462/non_2x/colorful-gamer-avatar-with-headphones-and-glasses-white-background-free-vector.jpg",
    ];
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Exit Game",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade700,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Do you want to exit and go back to the main screen?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.grey.shade600,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.yellow, width: 2),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("No",
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.yellow, width: 2),
                            ),
                            elevation: 5,
                          ),

                            // Get.back(result: true);
                            onPressed: () async {
                              // 🔹 Phone & room cleanup API
                              String? phone = await RegistrationController.getPhoneNumber();
                              final prefs = await SharedPreferences.getInstance();
                              final savedRoomId = prefs.getString('roomId');

                              if (phone != null && savedRoomId != null) {
                                await controller.removeUserBeforeStart(phone, savedRoomId);
                              }

                              // 🔹 Clear local game session
                              await Roomplayerscontroller.clearGameSession();

                              // 🔹 Remove controllers completely (important)
                              Get.delete<RoomPlayerController>(force: true);
                              Get.delete<RoomController>(force: true);
                              Get.delete<AutoJoinBotsController>(force: true);
                              Get.delete<ChaalAmountController>(force: true);

                              // 🔹 Go back & rebuild fresh
                              // Get.offAllNamed('/home');
                              Get.back(result: true);
                              // OR
                              // Navigator.of(context).pop(true);


                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );

        if (shouldExit == true) {
          Navigator.of(context).pop(true);
          return false;
        }

        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // 🔹 AppBar ko transparent banane ke liye
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent, // Transparent AppBar
        //   elevation: 0,
        //   automaticallyImplyLeading: false, // default back button हटाने के लिए
        //
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.close, color: Colors.white),
        //       onPressed: () async {
        //         Navigator.of(context).pop(true);
        //         await Future.delayed(const Duration(milliseconds: 300));
        //
        //         String? phone = await RegistrationController.getPhoneNumber();
        //
        //         if (phone == null || phone.isEmpty) {
        //           Get.snackbar("Error", "Phone number not found");
        //           return;
        //         }
        //
        //         final prefs = await SharedPreferences.getInstance();
        //         final savedRoomId = prefs.getString('roomId');
        //
        //         if (savedRoomId != null) {
        //           await controller.removeUserBeforeStart(phone, savedRoomId);
        //         } else {
        //           Get.snackbar("Error", "No Room ID saved");
        //           return;
        //         }
        //
        //         Get.back(); // close page
        //       },
        //     ),
        //   ],
        // ),

        body: Stack(
          children: [


            ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: 1920, maxHeight: 1080),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/paymentimages/rummybackground.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/rummytables.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Center(
                    child: Obx(() {
                      final playerCount =
                          Roomplayerscontroller.playerList.length;
                      final isStarting =
                          Roomplayerscontroller.isGameStarting.value;
                      final countdown = Roomplayerscontroller.countdown.value;
                      final disableInteractions =
                          Roomplayerscontroller.playerList.length >= 5 &&
                              Roomplayerscontroller.countdown.value > 0;

                      return AbsorbPointer(
                        absorbing: disableInteractions,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Player Icons
                            Obx(() {
                              final players = Roomplayerscontroller.playerList;

                              if (players.isEmpty) return const SizedBox();

                              final bottomPlayer = players.first;
                              final otherPlayers =
                                  players.length > 1 ? players.sublist(1) : [];

                              final List<Offset> playerPositions = [
                                Offset(ResponsiveHelpers.w(370),
                                    ResponsiveHelpers.h(130)),
                                Offset(
                                    screenWidth -
                                        ResponsiveHelpers.w(360) -
                                        100,
                                    ResponsiveHelpers.h(130)),
                                Offset(
                                    ResponsiveHelpers.w(280),
                                    screenHeight / 2 -
                                        ResponsiveHelpers.h(-50)),
                                Offset(
                                    screenWidth -
                                        ResponsiveHelpers.w(280) -
                                        100,
                                    screenHeight / 2 -
                                        ResponsiveHelpers.h(-50)),
                              ];

                              return Stack(
                                children: [
                                  Positioned(
                                    right: 60,
                                    top: 3  ,
                                    child: WalletInfoExample(),

                                  ),
                                  Positioned(
                                    bottom: ResponsiveHelpers.h(20),
                                    left: (screenWidth / 2) - 50,
                                    child: PlayerIcon(
                                      showEye: true,
                                      card1: bottomPlayer.card1,
                                      card2: bottomPlayer.card2,
                                      card3: bottomPlayer.card3,
                                      imageUrl:
                                          'https://static.vecteezy.com/system/resources/thumbnails/054/632/778/small_2x/a-cartoon-character-with-headphones-and-sunglasses-free-vector.jpg',
                                      name: '${bottomPlayer.username}',
                                      amount: bottomPlayer.balance,
                                      pack: bottomPlayer.userStatus,
                                      seenStatus: bottomPlayer.seenStatus,
                                    ),
                                  ),
                                  ...List.generate(
                                    otherPlayers.length > 4
                                        ? 4
                                        : otherPlayers.length,
                                    (index) {
                                      final player = otherPlayers[index];
                                      final position = playerPositions[index];
                                      return Positioned(
                                        left: position.dx,
                                        top: position.dy,
                                        child: PlayerIcon(
                                            showEye: false,
                                            card1: player.card1,
                                            card2: player.card2,
                                            card3: player.card3,
                                            imageUrl: avatarUrls[
                                                index % avatarUrls.length],
                                            name: player.username,
                                            amount: player.balance,
                                            pack: player.userStatus,
                                            seenStatus: player.seenStatus),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),

                            // Game Title
                            Positioned(
                              top: ResponsiveHelpers.h(400),
                              child: Opacity(
                                opacity: 0.5,
                                child: Text(
                                  'DHANMANTRA',
                                  style: TextStyle(
                                    fontSize: ResponsiveHelpers.sp(50),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            Obx(() {
                              final currentPlayerPhone =
                                  Roomplayerscontroller.currentUserPhone.value;
                              final activeTurnUser = Roomplayerscontroller
                                  .activeTurnUsername.value;

                              final currentPlayer = Roomplayerscontroller
                                  .playerList
                                  .firstWhereOrNull(
                                      (p) => p.username == currentPlayerPhone);

                              final isPacked =
                                  currentPlayer?.userStatus == "Packed";

                              final isUserTurn =
                                  activeTurnUser == currentPlayerPhone;

                              if (!isUserTurn || isPacked) {
                                return const SizedBox(); // Not user's turn or packed → hide buttons
                              }

                              return Positioned(
                                right: 170,
                                bottom: 10,
                                child: BeautifulButtonAnimation(
                                  child: GameActionButtons(),
                                ),
                              );
                            }),

                            // Obx(() {
                            //   final currentPlayerPhone =
                            //       Roomplayerscontroller.currentUserPhone.value;
                            //   final activeTurnUser = Roomplayerscontroller
                            //       .activeTurnUsername.value;
                            //
                            //   final currentPlayer = Roomplayerscontroller
                            //       .playerList
                            //       .firstWhereOrNull(
                            //           (p) => p.username == currentPlayerPhone);
                            //
                            //   final isPacked =
                            //       currentPlayer?.userStatus == "Packed";
                            //   final isUserTurn =
                            //       activeTurnUser == currentPlayerPhone;
                            //
                            //   // Count players who are NOT packed
                            //   final unpackedPlayersCount = Roomplayerscontroller
                            //       .playerList
                            //       .where((p) => p.userStatus != "Packed")
                            //       .length;
                            //
                            //   // Agar teen packed ho gaye (ya sirf 2 bache) aur current user ka turn hai
                            //   final shouldShow = unpackedPlayersCount == 2 &&
                            //       isUserTurn &&
                            //       !isPacked;
                            //
                            //   if (!shouldShow) {
                            //     return const SizedBox();
                            //   }
                            //
                            //   // Yahan tumhare GameActionButtons ya ShowButtons call hoga
                            //   return Positioned(
                            //     right: 15,
                            //     bottom: 10,
                            //     child: ShowButtons(),
                            //   );
                            // }),
                            Obx(() {
                              final currentPlayerPhone =
                                  Roomplayerscontroller.currentUserPhone.value;
                              final activeTurnUser = Roomplayerscontroller
                                  .activeTurnUsername.value;

                              final currentPlayer = Roomplayerscontroller
                                  .playerList
                                  .firstWhereOrNull(
                                      (p) => p.username == currentPlayerPhone);

                              final isPacked =
                                  currentPlayer?.userStatus == "Packed";
                              final isUserTurn =
                                  activeTurnUser == currentPlayerPhone;

                              // Count players who are NOT packed
                              final unpackedPlayersCount = Roomplayerscontroller
                                  .playerList
                                  .where((p) => p.userStatus != "Packed")
                                  .length;

                              Widget? buttonWidget;

                              if (isUserTurn && !isPacked) {
                                if (unpackedPlayersCount == 2) {
                                  // Sirf 2 players bache → ShowButtons()
                                  buttonWidget = ShowButtons();
                                } else if (unpackedPlayersCount > 2) {
                                  // 2 se zyada players bache → SideShowButtons()
                                  // buttonWidget = SideShowButtons();
                                }
                              }

                              if (buttonWidget == null) {
                                return const SizedBox();
                              }

                              return Positioned(
                                right: 15,
                                bottom: 10,
                                child: buttonWidget,
                              );
                            }),

                            StreamBuilder<String>(
                              stream: Roomplayerscontroller.balanceStream,
                              builder: (context, snapshot) {
                                final balanceValue = snapshot.data;
                                final amountToShow = (balanceValue != null &&
                                        balanceValue.isNotEmpty)
                                    ? balanceValue.toString()
                                    : 0;

                                return BuyButton(
                                  amount: amountToShow.toString(),
                                  showBorder: true,
                                  showLottie: true,
                                  lottieWidth: 40,
                                  lottieHeight: 60,
                                  lottieLeft: -30,
                                  lottieBottom: -13.6,
                                );
                              },
                            ),

                            SizedBox(height: 30, child: CoinAnimationScreen()),


                            // Room ID top right
                            Positioned(
                              right: 200,
                              top: 50,
                              child: Obx(() {
                                final response = controller.roomResponse.value;
                                if (response != null) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BuyButton(
                                        buttonWidth: 200,
                                        title: "Room ID: ${response.roomId}",
                                        showBorder: false,
                                        showLottie: false,
                                        backgroundOpacity: 0.4,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            // Overlay message: Waiting / Countdown
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                final isStarting = Roomplayerscontroller.isGameStarting.value;
                final playerCount = Roomplayerscontroller.playerList.length;
                final countdown = Roomplayerscontroller.countdown.value;

                String? message;
                Color bgColor = Colors.transparent;

                if (playerCount < 5) {
                  message = "⏰ Waiting for players...";
                  bgColor = Colors.black.withOpacity(0.8);
                } else if (isStarting && countdown > 0) {
                  message = "⏰ Game starting in $countdown...";

                  bgColor = Colors.orange.withOpacity(0.9);
                }

                return message != null
                    ? Container(
                        width: 350,
                        // width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 12),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerIcon extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;
  final String card1;
  final String card2;
  final String card3;
  final bool showEye;
  final String pack;
  final String seenStatus;

  const PlayerIcon({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.card1,
    required this.card2,
    required this.card3,
    required this.pack,
    required this.seenStatus,
    this.showEye = true,
  }) : super(key: key);

  bool get isPacked => pack.toLowerCase() == 'packed';

  @override
  Widget build(BuildContext context) {
    String maskPhoneNumber(String number) {
      if (number.length <= 3) return number; // chhota number ho toh as it is
      final start = number.substring(0, 2); // pehle 2 digits
      final end = number.substring(number.length - 1); // last 1 digit
      final middle = 'x' * (number.length - 3); // beech ke digits
      return '$start$middle$end';
    }
    final RoomPlayerController controller = Get.find();
    final userStatusController = Get.put(UserStatusController());
    final ChaalAmountController chalcontroller = Get.put(ChaalAmountController());
    return Obx(() {
      final bool showFront = controller.revealedUsername.value == name;
      final bool isMyTurn =
          controller.activeTurnUsername.value.trim() == name.trim();
      final int timeLeft = (controller.turnProgress.value * 20).ceil();
      final bool isDisabled = controller.isWaitingOrStarting;

      return Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: AbsorbPointer(
          absorbing: isDisabled, // 👈 disable interactions when waiting
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showEye && !showFront && !isPacked)
                IconButton(
                  icon: const Icon(Icons.remove_red_eye,
                      color: Colors.white, size: 20),
                  onPressed: () async {
                    chalcontroller.fetchChaalAmounts("Seen");
                    final prefs = await SharedPreferences.getInstance();
                    final savedRoomId = prefs.getString('roomId');
                    String? phone =
                        await RegistrationController.getPhoneNumber();
                    if (phone == null || phone.isEmpty) {
                      logPrint("No saved phone number found.");
                      return;
                    }

                    controller.reveal(name);
                    userStatusController.updateUserStatus(
                      token: 'BETLAJDNDNDBARKXTER',
                      roomID: savedRoomId.toString(),
                      userPhone: phone,
                      userStatus: 'seen',
                    );
                  },
                ),

              // 🃏 Cards
              SizedBox(
                height: ResponsiveHelpers.h(70),
                width: ResponsiveHelpers.w(100),
                child: Align(
                  alignment: const Alignment(0, 4.5),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      buildCard(20, 0.3, card2, -3, showFront),
                      buildCard(50, 0.9, card3, 20, showFront),
                      buildCard(-22, -0.5, card1, 8, showFront),
                    ],
                  ),
                ),
              ),

              // 🧑 Avatar + Turn Timer
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isMyTurn && !isPacked)
                    SizedBox(
                      width: ResponsiveHelpers.r(90),
                      height: ResponsiveHelpers.r(90),
                      child: CircularProgressIndicator(
                        value: controller.turnProgress.value,
                        strokeWidth: 6,
                        color: Color(0xffEFBF04),
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  Container(
                    width: ResponsiveHelpers.r(80),
                    height: ResponsiveHelpers.r(80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff9c6802), width: 4),
                    ),
                    child: CircleAvatar(
                      radius: ResponsiveHelpers.r(40),
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  if (isMyTurn && !isPacked)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // ✅ Circle shape
                        color: Colors.green.withOpacity(0.6),
                        // ✅ Transparent green
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$timeLeft',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelpers.sp(18),
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(1, 1),
                                color: Colors.black54,
                                blurRadius: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: ResponsiveHelpers.h(6)),

              // 🛑 Packed or Seen label
              if (isPacked)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Packed',
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(12),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (!isPacked && seenStatus.toLowerCase() == 'seen')
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Seen',
                    style: TextStyle(
                      fontSize: ResponsiveHelpers.sp(12),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 4),

              // 🏷 Name
              Text(
                maskPhoneNumber(name),
                style: TextStyle(
                  fontSize: ResponsiveHelpers.sp(14),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              BuyButton(
                amount: amount,
                showBorder: false,
                showLottie: true,
                lottieWidth: 40,
                lottieHeight: 60,
                lottieLeft: -30,
                lottieBottom: -18,
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildCard(double offsetX, double angle, String cardName, double offsetY,
    bool showFront) {
  final String backImage =
      'https://dhanmantragame.com/Images/Back1.jpg';
  final String frontImage =
      'https://dhanmantragame.com/Cards/${cardName.toUpperCase()}.png';

  final double width = ResponsiveHelpers.w(50);
  final double height = ResponsiveHelpers.h(60);
  final double borderRadius = 5;

  return Transform.translate(
    offset: Offset(
      ResponsiveHelpers.w(offsetX),
      ResponsiveHelpers.h(offsetY),
    ),
    child: Transform.rotate(
      angle: angle,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          child: Image.network(
            showFront ? frontImage : backImage,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    ),
  );
}

//
class BuyButton extends StatelessWidget {
  final String? title;
  final String? amount;

  final bool showBorder;
  final bool showLottie;

  final double lottieWidth;
  final double lottieHeight;
  final double lottieLeft;
  final double lottieBottom;

  final double fontSize;
  final double? buttonWidth;
  final double? buttonHeight;

  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final double? backgroundOpacity; // 🔥 NEW PARAM

  const BuyButton({
    super.key,
    this.title,
    this.amount,
    this.showBorder = true,
    this.showLottie = true,
    this.lottieWidth = 70,
    this.lottieHeight = 85,
    this.fontSize = 15,
    this.buttonWidth,
    this.buttonHeight,
    this.textColor = Colors.yellow,
    this.borderColor = Colors.orange,
    this.backgroundColor = Colors.black,
    this.backgroundOpacity, // 🔥 NEW
    this.lottieLeft = -40,
    this.lottieBottom = -25,
  });

  @override
  Widget build(BuildContext context) {
    final ChaalAmountController controller = Get.put(ChaalAmountController());

    if ((title == null || title!.isEmpty) &&
        (amount == null || amount!.isEmpty)) {
      return const SizedBox();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: buttonWidth ?? 100,
          height: buttonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: backgroundOpacity != null
                ? backgroundColor.withOpacity(backgroundOpacity!)
                : backgroundColor,
            border:
                showBorder ? Border.all(color: borderColor, width: 3) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLottie) const SizedBox(width: 20),
              Text(
                _buildText(),
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        if (showLottie)
          Positioned(
            left: lottieLeft,
            bottom: lottieBottom,
            child: SizedBox(
              width: lottieWidth,
              height: lottieHeight,
              child: Lottie.asset(
                'assets/paymentimages/coinimage.json',
                repeat: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
        // if (showLottie)
        //   Positioned(
        //     left: lottieLeft,
        //     bottom: lottieBottom,
        //     child: SizedBox(
        //       width: lottieWidth,
        //       height: lottieHeight,
        //       child: CoinAnimationScreen(), // ✅ यहां coin wali class call हो रही है
        //     ),
        //   ),
      ],
    );
  }

  String _buildText() {
    if (title != null &&
        title!.isNotEmpty &&
        amount != null &&
        amount!.isNotEmpty) {
      return '$title: ₹ $amount';
    } else if (title != null && title!.isNotEmpty) {
      return title!;
    } else if (amount != null && amount!.isNotEmpty) {
      return '₹ $amount';
    } else {
      return '';
    }
  }
}

Widget _buildCards(String cardName, double angle, double offsetX) {
  return Transform.translate(
    offset: Offset(offsetX, 0), // move left/right
    child: Transform.rotate(
      angle: angle * 3.1416 / 180, // degrees → radians
      child: Container(
        width: 45, // slightly bigger for better visibility
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(
              "https://dhanmantragame.com/Cards/${cardName.toUpperCase()}.png",
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    ),
  );
}

class BeautifulButtonAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset beginOffset;

  const BeautifulButtonAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOutBack, // bounce + smooth
    this.beginOffset = const Offset(0, 1), // button neeche se aaye
  });

  @override
  State<BeautifulButtonAnimation> createState() =>
      _BeautifulButtonAnimationState();
}

class _BeautifulButtonAnimationState extends State<BeautifulButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    // Slide animation (bottom to normal)
    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Fade animation (0 → 1 opacity)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Scale animation (slight pop/bounce)
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

class RoomResponseModel {
  final String status;
  final String roomId;

  RoomResponseModel({
    required this.status,
    required this.roomId,
  });

  factory RoomResponseModel.fromJson(Map<String, dynamic> json) {
    return RoomResponseModel(
      status: json['status'],
      roomId: json['RoomID'],
    );
  }
}

class RoomController extends GetxController {
  var isLoading = false.obs;
  var roomResponse = Rxn<RoomResponseModel>();

  Future<void> joinOrCreateRoom(String username, String phone) async {
    isLoading.value = true;

    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/JoinOrCreateRoom');
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final body = "username=$username&phone=$phone";

    logPrint("Request Body: $body");
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringContent = xmlDoc.findAllElements('string').first.text;
        logPrint("Raw Response Bodyss:\n${response.body}");
        final jsonMap = json.decode(stringContent);
        roomResponse.value = RoomResponseModel.fromJson(jsonMap);

        final roomModel = RoomResponseModel.fromJson(jsonMap);
        roomResponse.value = roomModel;

        // ✅ Save Room ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('roomId', roomModel.roomId);
      } else {
        // Get.snackbar(
        //     "Error", "Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> joinOrCreateRooms(String username, String phone) async {
    isLoading.value = true;

    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/JoinOrCreateRoom');
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final body = "username=$username&phone=$phone";

    logPrint("Request Body: $body");
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringContent = xmlDoc.findAllElements('string').first.text;
        logPrint("Raw Response Body:\n${response.body}");
        final jsonMap = json.decode(stringContent);
        roomResponse.value = RoomResponseModel.fromJson(jsonMap);

        final roomModel = RoomResponseModel.fromJson(jsonMap);
        roomResponse.value = roomModel;

        // ✅ Save Room ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('roomId', roomModel.roomId);
      } else {
        Get.snackbar(
            "Error", "Failedss with status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeUserBeforeStart(String username, String roomId) async {
    final url = Uri.parse(
      'https://dhanmantragame.com/APIs/WebService1.asmx/RemoveUserBeforeStart?username=$username&roomId=$roomId',
    );

    try {
      final response = await http.get(url);

      logPrint("📥 Raw response body:");
      logPrint(response.body);
      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringElement = xmlDoc.findAllElements('string').first.text;
        final jsonMap = json.decode(stringElement);
        final result = RemoveUserResponse.fromJson(jsonMap);
        logPrint('userdelete ${result}');
        if (result.status == "removed") {
          // Get.snackbar("✅ Success", "User removed from the room.");
        } else {
          Get.snackbar("⚠️ Error", "Unexpected status: ${result.status}");
        }
      } else {
        Get.snackbar("❌ Error", "Failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("🚨 Exception", e.toString());
    }
  }

  Future<void> forfeit(String username, String roomId) async {
    final url = Uri.parse(
      'https://https://dhanmantragame.com/APIs/WebService1.asmx/MarkUserAsForfeit?username=$username&roomId=$roomId',
    );

    try {
      final response = await http.get(url);

      logPrint("📥 Raw response body:");
      logPrint(response.body);
      if (response.statusCode == 200) {
        final xmlDoc = XmlDocument.parse(response.body);
        final stringElement = xmlDoc.findAllElements('string').first.text;
        final jsonMap = json.decode(stringElement);
        final result = RemoveUserResponse.fromJson(jsonMap);
        logPrint('userdelete ${result}');
        if (result.status == "removed") {
          // Get.snackbar("✅ Success", "User removed from the room.");
        } else {
          Get.snackbar("⚠️ Error", "Unexpected status: ${result.status}");
        }
      } else {
        Get.snackbar("❌ Error", "Failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("🚨 Exception", e.toString());
    }
  }
}

class RemoveUserResponse {
  final String status;

  RemoveUserResponse({required this.status});

  factory RemoveUserResponse.fromJson(Map<String, dynamic> json) {
    return RemoveUserResponse(status: json['status']);
  }
}

Widget _buildPlayerWidget(player) {
  return Container(
    color: Colors.transparent, // transparent background
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s",
          ),
        ),
        const SizedBox(width: 8),
        Text(
          player.username ?? "Unknown",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    ),
  );
}

//showchaal api

class ShowChaalAmount {
  final int id;
  final String amount;
  final String roomId;
  final String type;

  ShowChaalAmount({
    required this.id,
    required this.amount,
    required this.roomId,
    required this.type,
  });

  factory ShowChaalAmount.fromJson(Map<String, dynamic> json) {
    return ShowChaalAmount(
      id: json['id'],
      amount: json['Amount'],
      roomId: json['Roomid'],
      type: json['type'],
    );
  }
}

//
class ChaalAmountController extends GetxController {
  var chaalAmounts = <ShowChaalAmount>[].obs;
  var isLoading = false.obs;
  var displayAmount = 0.obs;
  var increasechaal = 0.obs;
  var currentType = "Blind".obs; // default Blind
  late SharedPreferences prefs;

  // 🔥 Ye stream banaya jo chaalAmounts ka realtime update dega
  Stream<List<ShowChaalAmount>> get chaalStream => chaalAmounts.stream;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
    _resetType();
  }

  void multiplyAmount() {
    final baseAmount = int.parse(chaalAmounts[0].amount.toString());
    displayAmount.value =
    displayAmount.value == 0 ? baseAmount * 2 : displayAmount.value * 2;
  }

  void decreaseAmount(int baseAmount) {
    if (displayAmount.value > baseAmount) {
      displayAmount.value = displayAmount.value ~/ 2;
    }
  }

  void resetAmount(int baseAmount) {
    displayAmount.value = baseAmount;
  }

  Future<void> _resetType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('chaalType');
    currentType.value = "Blind";
    await prefs.setString('chaalType', "Blind");
    fetchChaalAmounts("Blind");
  }

  Future<void> fetchChaalAmounts([String? type]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedRoomId = prefs.getString('roomId');
      isLoading(true);

      if (type != null) {
        currentType.value = type;
        await prefs.setString('chaalType', type);
      }

      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/ShowchaalAmount"
            "?token=BETLAJDNDNDBARKXTER"
            "&RoomID=$savedRoomId"
            "&Type=${currentType.value}",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        logPrint("📥 Raw Response: ${response.body}");
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          chaalAmounts.assignAll(
              decoded.map((e) => ShowChaalAmount.fromJson(e)).toList());
        } else {
          chaalAmounts.clear();
        }
      } else {
        logPrint("❌ Error: ${response.statusCode}");
      }
    } catch (e) {
      logPrint("⚠ Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}

class WinnerDialog extends StatelessWidget {
  final String winnerName;
  final double finalAmount;
  final RoomPlayerModel? winnerPlayer;
  final RoomPlayerModel? lastPlayer;

  const WinnerDialog({
    super.key,
    required this.winnerName,
    required this.finalAmount,
    this.winnerPlayer,
    this.lastPlayer,
  });

  @override
  Widget build(BuildContext context) {
    String maskPhoneNumber(String number) {
      if (number.length <= 3) return number; // chhota number ho toh as it is
      final start = number.substring(0, 2); // pehle 2 digits
      final end = number.substring(number.length - 1); // last 1 digit
      final middle = 'x' * (number.length - 3); // beech ke digits
      return '$start$middle$end';
    }
    return Stack(
      children: [
        // Blur background
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
        ),
        Center(
          child: Container(
            width: 500,
            height: 450,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              border: Border.all(color: Colors.orange, width: 3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Winner",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  maskPhoneNumber(winnerName),

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "🏆 Won: ₹${finalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (winnerPlayer != null)
                        _buildBigPlayer(winnerPlayer!, isWinner: true),
                      if (lastPlayer != null)
                        _buildBigPlayer(lastPlayer!, isWinner: false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Get.back(); // pehle dialog close
                    // NavigationUtils.goToHome();
                    NavigationUtils.closeCurrentTab();

                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBigPlayer(player, {bool isWinner = false}) {
    String maskPhoneNumber(String number) {
      if (number.length <= 3) return number; // chhota number ho toh as it is
      final start = number.substring(0, 2); // pehle 2 digits
      final end = number.substring(number.length - 1); // last 1 digit
      final middle = 'x' * (number.length - 3); // beech ke digits
      return '$start$middle$end';
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s",
          ),
        ),
        const SizedBox(height: 8),
        Text(
          maskPhoneNumber(isWinner ? "🏆 ${player.username}" : player.username ?? "Unknown",),

          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isWinner ? Colors.green : Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 12),
        // Big cards
        SizedBox(
          width: 140,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildCards(player.card1, -30, -40),
              _buildCards(player.card2, 0, 0),
              _buildCards(player.card3, 30, 40),
            ],
          ),
        ),
      ],
    );
  }
}







class WalletInfoExample extends StatelessWidget {

  // bonus is intentionally not exposed to UI (hidden)
  const WalletInfoExample({Key? key}) : super(key: key);

  // void _showWalletDialog(BuildContext context) {
  void _showWalletDialog() {
    showGeneralDialog(
      // context: context,
      context: GlobalContext.context!,
      barrierLabel: "Wallet Info",
      barrierDismissible: true,
      // black opacity overlay
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, anim1, anim2) {
        return SafeArea(
          child: Builder(builder: (context) {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(maxWidth: 420),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700], // yellow dialog background
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + close icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Wallet & Rules",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                                Icons.close, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Visible: main wallet only
                      // Text(
                      //   "Main Wallet Balance: ₹${mainWalletBalance.toStringAsFixed(2)}",
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      const SizedBox(height: 10),

                      // Bullet points for the 4 rules you provided
                      _buildBulletPoint(
                        "1. Wallet Display:",
                        "Only the main wallet balance is visible to the player. Bonus balance is hidden and not displayed.",
                      ),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        "2. Bet Deduction Logic:",
                        "For every bet/chaal: 10% from bonus balance and 90% from main wallet. If bonus is 0 → full deduction from main wallet.",
                      ),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        "3. Insufficient Funds:",
                        "If (main wallet + bonus) < bet, the player cannot place the bet. Message shown: “Insufficient balance!”",
                      ),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        "4. Adding Funds:",
                        "Any amount added goes directly to the main wallet balance.",
                      ),

                      const SizedBox(height: 16),
                      // OK button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "OK",
                              style: GoogleFonts.poppins(
                                color: Colors.yellow[100],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildBulletPoint(String title, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // small bullet
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,

                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 15,


                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Wallet Info",
      icon: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Colors.red, // 🔴 red background
          shape: BoxShape.circle, // make it circular
        ),
        alignment: Alignment.center,
        child: const Text(
          "i",
          style: TextStyle(
            color: Colors.white, // ⚪ white text
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () => _showWalletDialog(),
    );
  }

}