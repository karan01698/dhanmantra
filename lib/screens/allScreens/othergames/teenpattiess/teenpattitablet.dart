import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpatiiweb.dart';
import 'package:sattagames/utils/global_key_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../../../main.dart';
import '../../../../utils/responsvie_web_mobile.dart';
import '../../../../widgets/reusable_button.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateResponse {
  final String message;

  UpdateResponse({required this.message});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(message: json['message']);
  }
}

class UpdateChaalController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;

  Future<void> updateChaalAmount({
    required String amount,
    required String type,
  }) async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final savedRoomId = prefs.getString('roomId');
      final url = Uri.parse(
          "https://dhanmantragame.com/APIs/WebService1.asmx/UpdateChaalAmount");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "token": 'BETLAJDNDNDBARKXTER',
          "Amount": amount,
          "RoomID": savedRoomId,
          "Type": type,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = UpdateResponse.fromJson(data);
        responseMessage.value = result.message;

        // Get.snackbar("Success2", result.message);
      } else {
        responseMessage.value = "Errorp: ${response.statusCode}";
        // Get.snackbar("Error5", responseMessage.value);
      }
    } catch (e) {
      responseMessage.value = "Exception: $e";
      // Get.snackbar("Errort", responseMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}

// class ChaalController extends GetxController {
//   var responseMessage = ''.obs;
//   var isLoading = false.obs;
//
//   Future<void> sendChaal() async {
//     isLoading.value = true;
//
//     try {
//       String? phone = await RegistrationController.getPhoneNumber();
//       if (phone == null || phone.isEmpty) {
//         logPrint("No saved phone number found.");
//         responseMessage.value = "❌ Phone number not found.";
//         return;
//       }
//
//       final prefs = await SharedPreferences.getInstance();
//       final String? jsonString = prefs.getString('all_usernames');
//       if (jsonString == null) {
//         logPrint("No usernames found in SharedPreferences.");
//         responseMessage.value = "❌ No usernames found.";
//         return;
//       }
//
//       final List<dynamic> decoded = jsonDecode(jsonString);
//       final List<String> usernames = decoded.cast<String>();
//
//       for (String username in usernames) {
//         final url = Uri.parse(
//           "https://dhanmantragame.com/APIs/WebService1.asmx/Chaal?token=BETLAJDNDNDBARKXTER&Phone=$username",
//         );
//
//         try {
//           final response = await http.post(
//             url,
//             headers: {
//               'Content-Type': 'application/x-www-form-urlencoded',
//             },
//             body: {
//               'RoomID': 'TP_947942',
//               'UserPhone': phone,
//             },
//           );
//
//           logPrint("🔹 API Raw Response: ${response.body}");
//
//           if (response.statusCode == 200) {
//             final body = response.body;
//
//             if (body.contains("Player not found")) {
//               responseMessage.value = "❌ Player not found in this room.";
//             } else {
//               responseMessage.value = "✅ Response: $body";
//             }
//           } else {
//             responseMessage.value = "❌ Error: ${response.statusCode}";
//           }
//         } catch (e) {
//           logPrint("❌ Exception during API call: $e");
//           responseMessage.value = "❌ Exception: $e";
//         }
//       }
//     } catch (e) {
//       logPrint("❌ Unexpected Error: $e");
//       responseMessage.value = "❌ Unexpected Error: $e";
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// class ChaalController extends GetxController {
//   var responseMessage = ''.obs;
//   var isLoading = false.obs;
//   Future<void> sendChaal() async {
//     isLoading.value = true;
//
//     String? phone = await RegistrationController.getPhoneNumber();
//     if (phone == null || phone.isEmpty) {
//       logPrint("No saved phone number found.");
//       isLoading.value = false;
//       return;
//     }
//
//     final prefs = await SharedPreferences.getInstance();
//     final savedRoomId = prefs.getString('roomId');
//
//
//     final url = Uri.parse('https://dhanmantragame.com/APIs/WebService1.asmx/Chaal');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'RoomID': savedRoomId,
//           'UserPhone': phone,
//         },
//       );
//
//       logPrint("🔹 API Raw Response: ${response.body}"); // 👈 logPrint API response in console
//
//       if (response.statusCode == 200) {
//         final body = response.body;
//
//         if (body.contains("Player not found")) {
//           responseMessage.value = "❌ Player not found in this room.";
//         } else {
//           responseMessage.value = "✅ Response: $body";
//         }
//       } else {
//         responseMessage.value = "❌ Error: ${response.statusCode}";
//       }
//     } catch (e) {
//       logPrint("❌ Exception: $e");
//       responseMessage.value = "❌ Exception: $e";
//     }
//
//     isLoading.value = false;
//   }
//
// }
class ChaalController extends GetxController {
  var responseMessage = ''.obs;
  var isLoading = false.obs;
  var isFirstTimeEntered = true.obs;

  Future<void> sendChaal() async {
    isLoading.value = true;

    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      isLoading.value = false;
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/Chaal');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'RoomID': savedRoomId,
          'UserPhone': phone,
        },
      );

      logPrint("🔹 API Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body.contains("Player not found")) {
          responseMessage.value = "❌ Player not found in this room.";
        } else {
          responseMessage.value = "✅ Response: $body";
        }
      } else {
        responseMessage.value = "❌ Error: ${response.statusCode}";
      }
    } catch (e) {
      logPrint("❌ Exception: $e");
      responseMessage.value = "❌ Exception: $e";
    }

    isLoading.value = false;
  }

  // ⏩ Call this when game screen opens
  Future<void> checkAndSendChaalOnEnter() async {
    if (isFirstTimeEntered.value) {
      await sendChaal();
      isFirstTimeEntered.value = false; // ✅ Only once
    }
  }




  Future<void> sendChaals() async {
    isLoading.value = true;
    final ChaalAmountController controller = Get.put(ChaalAmountController());
    String? phone = await RegistrationController.getPhoneNumber();
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      isLoading.value = false;
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/ChaalWithoutDeduction');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'RoomID': savedRoomId,
          'UserPhone': phone,
          'balance':controller.chaalAmounts[0].amount,
        },
      );

      logPrint("🔹 API Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body;

        if (body.contains("Player not found")) {
          responseMessage.value = "❌ Player not found in this room.";
        } else {
          responseMessage.value = "✅ Response: $body";
        }
      } else {
        responseMessage.value = "❌ Error: ${response.statusCode}";
      }
    } catch (e) {
      logPrint("❌ Exception: $e");
      responseMessage.value = "❌ Exception: $e";
    }

    isLoading.value = false;
  }

  // ⏩ Call this when game screen opens
  Future<void> checkAndSendChaalOnEnters() async {
    if (isFirstTimeEntered.value) {
      await sendChaal();
      isFirstTimeEntered.value = false; // ✅ Only once
    }
  }
}

