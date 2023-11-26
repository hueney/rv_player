// app_parameters.dart : Radio Station Parameters:- URLs and assests
// Enter your App parametes in this file.

//import 'package:flutter/material.dart';

class AppParameters {
  // Define your Radio Station Parameters here : Enter your https:// url addresses here
  static const String radioStationName = 'Cork Community Radio Player';
  // Radio Stream URL
  static const String radioStationURL = 'http://stream.cr.ie:8002/mp3';
  // Studio Video Stream URL
  //static const String studioVideoUrl = 'https://www.twitch.tv/corkcitycommunityradio';
  static const String studioVideoURL =
      'https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8';

  //Radio station Brand Icon image in assets folder.
  static const String radioStationImagePath = 'assets/cccr.jpg';

  // Sponsor URL file on Radio station website: Managed by Radio station: It must be called: sponsor.jpg
  static const String sponsorGraphicURL =
      'https://cccr2016.files.wordpress.com/2023/02/ZZZcommunity-centre-facade-2.jpg?w=2046';

  // static const String sponsorGraphicUrl =
  // 'https://storage.googleapis.com/dam-mus-prd-7e2fdbe.mus.prd.v8.commerce.mi9cloud.com/Images/App/Service-RR-780x450.jpg';

  // Sponsor URL file on Radio Station website. It must be called sponsorURL.txt
  static const String sponsorTextURL =
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt';

  // Other Parameters
  static const String developerInfo = "@Coder Dojo Club - Glanmire 2023";

  // Screen Adjust parameters.
  static double getScreenSizeAdjustFactor(double screenWidth) {
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; // 60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); // clamp to max size

    return sizeAdjustFactor;
  }
}

// How to use in the APP
// // Import the app_parameters.dart file in your code files where needed
// import 'app_parameters.dart';
//
// // Use the parameters in your widget
// double screenWidth = MediaQuery.of(context).size.width;
// double sizeAdjustFactor = AppParameters.getScreenSizeAdjustFactor(screenWidth);
// double iconSize = sizeAdjustFactor * 0.6; // 60% of container size
