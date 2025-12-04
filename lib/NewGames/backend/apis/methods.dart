import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../main.dart';
import '../../../screens/allScreens/allscreens.dart';
import '../../../screens/home/home_screen.dart';
import '../../games/color-pred/color_pred.dart';
import '../models/predictionresult.dart';
import '../models/probablity.dart';
import '../models/refer.dart';
import '../models/result.dart';
import '../models/transactions.dart';
import '../models/user.dart';
import '../models/userbalance.dart';


class AppServices {
  static String createRandomId(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    math.Random random = math.Random();

    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  static Future<void> registerUser(
    BuildContext context, {
    String email = '',
    String password = '',
    String name = '',
    String phone = '',
    String username = '',
    String type = '',
    String balance = '',
    String friendRefer = "",
    bool isGoogleSign = false,
  }) async {
    // Generate a random 5-digit referral code
    String generateReferCode() {
      final random = math.Random();
      return (random.nextInt(90000) + 10000)
          .toString(); // Ensures a 5-digit code
    }

    // Add generated refer code for "Create" type or Google Sign-In
    String referCode =
        (type == 'Create' || isGoogleSign) ? generateReferCode() : '';

    Map<String, String> requestBody = {
      'token': "RMNAJAMDNAFJNFTAMI",
      'email': email.isEmpty ? '' : email,
      'password': password.isEmpty ? '' : password,
      'name': name.isEmpty ? '' : name,
      'phone': phone.isEmpty ? '' : phone,
      'username': email.isNotEmpty && phone.isNotEmpty
          ? email[0] + email[1] + phone
          : '',
      'type': type.isEmpty ? '' : type,
      'balance': balance.isEmpty ? '' : balance,
      'refercode': referCode,
      'refer2': friendRefer,
    };

    log(requestBody.toString());

    log("Saved Mobile Number: $phone");
    log(requestBody.toString());

    try {
      if (isGoogleSign) {
        // Google Sign-In Flow
        requestBody['type'] = 'Create';
        http.Response response = await http.post(
          Uri.parse('https://victorygame.in/apis/apis.asmx/Register'),
          body: requestBody,
        );

        if (response.statusCode == 200) {
          final msg = jsonDecode(response.body)["message"];

          if (msg == "User Already Exists.") {
            Fluttertoast.showToast(msg: "This email is already registered.");
            return; // Stop further execution
          }
        }
      } else {
        // Normal Registration and Login Flow
        http.Response response = await http.post(
          Uri.parse('https://victorygame.in/apis/apis.asmx/Register'),
          body: requestBody,
        );

        if (response.statusCode == 200) {
          if (type == "Create") {
            final msg = jsonDecode(response.body)["message"];
            if (msg == "Invalid ReferCode!") {
              Fluttertoast.showToast(msg: msg);
            } else if (msg == "User Already Exists.") {
              Fluttertoast.showToast(msg: msg);
            } else {
              const FlutterSecureStorage secureStorage = FlutterSecureStorage();
              await secureStorage.write(key: "Email", value: email);

              Fluttertoast.showToast(msg: "Registration Done");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainHomeScreen();
                  },
                ),
                (s) {
                  return false;
                },
              );
            }
          } else if (type == "Login") {
            final msg = jsonDecode(response.body)["message"];
            if (msg == "Please Register First.") {
              const FlutterSecureStorage secureStorage = FlutterSecureStorage();
              await secureStorage.write(key: "phone", value: email);
              Fluttertoast.showToast(msg: "Registration Done");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainHomeScreen();
                  },
                ),
                (s) {
                  return false;
                },
              );
            } else {
              Fluttertoast.showToast(msg: "Invalid Credentials");
            }
          } else if (type == "Forgot Password") {
            Fluttertoast.showToast(msg: "Email Sent Successfully");
          } else if (type == "Update Balance" || type == "Update") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainHomeScreen();
                },
              ),
              (s) {
                return false;
              },
            );
          }
        } else {
          if (kDebugMode) {
            logPrint("Failed to register user: ${response.statusCode}");
          }
        }
      }
    } catch (e) {
      // Error handling
      if (kDebugMode) {
        logPrint("Error occurred: $e");
      }
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    }
  }

  static Future<void> insertTransaction({
    required String phone,
    required String transactionId,
    required String amount,
    required String date,
    required String type,
    String? accNumber,
    String? ifsc,
    String? branch,
    String? upi,
  }) async {
    Map<String, String> requestBody = {
      'token': 'RMNAJAMDNAFJNFTAMI',
      'phone': phone,
      'transactionid': transactionId,
      'amount': amount,
      'date': date,
      'accountnumber': accNumber ?? "",
      'ifsc': ifsc ?? "",
      'branch': branch ?? "",
      'upi': upi ?? "",
      'type': type,
    };

    log("🔻 Request Body: $requestBody");

    try {
      http.Response response = await http.post(
        Uri.parse('https://victorygame.in/apis/apis.asmx/InsertTransactions'),
        body: requestBody,
      );

      log("🔻 Status Code: ${response.statusCode}");
      log("🔻 Raw Response Body: '${response.body}'");

      if (response.statusCode == 200) {
        try {
          final decoded = json.decode(response.body);

          if (decoded is Map<String, dynamic>) {
            log("✅ Decoded Response: $decoded");

            String message = decoded["message"] ?? "No message";

            if (message == "Transaction Inserted!") {
              Fluttertoast.showToast(
                msg: type == "Withdraw"
                    ? "Transaction Inserted Successfully, You will receive your payout within 24 Hours"
                    : "Transaction Inserted Successfully",
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
            } else {
              Fluttertoast.showToast(
                msg: "⚠️ $message",
                backgroundColor: Colors.orange,
                textColor: Colors.white,
              );
            }
          } else {
            throw FormatException("Response is not a JSON object");
          }
        } catch (e) {
          log("❌ JSON Decode Error: $e\nResponse body: ${response.body}");
          Fluttertoast.showToast(
            msg: "Failed to parse response",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "❌ Failed to insert transaction: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      log("❌ HTTP Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  static Future<void> updateWalletBalance(String email, String balance, String operation) async {
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      // return null;
    }

    Map<String, String> requestBody = {

      'token': 'BETLAJDNDNDBARKXTER',

      'Phone': phone!,

      'bal': balance.isEmpty ? '' : balance,
      'operation':operation.isEmpty ? '' : operation,
    };

    log(requestBody.toString());
    try {
      logPrint ("heoeleoelel $email");
      http.Response response = await http.post(
        Uri.parse('https://dhanmantragame.com/apis/webservice1.asmx/UpdateBalanceForPlay'),
        body: requestBody,
      );
      if (kDebugMode) {
        logPrint(response.body);
      }

      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "Balance Updated Successfully");
      }
    } catch (e) {
      // Error handling
      if (kDebugMode) {
        logPrint("Error occurred: $e");
      }
    }
  }

  static Future<void> insertAviatorBet({required String result}) async {
    try {
      final url = 'https://victorygame.in/apis/apis.asmx/InsertAviatorLast?token=RMNAJAMDNAFJNFTAMI&Result=$result';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "Bet Placed Successfully");
      } else {
        // Fluttertoast.showToast(msg: "Failed to Place Bet: ${response.body}");
        // throw Exception('Failed to place bet: ${response.body}');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
      throw Exception('Error occurred: $error');
    }
  }

  static Future<void> insertWheelBet(
    context, {
    required String roundId,
    required String color,
    required String amount,
    required String xValue,
  }) async {
    try {
      String? phone = await RegistrationController
          .getPhoneNumber();
      final url =
          'https://dhanmantragame.com/apis/WebService1.asmx/InsertBetWheel?token=RMNAJAMDNAFJNFTAMI&roundid=$roundId&color=$color&phone=$phone  &amount=$amount&x=$xValue';
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        logPrint(url);
      }

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Bet Placed Successfully");
        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Failed to Place Bet: ${response.body}");
        throw Exception('Failed to place bet: ${response.body}');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
      throw Exception('Error occurred: $error');
    }
  }

  // static Future<void> insertColorPredictionBet(
  //   context, {
  //   required String roundId,
  //   required String number,
  //   required String type,
  //   required String amount,
  //   required String date,
  // }) async {
  //   try {
  //     final email = await getEmail();
  //     final url =
  //         '$baseurl/InsertColorPredictionBet?token=$token&roundid=$roundId&number=$number&phone=$email&type=$type&amount=$amount&date=$date';
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(msg: "Bet Placed Successfully");
  //       Navigator.pop(context);
  //     } else {
  //       Fluttertoast.showToast(msg: "Failed to Place Bet: ${response.body}");
  //       throw Exception('Failed to place bet: ${response.body}');
  //     }
  //   } catch (error) {
  //     Fluttertoast.showToast(msg: "Error: $error");
  //     throw Exception('Error occurred: $error');
  //   }
  // }

  static Future<void> insertColorPredictionBet(
    context, {
    required String roundId,
    required String number,
    required String type,
    required String amount,
    required String date,
  }) async {
    try {
      // Retrieve the mobile number from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? mobile = prefs.getString('phone');
      String? phone = await RegistrationController
          .getPhoneNumber(); // 🔹 Get saved phone number

        // return null;


      // if (mobile == null) {
      //   // If no mobile number is found, show an error
      //   Fluttertoast.showToast(
      //     msg: "Mobile number not found. Please log in again.",
      //   );
      //   return;
      // }

      // Construct the URL with the saved mobile number

      final url =
          'https://dhanmantragame.com/apis/webservice1.asmx/InsertColorPredictionBet?token=RMNAJAMDNAFJNFTAMI&roundid=$roundId&number=$number&phone=$phone &type=$type&amount=$amount&date=$date&email=$mobile';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Bet Placed Successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Failed to Place Bet: ${response.body}");
        throw Exception('Failed to place bet: ${response.body}');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
      throw Exception('Error occurred: $error');
    }
  }

  static Future<List<User>> getProfile() async {
    final mobile = await getMobile();
    String? phone='7303298840';
    // String? phone = await RegistrationController
    //     .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      // return null;
    }
    logPrint('phondndn ${phone}');
    // final url = 'https://victorygame.in/apis/apis.asmx/GetProfile?token=RMNAJAMDNAFJNFTAMI&email=$mobile';
    final url = 'https://victorygame.in/apis/apis.asmx/GetProfile?token=RMNAJAMDNAFJNFTAMI&email=1234567890';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        logPrint(url);
      }
      // logPrint(response.body);
      return User.getUserFromMap(response.body);
    } else {
      throw response.body;
    }
  }

  static Future<String> getWheelResult() async {
    final roundId = TimerUtils.getCompletionTimeForWheel(20);
    final url = 'https://dhanmantragame.com/apis/WebService1.asmx/GetWheelResult?token=RMNAJAMDNAFJNFTAMI&roundid=$roundId';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      final String color = jsonDecode(response.body)["message"].toString();
      return color;
    } else {
      throw response.body;
    }
  }

  static Future<List<AviatorResults>> getAviatorResults() async {
    final url = 'https://victorygame.in/apis/apis.asmx/ShowLastAviator?token=RMNAJAMDNAFJNFTAMI';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        logPrint(url);
      }
      // logPrint(response.body);
      return aviatorResultsFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  static Future<List<TransactionsHistory>> getTransactions() async {
    final mobile = await getMobile();
    final url = 'https://victorygame.in/apis/apis.asmx/GetTransactions?token=RMNAJAMDNAFJNFTAMI&phone=$mobile';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        logPrint(url);
      }
      return transactionsHistoryFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  // static Future<List<NotificationsModel>> getNotifications(String email) async {
  //   final mobile = await getMobile();
  //   final url = '$baseurl/Notifications?token=$token&email=$mobile';
  //   http.Response response = await http.get(Uri.parse(url));
  //   log(url);
  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       logPrint(url);
  //     }
  //     return notificationsModelFromJson(response.body);
  //   } else {
  //     throw response.body;
  //   }
  // }

  static Future forgotRequest(String email) async {
    final url = 'https://victorygame.in/apis/apis.asmx/forgot?emailid=$email';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Email Sent Successfully");
    } else {
      throw response.body;
    }
  }

  static Future<Map<String, String>> getReferCode() async {
    final mobile = await getMobile();
    final url = 'https://victorygame.in/apis/apis.asmx/GetReferCode?token=RMNAJAMDNAFJNFTAMI&phone=$mobile';
    http.Response response = await http.get(Uri.parse(url));
    log(url);

    if (response.statusCode == 200) {
      List<GetReferData> data = getReferDataFromJson(response.body);
      if (data.isNotEmpty) {
        return {"referCode": data.first.referCode, "email": data.first.phone};
      } else {
        throw "No data found";
      }
    } else {
      throw response.body;
    }
  }

  static Future<List<Probablity>> getProbality() async {
    const url = 'https://dhanmantragame.com/apis/webservice1.asmx/GetProb?token=BETLAJDNDNDBARKXTER&Game=Aviator';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      return probablityFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  static Future<List<Probablity>> getMines() async {
    const url = 'https://dhanmantragame.com/apis/webservice1.asmx/GetProb?token=BETLAJDNDNDBARKXTER&Game=Mines';
    http.Response response = await http.get(Uri.parse(url));
    log(url);
    if (response.statusCode == 200) {
      return probablityFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  static Future<void> declareColorPredResult(
    String date,
    String roundid,
  ) async {
    final url =
        'https://dhanmantragame.com/apis/WebService1.asmx/GetColorResult?token=RMNAJAMDNAFJNFTAMI&date=$date&roundid=$roundid';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log(response.body);
      Fluttertoast.showToast(msg: "Result Declared");
    } else {
      throw response.body;
    }
  }

  static Future<List<int>> getPredResult(String roundId) async {
    final url = 'https://dhanmantragame.com/apis/Webservice1.asmx/GetHistory?token=RMNAJAMDNAFJNFTAMI&roundid=$roundId';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = PredictionResult.fromJson(response.body);
      final results = data.map((item) => int.parse(item.result)).toList();
      return results;
    } else {
      throw response.body;
    }
  }

  // static Future<List<UserBalance>> getWallet() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? mobile = prefs.getString('phone');
  //   final url = '$baseurl/GetWallet?token=$token&email=$mobile';
  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       logPrint(response.body);
  //       logPrint("this is email $mobile");
  //     }
  //     return userBalanceFromJson(response.body);
  //   } else {
  //     throw response.body;
  //   }
  // }

  static Future<List<UserBalance>> getWallet() async {
    // final mobile = await getMobile();
    // // String? phone = await RegistrationController
    // //     .getPhoneNumber();
    // String? phone='7303298840';
    // if (phone == null || phone.isEmpty) {
    //   logPrint("No saved phone number found.");
    //   // return null;
    // }
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");
      // return null;
    }
    logPrint("dkkkkkkkkkkkkkkkkkkkkkkkkk${phone}");
    // final url = 'https://victorygame.in/apis/apis.asmx/GetWallet?token=RMNAJAMDNAFJNFTAMI&email=$mobile';
    final url = 'https://dhanmantragame.com/apis/webservice1.asmx/ShowProfile?token=BETLAJDNDNDBARKXTER&phone=$phone';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        logPrint(response.body);
      }
      return userBalanceFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  static getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString('phone');

    if (mobile == null || mobile.isEmpty) {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      // Example of how you might save the mobile number securely
      String mobileNumber = "your_mobile_number_here";
      await prefs.setString('phone', mobileNumber);
      await secureStorage.write(key: 'phone', value: mobileNumber);
      mobile = mobileNumber;
      log(
        "Mobile number saved and retrieved: $mobile",
      ); // Log the saved mobile number
    } else {
      log(
        "Retrieved Mobile Number: $mobile",
      ); // Log the retrieved mobile number
    }

    return mobile ?? "";
  }

  static getEmail() {}
}
