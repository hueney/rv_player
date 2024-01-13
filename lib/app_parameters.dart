// app_parameters.dart : rv_player : Radio Station Parameters:- URLs and assets
// Enter your App parameters in this file.

// ToDo : create Enable flags for each element of the app
// toDo so that they can be switched on or off
// Set the Enable variables to True for
// Enable radioPlayer
// Enable videoPlayer
// Enable sponsor Graphic and URL
// Enable Social Media Row

import 'package:flutter/material.dart';

class AppParameters {
  // USER Defined parameters: You define the URL streams and paths here in this file.
  // Define your Radio Station Parameters here : Enter your https:// URL addresses here

  // ToDo SPONSOR:
  // 1. Sponsor Graphic
  // Define the Sponsor URL file on Radio station server : Managed by Radio station:
  // Todo NOTE the sponsor graphic must be called sponsor.jpg
  // EX: static const String sponsorGraphicURL = 'https://path-to-server/sponsor.jpg
  // A default placeholder is displayed if no sponsor graphic is found on the server
  //
  // static const String sponsorGraphicURL = 'https://<path-to-your-server>/sponsor.jpg';

  //Test sponsorGraphicUrls // ToDo REM out when final url is available
  static const String sponsorGraphicUrl =
      //    'https://cccr2016.files.wordpress.com/2023/02/community-centre-facade-2.jpg?w=2046';
      'https://cccr2016.files.wordpress.com/2023/02/sponsor.jpg';

  // test only
  // static const String sponsorGraphicUrl =
  //    'https://storage.googleapis.com/dam-mus-prd-7e2fdbe.mus.prd.v8.commerce.mi9cloud.com/Images/App/Service-RR-780x450.jpg';

  // 2. Sponsor Text file with sponsor URL to sponsor website
  // Sponsor URL file on Radio Station server.
  // Todo NOTE This file must be called sponsorURL.txt //
  //
  static const String sponsorTextURL =
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt'; // Example for test

  // 2a. Sponsor Placeholder : when no sponsor graphic is available
  static const String sponsorPlaceholder = 'assets/sponsorPlaceholder.jpg';

// 3. Radio station Name is:
  static const String radioStationName = 'Cork Community Radio Player';

  // 4. Radio Station radio URL Stream is:
  static const String radioStationURL = 'http://stream.cr.ie:8002/mp3';

  // 5. Radio station Studio video URL Stream is:
  //static const String studioVideoURL = 'https://www.twitch.tv/corkcitycommunityradio';

  // Default video stream for test and demo only.
  static const String studioVideoURL =
      'https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8';

  // 6. Radio station Brand Icon image in assets folder of the APP.
  static const String radioStationImagePath = 'assets/cccr.jpg';

  // 7. Share Link: This is the APP link to the Google PlayStore.
  // The Apple AppStore link is... //ToDo
  static const String appStoreLink =
      'https://play.google.com/store/apps/details?id=com.neuville.my_radio'; // Now using Package.info plugin
  static const String emailSubject = 'This is the Cork Community Radio app link';

  // 8. Other Parameters
  static const String developerInfo = "@Coder Dojo Club - Glanmire 2023";

  //======================== code parameters below : Ignore don't change these.
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
// // Use the parameters in your code as follows:
// double screenWidth = MediaQuery.of(context).size.width;
// double sizeAdjustFactor = AppParameters.getScreenSizeAdjustFactor(screenWidth);
// double iconSize = sizeAdjustFactor * 0.6; // 60% of container size
