import 'package:sattagames/NewGames/games/roulette2/roulette/provider/audio.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/provider/myvariable.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/provider/roulette_api.dart';
import 'package:sattagames/NewGames/games/roulette2/roulette/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';


import '../../../../screens/splashscreen/splashscreen.dart';
import 'home/home.dart';
import 'models/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RouletteApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyVariableModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioProvider(),
        ),
      ],
      child: const MyAppt(),
    ),
  );
}

class MyAppt extends StatelessWidget {
  const MyAppt({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePagess(phoneNumber: "9354054343", profileData: GetProfile(id: 1, phone: '', passwords: '', balance: '', atype: ''),)

    );
  }
}
