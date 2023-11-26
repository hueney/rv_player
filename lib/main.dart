/*  main.dart : Radio Video Sponsor APP for Community Radio stations
 *  Base Code created by Ilya Chirkunov <xc@yar.net> on 28.12.2020.
 * Modified by the super Kids of Coder Dojo Club Glanmire, Cork, Ireland  Oct 2023
 * for Cork Community Radio, Ireland
 */

import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:rv_player/sponsor.dart';
import 'package:rv_player/video_player.dart';

import 'social_links.dart';

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
  //Define Radio Station Parameters here
  String radioStationName = 'Cork Community Radio Player';
  String radioStationUrl = 'http://stream.cr.ie:8002/mp3'; // Cork Community Radio Stream
  String radioStationImagePath = 'assets/cccr.jpg';
  bool radioIsPlaying = false;
  final RadioPlayer _radioPlayer = RadioPlayer();
  String developerInfo = "@Coder Dojo Club - Glanmire 2023";

  List<String>? metadata; // metadata in radio stream contains artist or Album cover image

  @override
  void initState() {
    super.initState();
    initRadioPlayer(); // initialise the radio player plugin
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
        title: radioStationName, url: radioStationUrl, imagePath: radioStationImagePath);

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        radioIsPlaying = value;
      });
    });
    //print("radio IS PLAYING $radioIsPlaying");
    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

// Build Screen here
  @override
  Widget build(BuildContext context) {
    // Define the custom color using RGB values of radio station website brand color
    const customColor1 = Color.fromRGBO(115, 1, 3, 1.0); // CCR red brand color

    // This code adjusts the icon sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; //60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); //clamp to max size

    //
    return MaterialApp(
      // Safe area means no image in the system top status bar.
      home: SafeArea(
        child: Scaffold(
          appBar: null, // nothing in the App Bar
          // body: Container(
          //   color: customColor1, // Set the background color of the Scaffold
          //   height: MediaQuery.of(context).size.height, // Set height to fill the screen
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: customColor1, // fill the screen with Brand color
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Cork Community Radio Brand Circle Image

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: sizeAdjustFactor * 0.8,
                            height: sizeAdjustFactor *
                                0.8, // auto adjusted for different screen sizes

                            child: ClipRRect(
                              child: Image.asset(
                                radioStationImagePath,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),

                        // Listen Live Radio Button
                        ElevatedButton(
                          onPressed: () {
                            // Define the action to be performed when the button is pressed.
                            // radioIsPlaying boolean value is set to false on initialization.
                            radioIsPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(customColor1),
                          ),
                          child: radioIsPlaying
                              ? Image.asset(
                                  'assets/listen_live_pause.jpg',
                                  width: sizeAdjustFactor * 0.6,
                                  height: sizeAdjustFactor / 3,
                                  fit: BoxFit.scaleDown,
                                )
                              : Image.asset(
                                  'assets/listen_live.jpg',
                                  width: sizeAdjustFactor * 0.6,
                                  height: sizeAdjustFactor / 3,
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                      ],
                    ),

// Video Player Container
                    const VideoPlayerWidget(), // display the Video here
                    const SizedBox(height: 10), // 10 pixel separator line
// Sponsor Graphic
                    const SponsorGraphicWidget(),
                    const SizedBox(height: 10),
// Social Media Row Icons
                    const SocialMediaLinksRow(),
// Developer Info
                    SizedBox(
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
//
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } // end of Build Screen
} // END of Class
