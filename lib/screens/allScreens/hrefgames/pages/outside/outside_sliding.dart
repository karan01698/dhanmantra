import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../../main.dart';
import '../../widget/outside/sliding_card.dart';


class SlidingCardRow extends StatefulWidget {
  const SlidingCardRow({super.key});

  @override
  State<SlidingCardRow> createState() => _SlidingCardRowState();
}

class _SlidingCardRowState extends State<SlidingCardRow> {
  final ScrollController _scrollController = ScrollController();
  late Timer _autoScrollTimer;

  final List<String> titles = [
    "Delhi Bazaar", "DESAWAR", "FARIDABAD", "GHAZIABAD", "GALI",
    "SHALIMAR", "RAJASTHAN", "LUCKNOW", "MUMBAI", "PATNA"
  ];

  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    const scrollSpeed = 50.0; // pixels per second
    const tickDuration = Duration(milliseconds: 16); // ~60fps

    _autoScrollTimer = Timer.periodic(tickDuration, (_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final newPosition = _scrollController.offset + (scrollSpeed * tickDuration.inMilliseconds / 1000);

        if (newPosition >= maxScroll) {
          // Optional: reset with no animation for a seamless loop
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(newPosition);
        }
      }
    });
  }


  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // manual scroll support
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: titles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return SlidingCardWidget(
            title: titles[index],
            onTap: () {
              logPrint("Tapped on: ${titles[index]}");
            },
          );
        },
      ),
    );
  }
}
