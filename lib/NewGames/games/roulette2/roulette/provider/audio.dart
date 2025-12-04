import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../../../main.dart';
import 'myvariable.dart';


class AudioProvider with ChangeNotifier {
  final audioplayersPlatformInterface =
      const GlobalAudioEvent(eventType: GlobalAudioEventType.log);

  // AudioPlayer audioPlayer = AudioPlayer();
  bool playTimer = false;
  bool audioRunning = false;

  void initTimer() {
    // audioPlayer.dispose();
    // notifyListeners();
    // audioPlayer = AudioPlayer();
    playTimer = true;
    _initTimerAudio();
    notifyListeners();
  }

  // Future<void> playOneTimeAudio(BuildContext context, String audioPath) async {
  //   if (playTimer) {
  //     try {
  //       audioRunning = true;
  //       await audioPlayer.setAsset(audioPath, preload: false);
  //       await audioPlayer.play();
  //       await Future.delayed(const Duration(seconds: 7));
  //       int.parse(Provider.of<MyVariableModel>(context, listen: false)
  //                   .winAmount) ==
  //               0
  //           ? playLooseSound()
  //           : playWinSound();
  //       await Future.delayed(const Duration(seconds: 1));
  //       audioRunning = false;

  //       // When one-time audio completes, resume the timer audio
  //       _initTimerAudio();
  //     } catch (e) {
  //       logPrint('Error playing one-time audio: $e');
  //       // Handle the error as needed
  //     }
  //   }
  // }

  Future<void> playOneTimeAudio(BuildContext context, String audioPath) async {
    if (playTimer) {
      try {
        audioRunning = true;
        AudioPlayer audioPlayer = AudioPlayer();

        await audioPlayer.play(AssetSource(audioPath),
            mode: PlayerMode.lowLatency);
        // await audioPlayer.play();
        await Future.delayed(const Duration(milliseconds: 7500));
        audioPlayer.dispose();
        int.parse(Provider.of<MyVariableModel>(context, listen: false)
                    .winAmount) ==
                0
            ? playLooseSound()
            : playWinSound();
        await Future.delayed(const Duration(seconds: 1));
        audioRunning = false;

        // When one-time audio completes, resume the timer audio
        _initTimerAudio();
      } catch (e) {
        logPrint('Error playing one-time audio: $e');
        // Handle the error as needed
      }
    }
  }

  void playWinSound() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/win.mp3'),
        mode: PlayerMode.lowLatency);
    await Future.delayed(const Duration(seconds: 1));
    audioPlayer.dispose();
  }

  void playLooseSound() async {
    AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer.play(AssetSource('audio/loose.mp3'),
        mode: PlayerMode.lowLatency);
    await Future.delayed(const Duration(seconds: 1));

    audioPlayer.dispose();

    // await audioPlayer.play();
  }

  void playOneTimeAudioWithoutStopping(String audioPath) async {
    try {
      AudioPlayer oneTimeAudioPlayer = AudioPlayer();
      await oneTimeAudioPlayer.play(AssetSource(audioPath),
          mode: PlayerMode.mediaPlayer);
      // await oneTimeAudioPlayer.play();
      await Future.delayed(const Duration(seconds: 1));
      await oneTimeAudioPlayer.dispose();
    } catch (e) {
      logPrint('Error playing one-time audio without stopping: $e');
      // Handle the error as needed
    }
  }

  void _initTimerAudio() async {
    log("going for timer");
    if (playTimer) {
      if (!audioRunning) {
        try {
          // AudioPlayer audioPlayer = AudioPlayer();

          // // await audioPlayer.play(AssetSource('audio/second.mp3'),
          //     mode: PlayerMode.mediaPlayer);
          // // audioPlayer.setReleaseMode(ReleaseMode.loop);
          // // await audioPlayer.play();
          // await Future.delayed(const Duration(seconds: 1));
          // audioPlayer.dispose();

          // _initTimerAudio();
        } catch (e) {
          logPrint('Error initializing timer audio: $e');
          initTimer();
        }
      }
    }
  }

  void startPlaying() {
    initTimer();
    notifyListeners();
  }

  void stopPlaying() async {
    playTimer = false;
    // await audioPlayer.stop();
    notifyListeners();
  }
}
