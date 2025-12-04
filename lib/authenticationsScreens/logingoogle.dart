import 'package:sattagames/authenticationsScreens/loginforgotregcontroller.dart';
import 'package:sattagames/backend/authenticanapi/authencatemodals/registermodals.dart';
import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'package:sattagames/screens/allScreens/allscreens.dart';
import 'package:sattagames/screens/cutomappbar/custom_app_bar.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../screens/home/home_screen.dart';

class GoogleSignInControllerd extends GetxController {
  var user = Rxn<User>();
  var mailss = "".obs;
  final RegisterController controllerss = Get.put(RegisterController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  void onInit() {
    super.onInit();
    getEmailFromPreferences();
    _auth.authStateChanges().listen((User? firebaseUser) async {
      user.value = firebaseUser;
      if (firebaseUser != null) {
        logPrint("✅ User Logged In: ${firebaseUser.email}");
        // await saveLoginState();
        // await saveEmailToPreferences(firebaseUser.email);

        // ✅ Create UserModel


        final newUser = loginUsers(
          phone: firebaseUser.email ?? "",
          password:"",
          token: 'BETLAJDNDNDBARKXTER',
          code: "",
        );

        // ✅ Register user in backend
        logPrint("📌 Registering user in backend...");
        bool isLoggedIn = await controllerss.loginUser(newUser);
        RegistrationController.savePhoneNumber(phone: firebaseUser.email ?? "",);

        // if (isLoggedIn) {
        //   logPrint("✅ Registration successful! Navigating to MainHomeScreen...");
        //   // 🚀 Navigate to Home Screen instantly

        // } else {
        //   logPrint("❌ Registration failed!");
        //   Get.snackbar("Error", "Successfully Register. Try again.");
        // }
      } else {
        logPrint("❌ No authenticated user found.");
      }
    });
  }

  // ✅ Force Google Account Picker to Open
  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Ensure the picker appears
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        logPrint("❌ User canceled Google Sign-In");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user.value = userCredential.user;

      logPrint("✅ Google Sign-In Successful! User: ${user.value?.email}"
      );
      Get.find<AppBarController>().login();
      controller.saveLoginState();
      Get.offAll(() => MainHomeScreen());
    } catch (e) {
      logPrint('❌ Error signing in with Google: $e');
      Get.snackbar("Sign-In Error", "Something went wrong. Please try again.");
    }
  }

  // ✅ Save login state
  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // ✅ Save user email
  Future<void> saveEmailToPreferences(String? email) async {
    if (email != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    }
  }

  // ✅ Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    user.value = null;
    // Navigate to splash screen
  }

  // ✅ Retrieve stored email
  Future<void> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mailss.value = prefs.getString('email') ?? "No email found";
  }
}
