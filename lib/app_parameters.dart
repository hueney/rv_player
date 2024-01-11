// app_parameters.dart : Radio Station Parameters:- URLs and assets
// Enter your App parameters in this file.

// Set the Enable variables to True for
// Enable radioPlayer
// Enable videoPlayer
// Enable sponsor Graphic and url
// Enable Social Media Row

import 'package:flutter/material.dart';

class AppParameters {
  // USER Defined parameters:

  // Define your Radio Station Parameters here : Enter your https:// url addresses here
  static const String radioStationName = 'Cork Community Radio Player';
  // Radio Stream URL
  static const String radioStationURL = 'http://stream.cr.ie:8002/mp3';

  // Studio Video Stream URL
  //static const String studioVideoUrl = 'https://www.twitch.tv/corkcitycommunityradio';

  // Default video stream for test and demo only.
  static const String studioVideoURL =
      'https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8';

  //Radio station Brand Icon image in assets folder.
  static const String radioStationImagePath = 'assets/cccr.jpg';

  // Sponsor URL file on Radio station website: Managed by Radio station:
  // It must be called: sponsor.jpg // Todo NOTE the sponsor graphic must be called
  //static const String sponsorGraphicURL = 'https://path-to-server/sponsor.jpg
  //default for test and demo
  static const String sponsorGraphicURL =
      'https://cccr2016.files.wordpress.com/2023/02/ZZZcommunity-centre-facade-2.jpg?w=2046';

  // static const String sponsorGraphicUrl =
  // 'https://storage.googleapis.com/dam-mus-prd-7e2fdbe.mus.prd.v8.commerce.mi9cloud.com/Images/App/Service-RR-780x450.jpg';

  // Sponsor URL file on Radio Station website.
  // Todo NOTE It must be called sponsorURL.txt //
  static const String sponsorTextURL =
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt';

  // Other Parameters
  static const String developerInfo = "@Coder Dojo Club - Glanmire 2023";

  // Share Link to the Google PlayStore or Apple AppStore
  static const String appStoreLink =
      'https://play.google.com/store/apps/details?id=com.neuville.my_radio';
  static const String emailSubject = '<subject>';

  // App fixed Parameters :Screen Size Adjust parameters etc : Ignore these..
// ChatGPT code
  static const Color customColor1 = Color.fromRGBO(115, 1, 3, 1.0);
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static double getSizeAdjustFactor(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    double sizeAdjustFactor = screenWidth;
    double maxSize = 200.0;
    return sizeAdjustFactor.clamp(0.0, maxSize);
  }

  static double getIconSize(BuildContext context) {
    double sizeAdjustFactor = getSizeAdjustFactor(context);
    double maxSize = 200.0;
    return (sizeAdjustFactor * 0.6).clamp(0.0, maxSize * 0.5);
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
