import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../main.dart';
import '../../credential.dart';
import '../authencatemodals/registermodals.dart';

class ApiService {
  static const String baseUrl =
      "https://dhanmantragame.com/APIs/WebService1.asmx";
  static const String token = "BETLAJDNDNDBARKXTER";

  // Register User API
  static Future<Map<String, dynamic>> registerUser(Map<String, String> data) async {
    print(data);
    final Uri url = Uri.parse(

        "https://dhanmantragame.com/APIs/WebService1.asmx/Register?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  //login services
  static Future<Map<String, dynamic>> LoginUser(Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/Loginuser?token=${ApiConstants.token}");

    try {
      logPrint("🔹 Sending Login Request: $data"); // ✅ logPrint Data Before Sending

      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      logPrint("🔹 API Response: ${response.body}"); // ✅ logPrint API Response

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to login. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

// forgotpassword

  static Future<Map<String, dynamic>> forgotPasswordServices(Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/UpdatePassword?token=${ApiConstants.token}");

    try {
      logPrint("🔹 Sending Login Request: $data"); // ✅ logPrint Data Before Sending

      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      logPrint("🔹 API Response: ${response.body}"); // ✅ logPrint API Response

      if (response.statusCode == 200) {

        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to update your password. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  /// updateAPi
  static Future<Map<String, dynamic>> UpdateregUser(
      Map<String, String> data) async {
    final Uri url = Uri.parse(
          "https://dhanmantragame.com/APIs/WebService1.asmx/UpdateRegister?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> InsertBet(
      Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/InsertBet?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to bet. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> UpdateBalanceServices(
      Map<String, String> data) async {
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");

    }

    final Uri url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/UpdateBalance?token=${ApiConstants
            .token}&phone");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }


/// withdraw services
  static Future<Map<String, dynamic>>withdrawBalanceServices(
      Map<String, String> data) async {
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      logPrint("No saved phone number found.");

    }

    final Uri url = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/InsertTransactions?token=${ApiConstants
            .token}&phone");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }











  /// get mthod

  // Fetch user profile WITHOUT headers
  static Future<UserProfile?> fetchUserProfile() async {

    try {

      String? phone = await RegistrationController
          .getPhoneNumber(); // 🔹 Get saved phone number
      if (phone == null || phone.isEmpty) {
        logPrint("No saved phone number found.");
        return null;
      }
      final url = Uri.parse(
          "https://dhanmantragame.com/APIs/WebService1.asmx/ShowProfile?token=BETLAJDNDNDBARKXTER&Phone=$phone");

      final response = await http.get(url);
      // rummyfetchUserProfile();
      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
        json.decode(response.body); // ✅ FIX: Parse as List
        if (jsonData.isNotEmpty) {
          return UserProfile.fromJson(
              jsonData.first); // ✅ Extract the first object
        } else {
          logPrint("No user found");
          return null;
        }
      } else {
        logPrint("Failed to load profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      logPrint("Error fetching user profile: $e");
      return null;
    }

  }
  static Future<RummyUserProfileModal?> rummyfetchUserProfile() async {
    try {
      logPrint("kdkdkdkdkdk");

      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString('all_usernames');
      if (jsonString == null) {
        logPrint("No usernames found in SharedPreferences.");
        return null;
      }

      final List<dynamic> decoded = jsonDecode(jsonString);
      final List<String> usernames = decoded.cast<String>();
logPrint("sarra $usernames ");
      for (String username in usernames) {
        final url = Uri.parse(
          "https://dhanmantragame.com/APIs/WebService1.asmx/ShowProfile?token=BETLAJDNDNDBARKXTER&Phone=$username",
        );

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            return RummyUserProfileModal.fromJson(jsonData.first);
          } else {
            logPrint("No profile data found for $username.");
          }
        } else {
          logPrint("Failed to fetch profile for $username: ${response.statusCode}");
        }
      }

      // If no profile was found in loop
      return null;

    } catch (e) {
      logPrint("Error fetching user profile: $e");
      return null;
    }
  }



// Fetch user profile WITHOUT headers
//   static Future<GetBetProfileModal?> fetchBetProfile() async {
//     try {
//       String? phone = await RegistrationController
//           .getPhoneNumber(); // 🔹 Get saved phone number
//       if (phone == null || phone.isEmpty) {
//         logPrint("No saved phone number found.");
//         return null;
//       }
//       final url = Uri.parse(
//           "https://dhanmantragame.com/APIs/WebService1.asmx/GetBet?token=BETLAJDNDNDBARKXTER&Game=aviator&Phone=$phone"
//       );
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(
//             response.body); // ✅ FIX: Parse as List
//         if (jsonData.isNotEmpty) {
//           return GetBetProfileModal.fromJson(
//               jsonData.first); // ✅ Extract the first object
//         } else {
//           logPrint("No user found");
//           return null;
//         }
//       } else {
//         logPrint("Failed to load profile: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       logPrint("Error fetching user profile: $e");
//       return null;
//     }


  static const String apiUrl = "https://dhanmantragame.com/APIs/WebService1.asmx/GetQR?token=BETLAJDNDNDBARKXTER";

  static Future<List<QRModel>> fetchQRData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dealer = prefs.getString('dealer') ?? '';
    logPrint("hellow dealer $dealer");

    final Uri uri = Uri.parse(
        "https://dhanmantragame.com/APIs/WebService1.asmx/GetQR?token=BETLAJDNDNDBARKXTER&dealer=");
logPrint("https://dhanmantragame.com/APIs/WebService1.asmx/GetQR?token=BETLAJDNDNDBARKXTER&dealer=$dealer");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return QRModel.fromJsonList(response.body); // Make sure this method exists
    } else {
      throw Exception("Failed to load QR data");
    }
  }
}
