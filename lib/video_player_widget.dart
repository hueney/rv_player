import 'package:flutter/material.dart';
import 'package:rv_player/sponsor_graphic.dart';
import 'package:video_player/video_player.dart'; // vid player library by Flutter Team

class VideoPlayerWidget extends StatefulWidget {
  // const VideoPlayerWidget({Key? key}) : super(key: key);
  // bool radioIsPlaying;
  // VideoPlayerWidget({Key? key, required this.radioIsPlaying}) : super(key: key);
  VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  //define video player parameters here
  late VideoPlayerController _videoPlayer;
  bool videoIsPlaying = false;
  bool _showSponsorGraphic = false; // show a sponsor graphic if no video is playing.
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
    // mod if needed
    // // Use widget.radioIsPlaying to access the boolean value
    //     if (widget.radioIsPlaying = false) {
    //       // Logic to initialize video player based on radioIsPlaying if needed.

    _videoPlayer = VideoPlayerController.networkUrl(
      Uri.parse(studioVideoUrl),
    ); //'YOUR_VIDEO_URL_HERE',
// use a listener to check for video errors and set bool _showSponsor true to display graphic insted.
    _videoPlayer.addListener(() {
      if (_videoPlayer.value.hasError) {
        setState(() {
          _showSponsorGraphic = true; // if video error show a sponsor graphic
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
        _showSponsorGraphic = true; // if video fails to initialise show sponsor graphic
      });
    }
    //It is an error to call setState unless mounted is true.
    if (mounted) {
      setState(() {}); // Refresh the UI after initialization
    }
  }

  @override
  Widget build(BuildContext context) {
    bool flag = _videoPlayer.value.isPlaying; // test var
    //print("+++++++++++++ video IS Playing value is ====== $flag");
    final customColor1 = Color.fromRGBO(115, 1, 3, 1.0); // CCR red brand color
    // This code adjusts the icon sizes for different screen sizes.
    // It uses the device screen size via MediaQuery to determine how large the icons should be.
    double iconSize;
    double containerSize;
    // Get the screen width f your phone using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    // Define a maximum size for the container and icon .. to remain realistic
    double maxSize = 100.0; // Adjust as needed
    // Calculate the size based on screen width, ensuring it doesn't exceed the maximum
    containerSize = screenWidth / 8; // For example, divide the screen width into 1/8s
    iconSize = containerSize *
        0.6; // Adjust icon size as a fraction of container size - nice code ChatGPT
    // Apply a maximum size constraint
    containerSize = containerSize.clamp(0.0, maxSize);
    iconSize = iconSize.clamp(0.0, maxSize * 0.5);

    // size adjustments above
//If the video is not displaying due to an error or an absence of the video stream,
// you can modify your code to display a placeholder or a specific graphic
// when the video fails to load or encounters an error. To handle this situation,
// you can utilize the VideoPlayerController's listener to detect errors and update the UI accordingly.
    // print(">>>>>>>>>>>>> show sponsor graphic TEST bool is: = $_showSponsorGraphic");
    //_showSponsorGraphic = false; //todo rem test
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _showSponsorGraphic // if true then no video stream or a video error
            ? SponsorGraphicWidget() // call the SponsorGraphicWidget
            : _videoPlayer.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayer.value.aspectRatio,
                    child: VideoPlayer(_videoPlayer), // play the video
                  )
                : const CircularProgressIndicator(), // else Loading indicator while waiting

// Video Play and Pause Button

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            // ChatGPT assist very nice code to hide the Play button if no video stream
            visible: !_showSponsorGraphic,
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
                      'assets/tv_pause.png',
                      width: 40, // Adjust the width as needed
                      height: 40,
                      fit: BoxFit.contain, // This makes the image fill
                    )
                  : Image.asset(
                      'assets/tv_play.png',
                      width: 40, // Adjust the width as needed
                      height: 40,
                      fit: BoxFit.contain, // This makes the image fill
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
