import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

import 'app_parameters.dart';

class RadioPlayerWidget extends StatefulWidget {
  const RadioPlayerWidget({Key? key}) : super(key: key);

  @override
  RadioPlayerWidgetState createState() => RadioPlayerWidgetState();
}

class RadioPlayerWidgetState extends State<RadioPlayerWidget> {
  late final RadioPlayer _radioPlayer;
  String radioStationImagePath = AppParameters.radioStationImagePath;
  late bool radioIsPlaying = false;
  late List<String>? metadata;

  @override
  void initState() {
    super.initState();
    _radioPlayer = RadioPlayer();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: AppParameters.radioStationName,
      url: AppParameters.radioStationURL,
      imagePath: AppParameters.radioStationImagePath,
    );

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

  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters
    const Color customColor1 = AppParameters.customColor1;
    //final double iconSize = AppParameters.getIconSize(context);
    //final double screenWidth = AppParameters.getScreenWidth(context);
    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Cork Community Radio Brand Circle Image
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: sizeAdjustFactor * 0.8,
            height: sizeAdjustFactor * 0.8, // auto adjusted for different screen sizes

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
            backgroundColor: MaterialStateProperty.all<Color>(customColor1),
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
    );
  }
}

// Ray Neville 2023
// Denis O'Mahony
// Nathan Manley
