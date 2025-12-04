import 'package:sattagames/NewGames/games/roulette2/roulette/home/top/profile_card.dart';
import 'package:flutter/material.dart';


import '../../backend/money_star_apis.dart';
import '../../models/profile.dart';

class Top extends StatefulWidget {
  final GetProfile profileData;
  const Top({super.key, required this.profileData});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  MoneyStarMethods moneyStarMethods = MoneyStarMethods();
  Stream<List<GetProfile>> billsStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield await moneyStarMethods.getProfile(widget.profileData.phone);
    }
  }

  //  final profileData = await moneyStarMethods
  //                         .getProfile(phoneController.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
                image: const NetworkImage(
                    "https://i.pinimg.com/originals/3f/e9/fe/3fe9fe7f0573b76d84f1bc313e43c98d.jpg"),
                text: widget.profileData.phone,
                sub: "UID : 00001197372S${widget.profileData.id}"),
            // Image.asset(
            //   "images/logo.png",
            //   height: 500,
            //   fit: BoxFit.fill,
            // ),
            StreamBuilder(
                stream: billsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ProfileCard(
                        image: const AssetImage("images/10.png"),
                        text: num.parse(snapshot.data![0].balance)
                            .toInt()
                            .round()
                            .toString(),
                        sub: "TOTAL COINS");
                  }
                  return ProfileCard(
                      image: const AssetImage("images/10.png"),
                      text: num.parse(widget.profileData.balance)
                          .toInt()
                          .round()
                          .toString(),
                      sub: "TOTAL COINS");
                })
          ],
        ),
      ),
    );
  }
}