class BalanceController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateBalance({
    required String token,
    required String bal,
    required String operation,
  }) async {
    try {
      String? phone = await RegistrationController.getPhoneNumber();
      if (phone == null || phone.isEmpty) {
        logPrint("⚠ Phone number missing, aborting request");
        return;
      }

      isLoading.value = true;

      final url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/UpdateBalanceForPlay"
        "?token=$token&Phone=$phone&bal=$bal&operation=$operation",
      );

      logPrint("🔗 Final URL: $url");

      // 🔥 Try GET instead of POST
      final response = await http.get(url);

      logPrint("📥 Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          final message = data['message'] ?? '';
          logPrint("✅ API Response Message: $message");
        } catch (e) {
          logPrint("⚠ JSON Decode Error: $e");
        }
      } else {
        logPrint("❌ API Error: ${response.statusCode}");
      }
    } catch (e) {
      logPrint("⚠ Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

// class PackPlayerController extends GetxController {
//   var responseMessage = ''.obs;
//   var isLoading = false.obs;
//
//   Future<void> packPlayer() async {
//     logPrint('namonarayanmeena');
//     final prefs = await SharedPreferences.getInstance();
//     final savedRoomId = prefs.getString('roomId');
//     String? phone = await RegistrationController
//         .getPhoneNumber(); // 🔹 Get saved phone number
//     if (phone == null || phone.isEmpty) {
//       logPrint("No saved phone number found.");
//       return;
//     }
//
//     final String? jsonString = prefs.getString('all_usernames');
//     if (jsonString == null) {
//       logPrint("No usernames found in SharedPreferences.");
//       return null;
//     }
//
//     final List<dynamic> decoded = jsonDecode(jsonString);
//     final List<String> usernames = decoded.cast<String>();
//     logPrint("sarra $usernames ");
//     for (String username in usernames) {
//       final url = Uri.parse(
//           'https://dhanmantragame.com/APIs/WebService1.asmx/PackPlayer?roomId=$savedRoomId&userphone=$username'
//       );
//     }
//
//       isLoading.value = true;
//     // final url = Uri.parse(
//     //   'https://dhanmantragame.com/APIs/WebService1.asmx/PackPlayer?roomId=$savedRoomId&userphone=$phone',
//     // );
//
//     try {
//       final res = await http.get(url);
//
//       if (res.statusCode == 200) {
//         final doc = xml.XmlDocument.parse(res.body);
//         final result = doc.findAllElements('string').first.text;
//         responseMessage.value = result;
//         logPrint ('mainresult${result}');
//       } else {
//         responseMessage.value = 'Failed with status: ${res.statusCode}';
//       }
//     } catch (e) {
//       responseMessage.value = 'Error: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// class PackPlayerController extends GetxController {
//   var responseMessage = ''.obs;
//   var isLoading = false.obs;
//
//   Future<void> packPlayer() async {
//     logPrint('namonarayanmeena');
//
//     final prefs = await SharedPreferences.getInstance();
//     final savedRoomId = prefs.getString('roomId');
//     String? phone = await RegistrationController.getPhoneNumber();
//
//     if (phone == null || phone.isEmpty) {
//       logPrint("No saved phone number found.");
//       return;
//     }
//
//     final String? jsonString = prefs.getString('all_usernames');
//     if (jsonString == null) {
//       logPrint("No usernames found in SharedPreferences.");
//       return;
//     }
//
//     final List<dynamic> decoded = jsonDecode(jsonString);
//     final List<String> usernames = decoded.cast<String>();
//     logPrint("sarra $usernames");
//
//     isLoading.value = true;
//
//     try {
//       for (String username in usernames) {
//         final url = Uri.parse(
//           'https://dhanmantragame.com/APIs/WebService1.asmx/PackPlayer'
//               '?roomId=$savedRoomId&userphone=$username',
//         );
//
//         final res = await http.get(url);
//
//         if (res.statusCode == 200) {
//           final doc = xml.XmlDocument.parse(res.body);
//           final result = doc.findAllElements('string').first.text;
//           responseMessage.value = result;
//           logPrint('Result for $username: $result');
//         } else {
//           logPrint('Failed for $username with status: ${res.statusCode}');
//         }
//       }
//     } catch (e) {
//       responseMessage.value = 'Error: $e';
//       logPrint('Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
class PackPlayerController extends GetxController {
  var responseMessage = ''.obs;
  var isLoading = false.obs;

  Future<void> packPlayer(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final savedRoomId = prefs.getString('roomId');

    if (savedRoomId == null || savedRoomId.isEmpty) return;

    isLoading.value = true;
    try {
      final url = Uri.parse(
        'https://dhanmantragame.com/APIs/WebService1.asmx/PackPlayer'
        '?roomId=$savedRoomId&userphone=$username',
      );

      final res = await http.get(url);

      if (res.statusCode == 200) {
        final doc = xml.XmlDocument.parse(res.body);
        final result = doc.findAllElements('string').first.text;
        responseMessage.value = result;
        logPrint('Packed $username: $result');
      } else {
        responseMessage.value =
            'Failed for $username with status: ${res.statusCode}';
      }
    } catch (e) {
      responseMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

class TeenPattiTableTab extends StatelessWidget {
  TeenPattiTableTab({super.key});

  final RoomPlayerController Roomplayerscontroller =
      Get.put(RoomPlayerController());
  final RoomController controller = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    final registercontroller = Get.find<RegisterController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            await Future.delayed(
                                const Duration(milliseconds: 300));
                            String? phone =
                                await RegistrationController.getPhoneNumber();

                            if (phone == null || phone.isEmpty) {
                              // Get.snackbar("Error", "Phone number not found");
                              return;
                            }

                            final prefs = await SharedPreferences.getInstance();
                            final savedRoomId = prefs.getString('roomId');

                            if (savedRoomId != null) {
                              await controller.removeUserBeforeStart(
                                  phone, savedRoomId);
                            } else {
                              // Get.snackbar("Error", "No Room ID saved");
                              return;
                            }

                            Get.back();
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
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/paymentimages/rummybackground.png'),
                  fit: BoxFit.cover,
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
                    final playerCount = Roomplayerscontroller.playerList.length;
                    final isStarting =
                        Roomplayerscontroller.isGameStarting.value;
                    final countdown = Roomplayerscontroller.countdown.value;
                    final disableInteractions =
                        playerCount < 5 && !isStarting && countdown == 0;

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
                                  screenWidth - ResponsiveHelpers.w(360) - 100,
                                  ResponsiveHelpers.h(130)),
                              Offset(ResponsiveHelpers.w(280),
                                  screenHeight / 2 - ResponsiveHelpers.h(-50)),
                              Offset(
                                  screenWidth - ResponsiveHelpers.w(280) - 100,
                                  screenHeight / 2 - ResponsiveHelpers.h(-50)),
                            ];

                            return Stack(
                              children: [
                                Positioned(
                                  bottom: ResponsiveHelpers.h(20),
                                  left: (screenWidth / 2) - 50,
                                  child: PlayerIcon(
                                    showEye: true,
                                    card1: bottomPlayer.card1,
                                    card2: bottomPlayer.card2,
                                    card3: bottomPlayer.card3,
                                    imageUrl:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                                    name: '${bottomPlayer.username}',
                                    amount: bottomPlayer.balance,
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
                                        imageUrl:
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                                        name: player.username,
                                        amount: player.balance,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }),

                          // Game Title
                          Positioned(
                            top: ResponsiveHelpers.h(300),
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

                          // Right Bottom Buttons
                          Positioned(
                            right: 60,
                            bottom: 10,
                            child: GameActionButtons(),
                          ),

                          // Buy Button (Center)
                          Positioned(
                            left: ResponsiveHelpers.h(550),
                            bottom: ResponsiveHelpers.h(270),
                            child: BuyButton(
                              amount: '20000',
                              showBorder: true,
                              showLottie: true,
                              lottieWidth: 40,
                              lottieHeight: 60,
                              lottieLeft: -30,
                              lottieBottom: -13.6,
                            ),
                          ),

                          // Room ID top right
                          Positioned(
                            right: 200,
                            top: 50,
                            child: Obx(() {
                              final response = controller.roomResponse.value;
                              if (response != null) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  message = "Waiting for players...";
                  bgColor = Colors.black.withOpacity(0.8);
                } else if (isStarting && countdown > 0) {
                  message = "Game starting in $countdown...";
                  bgColor = Colors.orange.withOpacity(0.9);
                }

                return message != null
                    ? Container(
                        width: double.infinity,
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
                              fontSize: 60,
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
  final bool showEye; // 👈 New bool
  // 👈 New bool

  const PlayerIcon({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.card1,
    required this.card2,
    required this.card3,
    this.showEye = true, // 👈 default true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoomPlayerController controller = Get.find();

    return Obx(() {
      final bool showFront = controller.revealedUsername.value == name;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 👁 Eye toggle button, conditionally shown
          if (showEye && !showFront)
            IconButton(
              icon: const Icon(Icons.remove_red_eye,
                  color: Colors.white, size: 25),
              onPressed: () {
                controller.reveal(name);
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

          // 🧑 Avatar

          Obx(() {
            logPrint(
                'ActiveTurnUsername: ${controller.activeTurnUsername.value}, Current: $name');

            final isMyTurn =
                controller.activeTurnUsername.value.trim() == name.trim();
            final timeLeft = (controller.turnProgress.value * 20).ceil();

            return Stack(
              alignment: Alignment.center,
              children: [
                if (isMyTurn)
                  SizedBox(
                    width: ResponsiveHelpers.r(90),
                    height: ResponsiveHelpers.r(90),
                    child: CircularProgressIndicator(
                      value: controller.turnProgress.value,
                      strokeWidth: 6,
                      color: Colors.blueAccent,
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
                if (isMyTurn)
                  Text(
                    '$timeLeft',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveHelpers.sp(16),
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
              ],
            );
          }),

          SizedBox(height: ResponsiveHelpers.h(6)),

          // 🏷 Name
          Text(
            name,
            style: TextStyle(
              fontSize: ResponsiveHelpers.sp(14),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // 💰 BuyButton
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
      );
    });
  }
}

Widget buildCard(double offsetX, double angle, String cardName, double offsetY,
    bool showFront) {
  final String backImage = 'https://dhanmantragame.com/Images/Back.jpg';
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

// class GameActionButtons extends StatelessWidget {
//   GameActionButtons({super.key});
//   final packPlayerController = Get.put(PackPlayerController());
//   final RoomPlayerController Roomplayerscontroller = Get.put(RoomPlayerController());
//   final ChaalController controller = Get.put(ChaalController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
//       padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildActionButton(
//             text: "Pack",
//             onPressed: () {
//               final packPlayerController = Get.put(PackPlayerController());
//               String currentUsername = Roomplayerscontroller.activeTurnUsername.value;
//               packPlayerController.packPlayer(currentUsername);
//               Obx(() => Text(packPlayerController.responseMessage.value));
//               // TODO: Add Pack logic here
//             },
//
//           ),
//           // _buildActionButton(
//           //   text: "Show",
//           //   onPressed: () {
//           //
//           //   },
//           //
//           // ),
//           _buildActionButton(
//             text: "Chaal",
//             onPressed: () {
//               controller.sendChaal();
//
//               Roomplayerscontroller.passTurn();
//               Obx(() {
//                 if (Roomplayerscontroller.message.isNotEmpty) {
//                   return Text(
//                       "Response: ${Roomplayerscontroller.message.value}");
//                 }
//                 return SizedBox();
//               });
//               // TODO: Add Chaal logic here
//             },
//
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String text,
//     required VoidCallback onPressed,
//
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: ReusableButton(
//         text: text,
//         isShimmer: true,
//         shimmerDuration: const Duration(seconds: 3),
//         onPressed: onPressed,
//         width: ResponsiveHelpers.w(150),
//         height: ResponsiveHelpers.h(40),
//         borderRadius: 5,
//         fontSize: 15,
//         backgroundColor: Colors.black.withOpacity(0.6),
//         textColor: Colors.white,
//         borderColor: Colors.yellow,
//         borderWidth: 1,
//       ),
//     );
//   }}
//
class CounterController extends GetxController {
  var count = 20.0.obs; // double value with .0

  void increase() {
    count.value = count.value * 2.0; // increase by 1.0
  }

  void decrease() {
    if (count.value > 0) {
      count.value = count.value - 1.0; // decrease by 1.0
    }
  }
}

// class GameActionButtons extends StatelessWidget {
//   GameActionButtons({super.key});
//
//   final packPlayerController = Get.put(PackPlayerController());
//   final RoomPlayerController Roomplayerscontroller =
//       Get.put(RoomPlayerController());
//   final ChaalController controller = Get.put(ChaalController());
//   final CounterController countercontroller = Get.put(CounterController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
//       padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // ✅ Pack button
//           _buildActionButton(
//             text: "Pack",
//             onPressed: () {
//               final packPlayerController = Get.put(PackPlayerController());
//               String currentUsername =
//                   Roomplayerscontroller.activeTurnUsername.value;
//               packPlayerController.packPlayer(currentUsername);
//             },
//           ),
//
//           SizedBox(width: 10),
//
//           // ✅ + , Chaal , - ek sath
//           Row(
//             children: [
//               _buildIconButton(
//                   icon: Icons.add,
//                   onPressed: () {
//                     final currentPlayerPhone =
//                         Roomplayerscontroller.currentUserPhone.value;
//                     final activePlayer = Roomplayerscontroller.activeTurnUsername.value;
//                     if (currentPlayerPhone != activePlayer || Roomplayerscontroller.turnCompleted) {
//                       logPrint("Not your turn!");
//                       return;
//                     }
//
//                     // ✅ + allowed
//                     if (!Roomplayerscontroller.modifiedThisTurn) {
//                       countercontroller.increase();
//
//                       final controllert = Get.put(ChaalAmountController());
//                       controllert.multiplyAmount();
//
//                       Roomplayerscontroller.modifiedThisTurn = true; // अब दुबारा allow नहीं
//                     } else {
//                       logPrint("Already multiplied this turn!");
//                     }
//               // + button
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Center(
//                         child: ChaalAmountText(),
//                       ),
//                     ],
//                   ),
//                   _buildActionButton(
//                     text: "Chaal",
//                     onPressed: () {
//                     final currentPlayerPhone =
//                     Roomplayerscontroller.currentUserPhone.value;
//                     final activePlayer =
//                     Roomplayerscontroller.activeTurnUsername.value;
//
//                     // ✅ Only active player can play
//                     if (currentPlayerPhone != activePlayer) {
//                     logPrint("It's not your turn!");
//                     return;
//                     }
//
//                     // ✅ Only allow once per turn
//                     if (Roomplayerscontroller.turnCompleted) {
//                     logPrint("You already played this turn!");
//                     return;
//                     }
//
//                       // Play animation and sound
//                       final coinAnimController =
//                           Get.put(CoinAnimationController());
//                       final soundController = Get.put(SoundController());
//                       soundController.playCoinSound();
//                       coinAnimController
//                           .playAnimation("+${countercontroller.count}.0");
//
//                       // controller.sendChaal();
//
//                       BalanceController balancecontroller =
//                           Get.put(BalanceController());
//                       ChaalAmountController updablance =
//                           Get.put(ChaalAmountController());
//                       balancecontroller.updateBalance(
//                           token: 'BETLAJDNDNDBARKXTER',
//                           bal: updablance.chaalAmounts[0].amount,
//                           operation: "SUB");
//                       // ✅ Mark turn as completed so button won't work again
//                       Roomplayerscontroller.turnCompleted = true;
//
//                       // ✅ Optionally, pass the turn automatically or let timer handle it
//                       Roomplayerscontroller.passTurn();
//                     },
//                   ),
//                 ],
//               ),
//               _buildIconButton(
//                   icon: Icons.remove,
//                   onPressed: () {
//                     final currentPlayerPhone =
//                         Roomplayerscontroller.currentUserPhone.value;final activePlayer = Roomplayerscontroller.activeTurnUsername.value;
//                     if (currentPlayerPhone != activePlayer || Roomplayerscontroller.turnCompleted) {
//                       logPrint("Not your turn!");
//                       return;
//                     }
//
//                     // ✅ Sirf isi turn me kam karne ki ijazat
//                     if (!Roomplayerscontroller.modifiedThisTurn) {
//                       logPrint(
//                           "You can only decrease in same turn after increase!");
//                       return;
//                     }
//
//                     final controllert = Get.put(ChaalAmountController());
//                     ChaalAmountController Chaalcontroller = Get.put(ChaalAmountController());
//
//
//                     controllert.decreaseAmount(20);
//                   }), // - button
//             ],
//           ),
//         ],
//       ),
//     );
//   }
class GameActionButtons extends StatelessWidget {
  GameActionButtons({super.key});

  final packPlayerController = Get.put(PackPlayerController());
  final RoomPlayerController Roomplayerscontroller =
  Get.put(RoomPlayerController());
  final ChaalController controller = Get.put(ChaalController());
  final CounterController countercontroller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ✅ Pack button
          _buildActionButton(
            text: "Pack",
            onPressed: () {
              String currentUsername =
                  Roomplayerscontroller.activeTurnUsername.value;
              packPlayerController.packPlayer(currentUsername);
            },
          ),

          SizedBox(width: 10),

          // ✅ + , Chaal , - ek sath
          Row(
            children: [
              // ➕ Button
              _buildIconButton(
                icon: Icons.add,
                onPressed: () {
                  final currentPlayerPhone = Roomplayerscontroller.currentUserPhone.value;
                  final activePlayer = Roomplayerscontroller.activeTurnUsername.value;

                  if (currentPlayerPhone != activePlayer ||
                      Roomplayerscontroller.turnCompleted) {
                    logPrint("Not your turn!");
                    return;
                  }

                  if (Roomplayerscontroller.increasedThisTurn) {
                    logPrint("Already increased once this turn!");
                    return;
                  }

                  countercontroller.increase();
                  final controllert = Get.put(ChaalAmountController());
                  controllert.multiplyAmount();
                  UpdateChaalController updatecontrollerchal = Get.put(UpdateChaalController());
                  updatecontrollerchal.updateChaalAmount(amount: '', type: 'ADD');
                  Roomplayerscontroller.increasedThisTurn = true; // ✅ Increase done
                  Roomplayerscontroller.decreasedThisTurn = false; // ✅ Reset for this turn
                },
              ),
              // Center Column with Chaal Amount + Chaal Button
              Column(
                children: [
                  Row(
                    children: [
                      Center(
                        child: ChaalAmountText(),
                      ),
                    ],
                  ),
                  _buildActionButton(
                    text: "Chaal",
                    onPressed: () {
                      final currentPlayerPhone =
                          Roomplayerscontroller.currentUserPhone.value;
                      final activePlayer =
                          Roomplayerscontroller.activeTurnUsername.value;

                      // ✅ Only active player can play
                      if (currentPlayerPhone != activePlayer) {
                        logPrint("It's not your turn!");
                        return;
                      }

                      // ✅ Only allow once per turn
                      if (Roomplayerscontroller.turnCompleted) {
                        logPrint("You already played this turn!");
                        return;
                      }

                      // Play animation and sound
                      final coinAnimController =
                      Get.put(CoinAnimationController());
                      final soundController = Get.put(SoundController());
                      soundController.playCoinSound();
                      coinAnimController
                          .playAnimation("+${countercontroller.count}.0");

                      controller.sendChaals();

                      BalanceController balancecontroller =
                      Get.put(BalanceController());
                      ChaalAmountController updablance =
                      Get.put(ChaalAmountController());
                      balancecontroller.updateBalance(
                        token: 'BETLAJDNDNDBARKXTER',
                        bal: updablance.chaalAmounts[0].amount,
                        operation: "SUB",
                      );

                      // ✅ Mark turn as completed
                      Roomplayerscontroller.turnCompleted = true;

                      // ✅ Reset for next turn
                      Roomplayerscontroller.passTurn();
                    },
                  ),
                ],
              ),

              // ➖ Button
              _buildIconButton(
                icon: Icons.remove,
                onPressed: () {
                  final currentPlayerPhone = Roomplayerscontroller.currentUserPhone.value;
                  final activePlayer = Roomplayerscontroller.activeTurnUsername.value;

                  if (currentPlayerPhone != activePlayer ||
                      Roomplayerscontroller.turnCompleted) {
                    logPrint("Not your turn!");
                    return;
                  }

                  if (!Roomplayerscontroller.increasedThisTurn) {
                    logPrint("You must press + first before - !");
                    return;
                  }

                  if (Roomplayerscontroller.decreasedThisTurn) {
                    logPrint("Already decreased once this turn!");
                    return;
                  }

                  final controllert = Get.put(ChaalAmountController());
                  controllert.decreaseAmount(20);
                  UpdateChaalController updatecontrollerchal = Get.put(UpdateChaalController());
                  updatecontrollerchal.updateChaalAmount(amount: '', type: 'SUB');
                  Roomplayerscontroller.increasedThisTurn = false;
                  Roomplayerscontroller.decreasedThisTurn = true; // ✅ Only once
                },
              ),

            ],
          ),
        ],
      ),
    );
  }

  /// 🔘 Normal Action Button (Pack, Chaal etc.)
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: ResponsiveHelpers.w(150),
        height: ResponsiveHelpers.h(40),
        borderRadius: 5,
        fontSize: 15,
        backgroundColor: Colors.black.withOpacity(0.6),
        textColor: Colors.white,
        borderColor: Colors.yellow,
        borderWidth: 1,
      ),
    );
  }

  /// ➕➖ Small Icon Buttons (UI only)
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: ResponsiveHelpers.w(30),
          height: ResponsiveHelpers.h(30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            border: Border.all(color: Colors.yellow, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class ShowButtons extends StatelessWidget {
  ShowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            text: "Show",
            onPressed: () {
              final RoomPlayerController Roomplayerscontroller =
                  Get.put(RoomPlayerController());
              Roomplayerscontroller.fetchWinnerAndShowAlert();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: ResponsiveHelpers.w(150),
        height: ResponsiveHelpers.h(40),
        borderRadius: 5,
        fontSize: 15,
        backgroundColor: Colors.black.withOpacity(0.6),
        textColor: Colors.white,
        borderColor: Colors.yellow,
        borderWidth: 1,
      ),
    );
  }
}

class SideShowButtons extends StatelessWidget {
  SideShowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveHelpers.h(2)),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelpers.w(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            text: "Side Show",
            onPressed: () {
              final RoomPlayerController Roomplayerscontroller =
                  Get.put(RoomPlayerController());
              Roomplayerscontroller.fetchWinnerAndShowAlert();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: ResponsiveHelpers.w(150),
        height: ResponsiveHelpers.h(40),
        borderRadius: 5,
        fontSize: 15,
        backgroundColor: Colors.black.withOpacity(0.6),
        textColor: Colors.white,
        borderColor: Colors.yellow,
        borderWidth: 1,
      ),
    );
  }
}

class SoundController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playCoinSound() async {
    try {
      await _audioPlayer.play(
        AssetSource("audio/mixkit-clinking-coins-1993.ogg"),
      );
    } catch (e) {
      logPrint("Error playing sound: $e");
    }
  }
}

class CoinAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> opacityAnim;
  late Animation<Offset> slideAnim;
  late Animation<double> scaleAnim;
  var isPlaying = false.obs;
  var floatingText = "".obs;

  @override
  void onInit() {
    super.onInit();

    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    opacityAnim = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeOut),
    );

    slideAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
        .animate(
            CurvedAnimation(parent: animController, curve: Curves.easeOut));

    scaleAnim = Tween<double>(begin: 1, end: 1.8).animate(
      CurvedAnimation(parent: animController, curve: Curves.elasticOut),
    );
  }

  void playAnimation(String text) {
    floatingText.value = text;
    animController.forward(from: 0);
  }
}

class CoinAnimationScreen extends StatelessWidget {
  CoinAnimationScreen({super.key});

  final coinAnimController = Get.put(CoinAnimationController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => SlideTransition(
            position: coinAnimController.slideAnim,
            child: FadeTransition(
              opacity: coinAnimController.opacityAnim,
              child: ScaleTransition(
                scale: coinAnimController.scaleAnim,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Show Coin only when animation is playing
                    if (coinAnimController.isPlaying.value)
                      Lottie.asset(
                        "assets/paymentimages/coinimage.json",
                        width: 50,
                        height: 50,
                        repeat: false,
                      ),

                    // Amount text above coin
                    Positioned(
                      top: -25, // coin ke upar
                      child: Shimmer.fromColors(
                        baseColor: Colors.amber.shade400,
                        highlightColor: Colors.yellow.shade100,
                        child: Text(
                          "${coinAnimController.floatingText.value}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// class ChaalAmountText extends StatelessWidget {
//   final ChaalAmountController controller = Get.put(ChaalAmountController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return SizedBox(
//           height: 50,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }
//
//       if (controller.chaalAmounts.isEmpty) {
//         return SizedBox(
//           height: 50,
//           child: Center(
//             child: Text(
//               "No data",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       }
//
//       // ✅ Sirf first element ka amount
//
//       final baseAmount = controller.chaalAmounts[0].amount;
//
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // ✅ Amount Text
//            Text(
//                 // "₹${controller.displayAmount.value == 0 ? baseAmount : controller.displayAmount.value}",
//                 "₹${baseAmount}",
//
//                 style: TextStyle(
//                   color: Colors.yellowAccent,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//         ],
//       );
//     });
//   }
// }
class ChaalAmountText extends StatelessWidget {
  final ChaalAmountController controller = Get.put(ChaalAmountController());

  @override
  Widget build(BuildContext context) {
    // Widget load hote hi API call
    controller.fetchChaalAmounts();

    return StreamBuilder<List<ShowChaalAmount>>(
      stream: controller.chaalStream, // 👈 yaha stream use ho rahi hai
      builder: (context, snapshot) {
        if (controller.isLoading.value) {
          return SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "No data",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final baseAmount = snapshot.data![0].amount;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹$baseAmount",
              style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
// pubspec.yaml: add
// dependencies:
//   google_fonts: ^6.0.0   # (or latest)

