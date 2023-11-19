// sponsor_graphic.dart :: ChatGPT assisted code. Fix on Stackoverflow
// https://stackoverflow.com/questions/52568872/flutter-how-to-handle-image-network-error-like-404-or-wrong-url/66167613#66167613
// stackoverflow answered it: no 404 error in release apk.Good.
// this code specifies the Sponsor Graphic url on the Radio station website to be displayed
// when no video is playing from the radio station studio
// also if there is an error in displaying the Sponsor image a blank Placeholder image is used.

import 'package:flutter/material.dart';

class SponsorGraphicWidget extends StatelessWidget {
  //Sponsor Image location for display when video is not streaming.

  final String sponsorGraphicUrl =
      // Example only: correct Sponsor graphic must be loaded to a specific Sponsor url
      //which must be used here as the sponsorGraphicUrl
      'https://cccr2016.files.wordpress.com/2023/02/community-centre-facade-2.jpg?w=2046';

  //  use blank placeholder if neither Sponsor graphic or video is available
  final String placeHolderBlank = 'assets/ccr_placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the image is being loaded, you can show a placeholder or a loading indicator.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Image.asset(
            placeHolderBlank,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
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

  // use FadeInImage to default to Blank red asset image if no video or no sponsor image.
  Future<Widget> loadImage() async {
    try {
      // Fetch the image.
      return FadeInImage(
        image: NetworkImage(sponsorGraphicUrl),
        placeholder: AssetImage(placeHolderBlank),
        //    imageErrorBuilder:  (context, error, stackTrace) { return Image.asset('assets/images/error.jpg',fit: BoxFit.fitWidth);
        // You can customize fade-in duration and other properties
        // fadeInDuration: Duration(milliseconds: 500),

        fit: BoxFit.cover,
      );
    } catch (_) {
      // If there's an error loading the image, return a placeholder.
      return Image.asset(
        placeHolderBlank, // Replace with your placeholder image path
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }
}
