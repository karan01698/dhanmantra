import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:sattagames/backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'package:sattagames/screens/allScreens/allscreens.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpatiiweb.dart';
import 'package:sattagames/screens/drawer/custom_drawer.dart';
import 'package:sattagames/screens/splashscreen/splashscreen.dart';
import 'package:sattagames/utils/global_key_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authenticationsScreens/sharecontroller.dart';
import 'firebase_options.dart';
// master switch

const bool kEnableLogs = false; // true करने पर logs show होंगे

void logPrint(String message) {
  if (kEnableLogs) {
    debugPrint(message);
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  if (kIsWeb) {
    await FirebaseAuth.instance
        .setPersistence(Persistence.SESSION); // or SESSION
  }
  // Initialize Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Get.config(
    enableLog: true, // GetX internal logs hide
    logWriterCallback: (String text, {bool isError = false}) {
      // कुछ मत करो, logs ignore होंगे
    },
  );

  Get.put(AuthControllersss());
  Get.put(LoginAuthController());
  Get.put(RegisterController());
  Get.put(RoomPlayerController());
  Get.put(ShareController());


  // Get login status from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Run the app with the correct condition
  runApp(MyApp(isLoggedIn: isLoggedIn));

}

 // Replace with your home screen path

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLandscape = constraints.maxWidth > constraints.maxHeight;
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        final Size maxSize = isLandscape
            ? Size(width * 0.9, height * 0.9) // Landscape: 90% of screen
            : const Size(400, 900); // Portrait: Fixed size like mobile

        final Widget app = ScreenUtilInit(
          designSize: const Size(1920, 1020),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              enableLog: false,
              defaultTransition: Transition.fade,
              theme: ThemeData(
                primaryColor: Colors.red,
                fontFamily: "Arial",
              ),
              // home: SplashScreen(),
              home: Builder(
                builder: (ctx) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    GlobalContext.setContext(ctx);
                  });
                  return  SplashScreen();
                },
              ),
            );
          },
        );

        // Use web frame for web only
        return kIsWeb
            ? FlutterWebFrame(
          builder: (context) => app,
          maximumSize: const Size(400.0, 900.0),
          // maximumSize: maxSize,
          enabled: true,
        )
            : app;
      },
    );

  }
}