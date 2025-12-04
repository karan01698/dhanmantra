// import 'package:get/get.dart';
// import '../apiservices/registerapiservices.dart';
// import '../authencatemodals/registermodals.dart';
//
// class RegisterController extends GetxController {
//   var isLoading = false.obs;
//   var responseMessage = "".obs;
//
//   Future<void> registerUser(User user) async {
//     isLoading.value = true;
//
//     final response = await ApiService.registerUser(user.toJson()); // Convert object to Map<String, String>
//
//     if (response.containsKey("error")) {
//       responseMessage.value = response["error"];
//     } else {
//       responseMessage.value = response["message"] ?? "Registration successful!";
//     }
//
//     isLoading.value = false;
//     Get.snackbar("Registration", responseMessage.value);
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../authenticationsScreens/loginforgotregcontroller.dart';
import '../../../main.dart';
import '../../../screens/allScreens/allscreens.dart';
import '../apiservices/registerapiservices.dart';
import '../authencatemodals/registermodals.dart';

import 'package:get/get.dart';
import '../apiservices/registerapiservices.dart';
import '../authencatemodals/registermodals.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var userProfile = Rx<UserProfile?>(null);
  var userProfiles = Rx<RummyUserProfileModal?>(null);
  var betProfiles = <GetBetProfileModal>[].obs;
  var qrList = <QRModel>[].obs;
  Timer? _timer;
  var transactions = <Transaction>[].obs;

  var errorMessage = ''.obs;



  var isLoading = false.obs;
  var isLoadingss = false.obs;

  var responseMessage = "".obs;

  Future<bool> registerUser(UserModel user) async {
    isLoading.value = true;
    bool isLoggedIn = false;

    try {
      final response = await ApiService.registerUser(user.toJson());

      if (response is Map<String, dynamic>) { // Ensure response is a Map
        if (response.containsKey("error")) {
          responseMessage.value = response["error"].toString(); // Ensure string
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? "please login first";
          if (responseMessage.value == "Registered!") {
            isLoggedIn = true;
            // Get.snackbar("Registrations", responseMessage.value, backgroundColor: Colors.green, // ✅ Set background to green
            //   colorText: Colors.white,);
            // Set flag if login is successful
          }
        }
      } else {
        responseMessage.value =
        "Unexpected response format"; // Handle unexpected API response
      }
    } catch (e) {
      Get.snackbar("Registration", responseMessage.value);
      responseMessage.value = "Registration failed: ${e.toString()}";
    }

    isLoading.value = false;

    return isLoggedIn;
  }


  //
  Future<bool> loginUser(loginUsers user) async {
    isLoading.value = true;
    bool isLoggedIn = false;

    try {
      final response = await ApiService.LoginUser(user.toJson());

      logPrint("🔹 API Response: $response"); // ✅ Debug API Response

      if (response is Map<String, dynamic>) {
        if (response.containsKey("error")) {
          responseMessage.value =
              response["error"].toString(); // API error message
          Get.snackbar("Login Failed", responseMessage.value,
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? "Please register first";
          if (responseMessage.value == "Loggedin!") {
            isLoggedIn = true;
          } else {
            Get.snackbar("Login Failed", responseMessage.value,
                backgroundColor: Colors.orange, colorText: Colors.white);
          }
        }
      } else {
        responseMessage.value = "Unexpected response format";
        Get.snackbar("Error", responseMessage.value,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      responseMessage.value = "Login failed: ${e.toString()}";
      Get.snackbar("Error", responseMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // Get.snackbar(
    //   "LoggedIn",
    //   responseMessage.value,
    //   backgroundColor: Colors.green, // ✅ Set background to green
    //   colorText: Colors.white, // ✅ Set text color to white
    //   snackPosition: SnackPosition.TOP, // (Optional) Show at the bottom
    //   duration: Duration(seconds: 3), // (Optional) Auto dismiss after 3 sec
    // );
    isLoading.value = false;
    return isLoggedIn;
  }

  //// forgot

  //
  Future<bool> forgotPasswordController(forgotPasswordModal user) async {
    isLoading.value = true;
    bool isLoggedIn = false;

    try {
      final response = await ApiService.forgotPasswordServices(user.toJson());

      logPrint("🔹 API Response: $response"); // ✅ Debug API Response

      if (response is Map<String, dynamic>) {
        if (response.containsKey("error")) {
          responseMessage.value =
              response["error"].toString(); // API error message
          Get.snackbar("Login Failed", responseMessage.value,
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? "Update password";
          if (responseMessage.value == "Updated!") {
            isLoggedIn = true;
          } else {
            Get.snackbar(" Failed to Update Password", responseMessage.value,
                backgroundColor: Colors.orange, colorText: Colors.white);
          }
        }
      } else {
        responseMessage.value = "Unexpected response format";
        Get.snackbar("Error", responseMessage.value,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      responseMessage.value = "failed: ${e.toString()}";
      Get.snackbar("Error", responseMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    Get.snackbar(
      "Password Updated",
      responseMessage.value,
      backgroundColor: Colors.green, // ✅ Set background to green
      colorText: Colors.white, // ✅ Set text color to white
      snackPosition: SnackPosition.TOP, // (Optional) Show at the bottom
      duration: Duration(seconds: 3), // (Optional) Auto dismiss after 3 sec
    );
    isLoading.value = false;
    return isLoggedIn;
  }


  // Future<bool> loginUser(loginUsers user) async {
  //   isLoading.value = true; // Start loading
  //   bool isLoggedIn = false;
  //
  //   try {
  //     final response = await ApiService.LoginUser(user.toJson());
  //
  //     logPrint("🔹 API Response: $response"); // ✅ Debug API Response
  //
  //     if (response is Map<String, dynamic>) {
  //       if (response.containsKey("error")) {
  //         responseMessage.value = response["error"].toString();
  //       } else {
  //         responseMessage.value = response["message"]?.toString() ?? "Please register first";
  //         if (responseMessage.value == "Loggedin!") {
  //           isLoggedIn = true;
  //         }
  //       }
  //     } else {
  //       responseMessage.value = "Unexpected response format";
  //     }
  //   } catch (e) {
  //     responseMessage.value = "Login failed: ${e.toString()}";
  //   }
  //
  //   // Stop loading before showing the snackbar
  //
  //
  //   // Show snackbar (after loading state is removed)
  //   if (isLoggedIn) {
  //     Get.snackbar("Success", "Login Successful!",
  //         backgroundColor: Colors.green, colorText: Colors.white);
  //
  //     // Delay navigation so snackbar has time to show
  //     await Future.delayed(Duration(seconds: 1));
  //
  //     // Example: Navigate to home screen (if you have navigation logic)
  //     // Get.to(HomeScreen());
  //   } else {
  //     Get.snackbar("Login Failed", responseMessage.value,
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  //
  //   return isLoggedIn;
  // }
  //withdraw
  Future<bool> withdrawAmountMethod(WithdrawAmountModal user) async {
    logPrint("🔹 withdrawAmountMethod STARTED");
    isLoadingss.value = true;
    logPrint("🔹 isLoading set to TRUE");
    bool isLoggedIn = false;
    logPrint("🔹 User Data: $user");
    print(user);
    try {
      final response = await ApiService.withdrawBalanceServices(user.toJson());

      logPrint("🔹 API Response: $response"); // ✅ Debug API Response

      if (response is Map<String, dynamic>) {
        if (response.containsKey("error")) {
          responseMessage.value =
              response["error"].toString(); // API error message
          Get.snackbar("Login Failed", responseMessage.value,
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? "Withdraw Amount";
          if (responseMessage.value == "Added!") {
            isLoggedIn = true;
          } else {
            Get.snackbar("Added", responseMessage.value,
                backgroundColor: Colors.orange, colorText: Colors.white);
          }
        }
      } else {
        responseMessage.value = "Unexpected response format";
        Get.snackbar("Error", responseMessage.value,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      responseMessage.value = "Withdraw failed: ${e.toString()}";
      Get.snackbar("Error", responseMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    Get.snackbar(
      "Request Added",
      responseMessage.value,
      backgroundColor: Colors.green, // ✅ Set background to green
      colorText: Colors.white, // ✅ Set text color to white
      snackPosition: SnackPosition.TOP, // (Optional) Show at the bottom
      duration: Duration(seconds: 3), // (Optional) Auto dismiss after 3 sec
    );
    isLoadingss.value = false;
    return isLoggedIn;
  }

  ///user
  Future<void> UpdateUsercon(UpdateUserModal user) async {
    isLoading.value = true;

    try {
      final response = await ApiService.UpdateregUser(user.toJson());

      if (response is Map<String, dynamic>) { // Ensure response is a Map
        if (response.containsKey("error")) {
          responseMessage.value = response["error"].toString(); // Ensure string
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? "Registration successful!";
        }
      } else {
        responseMessage.value =
        "Unexpected response format"; // Handle unexpected API response
      }
    } catch (e) {
      responseMessage.value = "Registration failed: ${e.toString()}";
    }

    isLoading.value = false;
    Get.snackbar("Registration", responseMessage.value);
  }

  Future<void> insertUsercon(InsertbetUserModal user) async {
    isLoading.value = true;

    try {
      final response = await ApiService.InsertBet(user.toJson());

      if (response is Map<String, dynamic>) { // Ensure response is a Map
        if (response.containsKey("error")) {
          responseMessage.value = response["error"].toString(); // Ensure string
        }
        // else {
        //   responseMessage.value =
        //       r esponse["message"]?.toString() ?? " successful!";
        // }
      } else {
        responseMessage.value =
        "Unexpected response format"; // Handle unexpected API response
      }
    } catch (e) {
      responseMessage.value = "failed: ${e.toString()}";
    }

    isLoading.value = false;
    Get.snackbar(
      "Bet Placed Successfully",
      responseMessage.value,
      backgroundColor: Colors.green, // ✅ Set background to green
      colorText: Colors.white, // ✅ Set text color to white
      snackPosition: SnackPosition.TOP, // (Optional) Show at the bottom
      duration: Duration(seconds: 3), // (Optional) Auto dismiss after 3 sec
    );
  }


  Future<void> UpdateBalnceMethod(UpdateBalanceModal user) async {
    isLoadingss.value = true;

    try {
      final response = await ApiService.UpdateBalanceServices(user.toJson());

      if (response is Map<String, dynamic>) { // Ensure response is a Map
        if (response.containsKey("error")) {
          responseMessage.value = response["error"].toString(); // Ensure string
        } else {
          responseMessage.value =
              response["message"]?.toString() ?? " successful!";
        }
      } else {
        responseMessage.value =
        "Unexpected response format"; // Handle unexpected API response
      }
    } catch (e) {
      responseMessage.value = "Registration failed: ${e.toString()}";
    }

    isLoadingss.value = false;
    // Get.snackbar(
    //   "Amount Added Successfully",
    //   responseMessage.value,
    //   backgroundColor: Colors.green, // ✅ Set background to green
    //   colorText: Colors.white, // ✅ Set text color to white
    //   snackPosition: SnackPosition.TOP, // (Optional) Show at the bottom
    //   duration: Duration(seconds: 3), // (Optional) Auto dismiss after 3 sec
    // );
    Future.delayed(Duration(milliseconds: 500), () {
      Fluttertoast.showToast(
        msg: "${responseMessage.value}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,

      );
    });
  }


  @override
  void onInit() {
    super.onInit();
    // fetchBetProfile();
    loadUserProfile();
    startAutoUpdate();
    fetchQRData();
    fetchTransactions();
  }
  @override
  void onClose() {
    _timer?.cancel(); // Stop polling when the controller is destroyed
    super.onClose();
  }

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    userProfile.value = await ApiService.fetchUserProfile();
    isLoading.value = false;
  }
  void startAutoUpdate() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await loadUserProfile();
    });
  }

  Future<void> RummyloadUserProfile() async {
    isLoading.value = true;
    userProfiles.value = await ApiService.rummyfetchUserProfile();
    isLoading.value = false;
  }

  void fetchQRData() async {
    try {
      isLoading(true);
      var data = await ApiService.fetchQRData();
      qrList.assignAll(data);
    } catch (e) {
      logPrint("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }

//   Future<void> fetchTransactions() async {
//     isLoading.value = true; // Start loading
//
//     try {
//       // Get saved phone number
//       String? Phone = await RegistrationController.getPhoneNumber();
//
//
//
//       // Check if the phone number is null or empty
//       if (Phone == null || Phone.isEmpty) {
//         logPrint("No saved phone number found.");
//         return; // Exit early if no phone number is found
//       }
//
//       // Make the HTTP request to fetch transactions
//       final response = await http.get(
//         Uri.parse(
//           'https://dhanmantragame.com/APIs/WebService1.asmx/ShowTransaction?token=BETLAJDNDNDBARKXTER&Phone=$Phone',
//         ),
//       );
//
//       // Check if the request was successful
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body); // Decode the response
//         transactions.value = data.map((item) => Transaction.fromJson(item)).toList();
//       } else {
//         errorMessage.value = 'Failed to load transactions'; // Error message for failed request
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e'; // Error message for exceptions
//     } finally {
//       isLoading.value = false; // Stop loading regardless of success or failure
//     }
//   }
// }


  Future<List<Transaction>> fetchTransactions() async {
    isLoading.value = true; // Start loading

    try {
      // Get saved phone number
      String? Phone = await RegistrationController.getPhoneNumber();

      // Check if the phone number is null or empty
      if (Phone == null || Phone.isEmpty) {
        logPrint("No saved phone number found.");
        return []; // Return an empty list if no phone number is found
      }

      // Make the HTTP request to fetch transactions
      final response = await http.get(
        Uri.parse(
          'https://dhanmantragame.com/APIs/WebService1.asmx/ShowTransaction?token=BETLAJDNDNDBARKXTER&Phone=$Phone',
        ),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body); // Decode the response
        return data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        errorMessage.value =
        'Failed to load transactions'; // Error message for failed request
        return []; // Return an empty list if the request fails
      }
    } catch (e) {
      errorMessage.value = 'Error: $e'; // Error message for exceptions
      return []; // Return an empty list if there's an error
    } finally {
      isLoading.value = false; // Stop loading regardless of success or failure
    }
  }
}
