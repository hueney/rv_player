// video_player_widget.dart
// this file displays the video from the radio studio if streamed.
// studio URL is defined in the app_parameters file.

// video player widget for Twitch Stream of Studio video at:  //'https://www.twitch.tv/corkcitycommunityradio';
// we use flutter_twitch_player: ^0.1.4 plugin on pub.dev
//

import 'package:flutter/material.dart';
import 'package:flutter_twitch_player/flutter_twitch_player.dart';

import 'app_parameters.dart'; // Import the app_parameters file

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  TwitchController twitchController = TwitchController();

  String studioVideoUrl = AppParameters.studioVideoURL;
  String videoPlaceholder = AppParameters.videoPlaceholder; // blank when no video stream
  bool validVideo = false; // first check for validVideo stream : exists and no errors

  // Build Screen below.
  @override
  Widget build(BuildContext context) {
    //double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);
    // twitchController.onEnterFullscreen(() => print("Entered fullscreen"));
    // twitchController.onExitFullscreen(() => print("Exited fullscreen"));
    // twitchController.onStateChanged((state) => print(state));

    Color customColor1 = AppParameters.customColor1;
    double deviceWidth = MediaQuery.of(context).size.width;
    //double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth - deviceWidth / 10,

      padding: const EdgeInsets.all(4), // Adjust the padding as needed
      decoration: BoxDecoration(
        border: Border.all(
          color: customColor1, // Adjust the border color
          width: 2.0, // Adjust the border width
        ),
        borderRadius: BorderRadius.circular(8.0), //  border radius
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: TwitchPlayerIFrame(
              controller: twitchController,
              // put your channel ID / Name here e.g.  "corkcitycommunityradio"
              // channel: "", // BLANK shows Twitch Error page if no url / channel name! code for PlaceHolder
              channel: studioVideoUrl, // change in app_parameters file Nr 5

              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}

// Ray Neville
// Denis O'Mahony
// Nathan Manley
// Patrick O'Sullivan
