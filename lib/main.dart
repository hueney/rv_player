/*  main.dart
 *  Base Code created by Ilya Chirkunov <xc@yar.net> on 28.12.2020.
 * Modified by Kids of Coder Dojo Club Glanmire Oct 2023
 * for Cork Community Radio
 */

import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:rv_player/video_player_widget.dart';

import 'social_links.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RadioTVApp());
}

class RadioTVApp extends StatefulWidget {
  @override
  RadioTVAppState createState() => RadioTVAppState();
}

class RadioTVAppState extends State<RadioTVApp> {
  //Define Radio Station Parameters here
  String radioStationName = 'Cork Community Radio Player';
  String radioStationUrl = 'http://stream.cr.ie:8002/mp3';
  String radioStationImagePath = 'assets/cccr.jpg';
  bool radioIsPlaying = false;
  final RadioPlayer _radioPlayer = RadioPlayer();
  String developerInfo = "@Glanmire Coder Dojo Club 2023";

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

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

// Build Screen here
  @override
  Widget build(BuildContext context) {
    // Define the custom color using RGB values of radio station
    final customColor1 = Color.fromRGBO(115, 1, 3, 1.0); // CCR red brand color
    //final customColor2 = Color.fromRGBO(104, 34, 32, 1.0);
    return MaterialApp(
      home: Scaffold(
        appBar: null, // nothing in the App Bar
        body: SafeArea(
          // Safe area means no image in the system top status bar.
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: customColor1,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Cork Community Radio Brand Circle Image
                    Container(
                      height: 250,
                      width: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          radioStationImagePath,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),

                    //  Listen Live Radio Button
                    ElevatedButton(
                      onPressed: () {
                        // Define the action to be performed when the button is pressed.
                        radioIsPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(customColor1),
                        //  splashFactory: InkSparkle.splashFactory
                      ),
                      child:
                          radioIsPlaying // this is conditional syntax: If true ? Do This : else Do This
                              ? Image.asset(
                                  'assets/listen_live_pause.jpg',
                                  width: 140, // Adjust the width as needed
                                  height: 80,
                                  fit: BoxFit.contain, // This makes the image fill
                                )
                              : Image.asset(
                                  'assets/listen_live.jpg',
                                  width: 140, // Adjust the width as needed
                                  height: 80,
                                  fit: BoxFit.contain, // This makes the image fill
                                ),
                    ),

// === Social Media Row Icons here from separate file social_links.dart
                    const SizedBox(height: 10),
                    // Social Media Row Icons here from separate file social_links.dart
                    SocialMediaLinksRow(),
                    const SizedBox(height: 20), // spacer box 20 pixels high
                    //VideoPlayerWidget(radioIsPlaying: radioIsPlaying, ), // pass the radioPlayingBoolean to
                    Container(
                      padding: EdgeInsets.all(16.0), // Adjust the padding as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: customColor1,
                          //color: Colors.blueGrey, // Adjust the border color
                          width: 2.0, // Adjust the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8.0), // Adjust the border radius
                      ),
                      child: VideoPlayerWidget(), // display the Video here
                    ),
                    //VideoPlayerWidget(),
                    const SizedBox(height: 10),
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
// === Album Cover Displayed if available in radio stream*/
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

// === Album Title and Song Title */
// Developer Info at bottom of page:
                    SizedBox(
                      width: 200, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey, // You can change the background color
                          borderRadius:
                              BorderRadius.circular(15.0), // Adjust the radius as needed
                        ),

                        // color: Colors.blueGrey, // You can change the background color

                        child: Center(
                          child: Text(
                            developerInfo,
                            style: TextStyle(
                              color: Colors.white, // You can change the text color
                              fontSize: 8, // You can change the font size
                            ),
                          ),
                        ),
                      ),
                    ),
                    // filler
                    SizedBox(
                      width: MediaQuery.of(context).size.width, // Adjust width to screen
                      height: MediaQuery.of(context).size.width / 2,

                      child: Container(
                        decoration: BoxDecoration(
                          color: customColor1, // You can change the background color
                        ),

                        // color: Colors.blueGrey, // You can change the background color

                        child: Center(
                          child: Text(
                            "",
                            style: TextStyle(
                              color: customColor1, // You can change the text color
                              fontSize: 8, // You can change the font size
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
