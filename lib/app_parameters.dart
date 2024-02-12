// app_parameters.dart : rv_player : Radio Station Parameters:- URLs and assets
// Enter your App parameters in this file.

// ToDo : create Enable flags for each element of the app
// ToDo so that they can be switched on or off from this app_parameters file
// toDo - not implemented.
// Set the Enable variables to True for
// Enable radioPlayer = true
// Enable videoPlayer = true
// Enable sponsor Graphic = true
// Enable Social Media Row = true

import 'package:flutter/material.dart';

class AppParameters {
  // USER Defined parameters: You define the URL streams and paths here in this file.
  // Define your Radio Station Parameters here : Enter your https:// URL addresses here

  // 1. Sponsor Graphic files: sponsor.jpg and sponsorUrl.txt - both on the server.
  // Define the path to the sponsor.jpg file on the Radio station server : Managed by Radio station:
  // Todo NOTE the sponsor graphic file must be called sponsor.jpg
  // EX: static const String sponsorGraphicURL = 'https://path-to-server/sponsor.jpg
  // A default placeholder is displayed if no sponsor graphic is found on the server
  // This default graphic in in the assets folder.
  // Ex: static const String sponsorGraphicURL = 'https://<path-to-your-server>/sponsor.jpg';

  // This graphic is put on the server at a fixed path and changed for each new sponsor
  // ToDo NOTE: This file must be called sponsor.jpg
  static const String sponsorGraphicUrl =
      // 'https://cccr2016.files.wordpress.com/2023/02/sponsor.jpg';
      'https://test273864.files.wordpress.com/2024/01/sponsor.jpg';

  // 2. Sponsor.txt file. This contains the sponsor URL to the sponsor website
  // This file is put on the server at a fixed path and changed for each new sponsor
  // ToDo NOTE: This file must be called sponsorUrl.txt

  static const String sponsorTextURL = // test empty url "";
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt'; // Example for test
  //'https://test273864.files.wordpress.com/2024/01/sponsorUrl.txt';

  //2a : Sponsor Web site url DEFAULT. just in case.
  static const String sponsorWebsiteURL = 'https://www.google.com/'; //'https://cr.ie/';

// 2a. Sponsor Placeholder : when no sponsor graphic is available
  static const String sponsorPlaceholder =
      'assets/sponsorPlaceholder.jpg'; // if no remote graphic from server use local in assets

// 3. Radio station Name is:
  static const String radioStationName = 'Cork Community Radio Player';

  // 4. Radio Station radio URL Stream is:
  static const String radioStationURL = 'http://stream.cr.ie:8002/mp3';

  // 5. Radio station Studio video URL Stream is:
  // ToDo Enter correct video link here
  //static const String studioVideoURL = 'https://www.twitch.tv/corkcitycommunityradio';

  // Default video stream for test and demo only.
  static const String studioVideoURL =
      'https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8';

  // 5a : Default video placeholder when video is not playing.
  static const String videoPlaceholder =
      'assets/ccr_studio1a.jpg'; //in App asset folder. Change before release if needed.

  // 6. Radio station Brand Icon image in assets folder of the APP.
  static const String radioStationImagePath = 'assets/cccr.jpg';

  // 7. Share Links:
  // These are the APP links to the Google PlayStore and the Apple App Store.
  // the correct link is selected in code based on Platform info in social_links_widget.dart.

  // 7A. Google Play store share link
  //  ToDo before RELEASE enter the correct google play store link here
  static const String googleStoreShareLink =
      'https://play.google.com/store/apps/details?id=com.glanmirecoderdojo.rv_player';

  // 7B. The Apple App store share link
  // ToDo before RELEASE enter the correct Apple App Store link here
  static const String appleStoreShareLink =
      'https://apps.apple.com/ie/app/ryanair/id504270602';

  //test only static const String googleStoreShareLink =
  //  'https://play.google.com/store/apps/details?id=com.neuville.my_radio'; //

  static const String emailSubject = 'This is the Cork Community Radio app link';

  // 8. Other Parameters
  static const String developerInfo = "@Coder Dojo Club - Glanmire 2023";

  //=== code parameters below : Ignore don't change these.
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

// Ray Neville 2023
// Denis O'Mahony
// Nathan Manley
