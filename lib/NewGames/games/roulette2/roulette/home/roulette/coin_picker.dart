// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../provider/audio.dart';
import '../../provider/myvariable.dart';

// int selectedCoinAmount = 1;

class RoulleteCoinPicker extends StatefulWidget {
  const RoulleteCoinPicker({super.key});

  @override
  State<RoulleteCoinPicker> createState() => _RoulleteCoinPickerState();
}

class _RoulleteCoinPickerState extends State<RoulleteCoinPicker> {
  List<String> coinImages = [
    "images/10.png",
    "images/50.png",
    "images/100.png",
    "images/500.png",
    "images/1000.png",
    "images/5000.png",
  ];
  List<int> coinPrice = [10, 50, 100, 500, 1000, 5000];

  late Image image1;
  late Image image2;
  late Image image3;
  late Image image4;
  late Image image5;
  late Image image6;
  late Image image7;
  late Image image8;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(
          const AssetImage(
            "images/coins_bg.png",
          ),
          context);
// your code goes here
    });
    image1 = Image.asset("images/1.png", fit: BoxFit.cover);
    image2 = Image.asset("images/5.png", fit: BoxFit.cover);
    image3 = Image.asset("images/10.png", fit: BoxFit.cover);
    image4 = Image.asset("images/50.png", fit: BoxFit.cover);

    image5 = Image.asset("images/100.png", fit: BoxFit.cover);
    image6 = Image.asset("images/500.png", fit: BoxFit.cover);
    image7 = Image.asset("images/1000.png", fit: BoxFit.cover);
    image8 = Image.asset("images/5000.png", fit: BoxFit.cover);
    coinImage = image1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(
          const AssetImage(
            "images/coins_bg.png",
          ),
          context);
// your code goes here
    });

    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    precacheImage(image4.image, context);
    precacheImage(image5.image, context);
    precacheImage(image6.image, context);
    precacheImage(image7.image, context);
    precacheImage(image8.image, context);
  }

  int selectedCoinIndex = 0;
  // final audioPlayer = AudioManager.getInstance();

  Future<void> playAudio() async {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);

    audioProvider.playOneTimeAudioWithoutStopping("audio/coin_selector.mp3");
    // await audioPlayer.open(
    //   Audio("assets/audio/coin_selector.mp3"),
    // );
  }

  late Image coinImage;

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage(
          "images/1.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/25.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/5.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/10.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/50.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/100.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/500.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/1000.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/5000.png",
        ),
        context);
    precacheImage(
        const AssetImage(
          "images/coins_bg.png",
        ),
        context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.14),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.3,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0;
                          i < coinImages.length;
                          i++) // Assuming coinImages is a list of image paths
                        InkWell(
                          onTap: () {
                            playAudio();
                            setState(
                              () {
                                selectedCoinIndex = i;
                                Provider.of<MyVariableModel>(context,
                                        listen: false)
                                    .updateVariable(coinPrice[i]);
                              },
                            );
                          },
                          child: Opacity(
                            opacity: selectedCoinIndex == i
                                ? 1.0
                                : 0.5, // Adjust opacity based on selection
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.06,
                              child: Image.asset(coinImages[
                                  i]), // Assuming coinImages is a list of image paths
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
