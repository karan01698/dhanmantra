import 'dart:async';

import 'package:flutter/material.dart';


import 'home/home.dart';
import 'models/profile.dart';


class SplashScreenss extends StatefulWidget {
  const SplashScreenss({super.key});

  @override
  State<SplashScreenss> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenss> {
  navigate() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return HomePagess(phoneNumber: "9354054343", profileData: GetProfile(id: 1, phone: '', passwords: '', balance: '', atype: ''),);
      }),
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      navigate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,

        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                height: 300,
              ),
              // const CustomText6(
              //   // underline: true,
              //   color: Colors.white,
              //   size: 50,
              //   weight: FontWeight.w400,
              //   text: "Salmari",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
