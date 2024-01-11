/*  main.dart : Radio Video Sponsor APP for Community Radio stations
 *  Base Code created by Ilya Chirkunov <xc@yar.net> on 28.12.2020.
 * Modified by the super Kids of Coder Dojo Club Glanmire, Cork, Ireland  Oct 2023
 * for Cork Community Radio, Ireland
 */

import 'package:flutter/material.dart';
import 'package:rv_player/radio_player_widget.dart';
import 'package:rv_player/sponsor_widget.dart';
import 'package:rv_player/video_player_widget.dart';

import 'app_parameters.dart'; // Import the app_parameters file
import 'social_links_widget.dart';

//import 'radio_player_widget.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RadioTVApp());
}

class RadioTVApp extends StatefulWidget {
  // Add a named key parameter to the constructor
  const RadioTVApp({Key? key}) : super(key: key);

  @override
  RadioTVAppState createState() => RadioTVAppState();
}

class RadioTVAppState extends State<RadioTVApp> {
  // Enter your radio station's URLs in app_parameters.dart
  // Use AppParameters to access your parameters
  // String radioStationName = AppParameters.radioStationName;
  // String radioStationUrl = AppParameters.radioStationURL;
  // String radioStationImagePath = AppParameters.radioStationImagePath;
  // bool radioIsPlaying = false;
  // final RadioPlayer _radioPlayer = RadioPlayer();
  String developerInfo = AppParameters.developerInfo;

  List<String>? metadata; // metadata in radio stream contains artist or Album cover image

  @override
  void initState() {
    super.initState();
    //  initRadioPlayer(); // initialise the radio player plugin
  }

// Build Screen here
  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters
    final Color customColor1 = AppParameters.customColor1;
    final double iconSize = AppParameters.getIconSize(context);
    final double screenWidth = AppParameters.getScreenWidth(context);
    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);

    return MaterialApp(
      // Safe area means no image in the system top status bar.
      home: SafeArea(
        child: Scaffold(
          appBar: null, // nothing in the App Bar

          body: Container(
            decoration: BoxDecoration(
              color: customColor1, // fill the screen with Brand color
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 4, // adjust flex factor as needed
                    child:
                        // Radio Player Widget
                        const RadioPlayerWidget(),
                  ),
// Video Player Container
                  Expanded(
                    flex: 7, // adjust flex factor as needed
                    child: const VideoPlayerWidget(), // display the Video here
                  ),
                  const SizedBox(height: 10), // 10 pixel separator line

// Sponsor Graphic
                  Expanded(
                    flex: 3, // adjust flex factor as needed
                    child: const SponsorGraphicWidget(),
                  ),
                  // Divider line
                  const SizedBox(height: 10),
                  // Social Media Row Icons
                  Expanded(
                    flex: 1, // adjust flex factor as needed
                    child: SocialMediaLinksRow(),
                  ),
// Developer Info
                  Expanded(
                    flex: 1, // adjust flex factor as needed
                    child: SizedBox(
                      width: sizeAdjustFactor, // Adjust the width as needed
                      height: sizeAdjustFactor / 10, // Adjust the height as needed
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12, // You can change the background color
                          borderRadius:
                              BorderRadius.circular(15.0), // Adjust the radius as needed
                        ),
                        child: Center(
                          child: Text(
                            developerInfo,
                            style: const TextStyle(
                              color: Colors.white, // You can change the text color
                              fontSize: 8, // You can change the font size
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
///////// original code to display the Album cover graphic and song title from the radio steam... not used in this application.
                  /*// === Album Cover Displayed if available in radio stream : Remmed : Not in CCCR Spec
              FutureBuilder(
                future: _radioPlayer.getArtworkImage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // If there is artwork data, display it e.g. Album Cover
                    return Container(
                      height: 250,
                      width: 250,
                      child: ClipRRect(
                        child: snapshot.data,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  } else {
                    // If there's no artwork data, display a placeholder or no image
                    return Container(
                      height: 250,
                      width: 250,
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/ccr_placeholder.jpg', // Provide your placeholder image
                          fit: BoxFit.scaleDown, //.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  }
                },
              ),
// === END Album Cover Displayed if available in radio stream*/
                  //    SizedBox(height: 20), // spacer 20 pixels high
/*     //=== Album Title and Song Title : remmed out not in spec.
              Text(
                metadata?[0] ?? '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    color: Colors.white10, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                metadata?[1] ?? '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    color: Colors.white10, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              // metadata[2] has http link to album image.
              SizedBox(height: 20),

// === END Album Title and Song Title */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } // end of Build Screen
} // END of Class
