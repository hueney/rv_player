// video_player_widget.dart
// this file displays the video from the radio studio if streamed.

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // vid player library by Flutter Team

import 'app_parameters.dart'; // Import the app_parameters file

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // Enter your radio station's URLs in app_parameters.dart
  // Use AppParameters to access your parameters
  //String studioVideoUrl = 'https://www.twitch.tv/corkcitycommunityradio';
  String studioVideoUrl = AppParameters.studioVideoURL;

  late VideoPlayerController _videoPlayer;
  bool validVideo = false; // first check for validVideo stream : exists and no errors

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayer = VideoPlayerController.networkUrl(
      //'YOUR_VIDEO_URL_HERE',
      Uri.parse(studioVideoUrl),
    );
// use a listener to check for video errors and set bool validVideo
    _videoPlayer.addListener(
      () {
        if (_videoPlayer.value.hasError) {
          setState(
            () {
              validVideo = false; // if video error show Placeholder
            },
          );
        } else {
          setState(() {
            validVideo = true;
          });
        }
      },
    );

    // check video player is initialised and set bool validVideo
    try {
      await _videoPlayer.initialize();
    } catch (e) {
      // print('Error initializing video player: $e');
      setState(() {
        validVideo = false;
      });
    }
    //It is an error to call setState unless mounted is true.
    if (mounted) {
      setState(() {}); // Refresh the UI after initialization
    }
  }

  // Build the Screen code below
  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters
    Color customColor1 = AppParameters.customColor1;
    double iconSize = AppParameters.getIconSize(context);
    double screenWidth = AppParameters.getScreenWidth(context);
    double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);
    iconSize = AppParameters.getIconSize(context);

// size adjustments above
//If the video is not available due to an error or an absence of the video stream,
// show a placeholder instead and hide the Watch button with Visibility widget.

    return Container(
      padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
      decoration: BoxDecoration(
        border: Border.all(
          color: customColor1, // Adjust the border color
          width: 2.0, // Adjust the border width
        ),
        borderRadius: BorderRadius.circular(8.0), //  border radius
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // if the video is playing then show the video else show placeholder image
          _videoPlayer.value.isPlaying
              ? Expanded(
                  //flex: 3,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: AspectRatio(
                    aspectRatio: _videoPlayer.value.aspectRatio,
                    child: VideoPlayer(_videoPlayer), // play the video
                  ),
                ))
              : Expanded(
                  //flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: AspectRatio(
                      aspectRatio: _videoPlayer.value.aspectRatio ?? 1.0,
                      child: Image.asset(
                        'assets/ccr_studio1a.jpg', // Replace with your placeholder image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
// Watch Live Button: Video Play and Pause Button : invisible (hide) if no video stream.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              // ChatGPT assist : Visibility widget to hide the Play button if no video stream
              visible: validVideo, // if validVideo show the Watch Button
              child: ElevatedButton(
                onPressed: () {
                  // Define the action to be performed when the video button is pressed.
                  setState(() {
                    _videoPlayer.value.isPlaying
                        ? _videoPlayer.pause()
                        : {
                            _videoPlayer.play(),
                            validVideo = true // set validVideo boolean
                          };
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      customColor1), // Use your custom brand color
                ),
                child: _videoPlayer.value.isPlaying // test isPlaying boolean
                    ? Image.asset(
                        'assets/watch_live_pause.jpg',
                        width: sizeAdjustFactor, // scale width as needed
                        height: sizeAdjustFactor / 3.5,
                        fit: BoxFit.scaleDown,
                      )
                    : Image.asset(
                        'assets/watch_live.jpg',
                        width: sizeAdjustFactor, // scale width as needed
                        height: sizeAdjustFactor / 3.5, // 80,
                        fit: BoxFit.scaleDown,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayer.dispose();
  }
}
