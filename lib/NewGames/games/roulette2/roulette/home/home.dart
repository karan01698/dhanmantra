import 'package:sattagames/NewGames/games/roulette2/roulette/home/top/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../../screens/home/tabs_games.dart';
import '../models/profile.dart';
import 'body/body.dart';
import 'bottom/bottom.dart';

class HomePagess extends StatefulWidget {
  final String phoneNumber;
  final GetProfile profileData;

  const HomePagess(
      {super.key, required this.phoneNumber, required this.profileData});

  @override
  State<HomePagess> createState() => _HomePagessState();

}

class _HomePagessState extends State<HomePagess> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage("images/bg.jpeg"), fit: BoxFit.fill),
        ),
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Top(
                profileData: widget.profileData,
              ),
            ),
            Expanded(
              flex: 3,
              child: Body(
                loginId: widget.phoneNumber,
              ),
            ),
            Expanded(
              flex: 1,
              child: Bottom(
                phone: widget.phoneNumber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
