import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // vid player library by Flutter Team

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  //define video player parameters here
  late VideoPlayerController _videoPlayer;
  bool videoIsPlaying = false;
  bool hideVideoDisplay = false; // hide video display if no video stream is playing.
  String studioVideoUrl =
      'https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8';

  /// CCR Studio Video feed url
  // 'https://youtu.be/X2wKE1RPULg')); // CCR website video : link is to Youtube!

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayer = VideoPlayerController.networkUrl(
        Uri.parse(studioVideoUrl)); //'YOUR_VIDEO_URL_HERE',
// use a listener to check for video errors and set bool hideVideoDisplay = true
    _videoPlayer.addListener(() {
      if (_videoPlayer.value.hasError) {
        setState(() {
          hideVideoDisplay = true; // if video error hide the video display & Play button
          //  print("video value has error");
        });
      }
    });

    // test video player is initialised and set bool if not
    try {
      await _videoPlayer.initialize();
    } catch (e) {
      // print('Error initializing video player: $e');
      setState(() {
        hideVideoDisplay = true; // if video fails to initialise hide video display
      });
    }
    //It is an error to call setState unless mounted is true.
    if (mounted) {
      setState(() {}); // Refresh the UI after initialization
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColor1 = Color.fromRGBO(115, 1, 3, 1.0); // Radio Station Brand color
    //
    // This code adjusts the icon sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; //60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); //clamp to max size

    // size adjustments above
//If the video is not displaying due to an error or an absence of the video stream,
// use Visibility widget to hide / shrink the container.
// use VideoPlayerController's listener to detect errors and update the UI accordingly.

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Visibility(
          // ChatGPT assist very nice code to hide the Play button if no video stream
          visible: !hideVideoDisplay, // if you have good video display it dont hide it
          child: AspectRatio(
            aspectRatio: _videoPlayer.value.aspectRatio,
            child: VideoPlayer(_videoPlayer), // play the video
          ),
        ),
// Video Play and Pause Button : Both made invisible (hide) if no video stream.

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            // ChatGPT assist very nice code to hide the Play button if no video stream
            visible: !hideVideoDisplay,
            child: ElevatedButton(
              onPressed: () {
                // Define the action to be performed when the video button is pressed.
                // final bool isVideoPlaying = _videoPlayer.value.isPlaying;

                setState(() {
                  _videoPlayer.value.isPlaying
                      ? _videoPlayer.pause()
                      : _videoPlayer.play();
                  // switch off radio when video is pressed Play
                  // widget.radioIsPlaying = !isVideoPlaying;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    customColor1), // Use your custom color
              ),
              child: _videoPlayer.value.isPlaying // test isPlaying boolean
                  ? Image.asset(
                      'assets/watch_live_pause.jpg',
                      width: sizeAdjustFactor * 1.25, // scale width as needed
                      height: sizeAdjustFactor / 3.5, // 80,
                      fit: BoxFit.scaleDown,
                    )
                  : Image.asset(
                      'assets/watch_live.jpg',
                      width: sizeAdjustFactor * 1.25, // scale width as needed
                      height: sizeAdjustFactor / 3.5, // 80,
                      fit: BoxFit.scaleDown,
                    ),
            ),
          ),
        )
        //
        //
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayer.dispose();
  }
}

// ChatGPT assisted Code:
//used the same boolean as the radio player so it toggles the radio to pause if the video is running
//and visa versa
