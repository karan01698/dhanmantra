import 'package:flutter/material.dart';

import '../../text.dart';


class ProfileCard extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final String sub;
  const ProfileCard({
    super.key,
    required this.image,
    required this.text,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            height: 80,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // gradient: LinearGradient(
                //   end: Alignment.topCenter,
                //   begin: Alignment.bottomRight,
                //   colors: [
                //     Colors.white.withOpacity(0.1),
                //     Colors.white.withOpacity(0.01),
                //   ],
                // ),
                color: const Color(0xff3c3c3c)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText6(
                      text: text,
                      weight: FontWeight.w900,
                      size: 20,
                    ),
                    CustomText6(
                      text: sub,
                      weight: FontWeight.w400,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
              color: Colors.amber,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
