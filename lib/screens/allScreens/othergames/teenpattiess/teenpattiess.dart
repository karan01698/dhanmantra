// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpatiiweb.dart';
// import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattimobile.dart';
// import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattitablet.dart';
//
// // ✅ Optional: You can move this class to a separate device_helper.dart file
// enum DeviceType { mobile, tablet, desktop }
//
// class DeviceHelper {
//   static DeviceType getDeviceType(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//
//     if (kIsWeb) {
//       if (width >= 1024) return DeviceType.desktop;
//       if (width >= 600) return DeviceType.tablet;
//       return DeviceType.mobile;
//     }
//
//     if (width >= 1024) return DeviceType.desktop;
//     if (width >= 600) return DeviceType.tablet;
//     return DeviceType.mobile;
//   }
//
//   static bool isWeb() => kIsWeb;
//
//   static bool isMobile(BuildContext context) =>
//       getDeviceType(context) == DeviceType.mobile;
//
//   static bool isTablet(BuildContext context) =>
//       getDeviceType(context) == DeviceType.tablet;
//
//   static bool isDesktop(BuildContext context) =>
//       getDeviceType(context) == DeviceType.desktop;
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (!kIsWeb &&
//       (defaultTargetPlatform == TargetPlatform.android ||
//           defaultTargetPlatform == TargetPlatform.iOS)) {
//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }
//   runApp(
//     ScreenUtilInit(
//       designSize: const Size(1920, 1080),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) => const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Teen Patti Table',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         scaffoldBackgroundColor: Colors.green[900],
//       ),
//       home: const ResponsiveTeenPattiScreen(),
//     );
//   }
// }
// class ResponsiveTeenPattiScreen extends StatefulWidget {
//   const ResponsiveTeenPattiScreen({super.key});
//
//   @override
//   State<ResponsiveTeenPattiScreen> createState() => _ResponsiveTeenPattiScreenState();
// }
//
// class _ResponsiveTeenPattiScreenState extends State<ResponsiveTeenPattiScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     // 🔄 Set landscape only for mobile (not web)
//     if (!kIsWeb &&
//         (defaultTargetPlatform == TargetPlatform.android ||
//             defaultTargetPlatform == TargetPlatform.iOS)) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//       // 🔒 Hide status bar
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     }
//   }
//
//   @override
//   void dispose() {
//     // 🔄 On back (dispose), restore to portrait and show system UI again
//     if (!kIsWeb &&
//         (defaultTargetPlatform == TargetPlatform.android ||
//             defaultTargetPlatform == TargetPlatform.iOS)) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     }
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final deviceType = DeviceHelper.getDeviceType(context);
//
//     if (kIsWeb) {
//       // ✅ Always show web layout on web, regardless of screen width
//       logPrint("🌐 Running on WEB — show TeenPattiTableWeb");
//       return TeenPattiTableWeb();
//     }
//
//     switch (deviceType) {
//       case DeviceType.mobile:
//         logPrint("📱 Running on MOBILE");
//         return TeenPattiTableMobile();
//
//       case DeviceType.tablet:
//         logPrint("📱📱 Running on TABLET");
//         return TeenPattiTableTab();
//
//       case DeviceType.desktop:
//         logPrint("🖥️ Running on DESKTOP");
//         return TeenPattiTableWeb(); // You can also restrict this if needed
//
//       default:
//         logPrint("⚠️ Unknown device — defaulting to MOBILE layout");
//         return TeenPattiTableMobile();
//     }
//   }
//
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpatiiweb.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattimobile.dart';
import 'package:sattagames/screens/allScreens/othergames/teenpattiess/teenpattitablet.dart';

import '../../../../main.dart';
import '../../../../utils/global_key_store.dart';

enum DeviceType { mobile, tablet, desktop }

class DeviceHelper {
  static DeviceType getDeviceType(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (kIsWeb) {
      if (width >= 1024) return DeviceType.desktop;
      if (width >= 600) return DeviceType.tablet;
      return DeviceType.mobile;
    }

    if (width >= 1024) return DeviceType.desktop;
    if (width >= 600) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isWeb() => kIsWeb;

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(RoomController());
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Teen Patti Table',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[900],
      ),
      // home: const ResponsiveTeenPattiScreen(),
      home: Builder(
        builder: (ctx) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GlobalContext.setContext(ctx);
          });
          return const ResponsiveTeenPattiScreen();
        },
      ),
    );
  }
}

class ResponsiveTeenPattiScreen extends StatefulWidget {
  const ResponsiveTeenPattiScreen({super.key});

  @override
  State<ResponsiveTeenPattiScreen> createState() =>
      _ResponsiveTeenPattiScreenState();
}

class _ResponsiveTeenPattiScreenState
    extends State<ResponsiveTeenPattiScreen> {
  @override
  void initState() {
    super.initState();

    // Force landscape and fullscreen for mobile native
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  @override
  void dispose() {
    // Reset back to portrait and full UI
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = DeviceHelper.getDeviceType(context);

    if (kIsWeb) {
      final orientation = MediaQuery.of(context).orientation;
      final logicalWidth = MediaQuery.of(context).size.width;

      // ⛔ Show message in mobile portrait on web
      if (logicalWidth < 600 && orientation == Orientation.portrait) {
        return Scaffold(
          body: Center(
            child: Text(
              '📱 Please rotate your phone to landscape',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        );
      }

      // ✅ Landscape mode or wide enough screen
      if (logicalWidth < 600) {
        logPrint("🌐 Web on MOBILE ➝ Showing TeenPattiTableMobile");
        return TeenPattiTableMobile(); // show correct mobile UI
      } else if (logicalWidth < 1024) {
        logPrint("🌐 Web on TABLET ➝ Showing TeenPattiTableTab");
        return TeenPattiTableTab();
      } else {
        logPrint("🌐 Web on DESKTOP ➝ Showing TeenPattiTableWeb");
        return TeenPattiTableWeb();
      }
    }

    // ✅ Native app (Android/iOS) — use responsive layout
    switch (deviceType) {
      case DeviceType.mobile:
        logPrint("📱 Native MOBILE");
        return TeenPattiTableMobile();

      case DeviceType.tablet:
        logPrint("📱📱 Native TABLET");
        return TeenPattiTableTab();

      case DeviceType.desktop:
        logPrint("🖥️ Native DESKTOP");
        return TeenPattiTableWeb();

      default:
        logPrint("⚠️ Unknown device ➝ fallback to MOBILE layout");
        return TeenPattiTableMobile();
    }
  }
}
