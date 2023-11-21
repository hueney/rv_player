// sponsor_graphic.dart :: ChatGPT assisted code. Fix on Stackoverflow

// this code displays the Sponsor Graphic from the Radio station website - sponsorURL
// it also loads the Sponsor text file with the Sponsor url to their website
// if there is an error in displaying the Sponsor image make the container invisibe ..hide it
// use Visibility code see video player code

// https://stackoverflow.com/questions/52568872/flutter-how-to-handle-image-network-error-like-404-or-wrong-url/66167613#66167613
// stackoverflow answered it: no 404 error in release version of the apk.

import 'package:flutter/material.dart';

class SponsorGraphicWidget extends StatelessWidget {
  final String sponsorGraphicUrl =
      // Example only: correct Sponsor graphic must be loaded with the text file Sponsor url
      // which must be used here as the sponsorGraphicUrl
      'https://cccr2016.files.wordpress.com/2023/02/community-centre-facade-2.jpg?w=2046';
  final sponsorTextURL = 'https://cccr2016.files.wordpress.com/2023/02/sponsorURL';
// If no Sponsor graphic or text file with URL then hide the container. . give no error to users.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the image is being loaded, you can show a loading indicator.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Visibility(
            visible: false,
            child: Container(),
          );
        } else {
          // Once the image is loaded, display it.
          return Image.network(
            sponsorGraphicUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  // Code to load image from web : if no image or error then hide with Visibility widget.
  Future<Widget> loadImage() async {
    try {
      // Fetch the image.
      return Image(
        image: NetworkImage(sponsorGraphicUrl),
        // placeholder: AssetImage(placeHolderBlank),
        fit: BoxFit.cover,
      );
    } catch (_) {
      // If there's an error loading the image, hide the display
      return Visibility(
        visible: false,
        child: Container(),
      );
    }
  }
}
