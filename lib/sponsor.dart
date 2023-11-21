// sponsor.dart :: ChatGPT assisted code. Fix on Stackoverflow

// this code displays the Sponsor Graphic fetched from the Radio station website - sponsor.jpg
// it also loads the Sponsor text file which contains the Sponsor Website url sponsorURL.txt
// Users can tap on the Sponsor Graphic and goto the Sponsor Website ... big selling benefit.
// if there is an error in displaying the Sponsor image make the container invisible ..hide it
// use Visibility code see video player code

// https://stackoverflow.com/questions/52568872/flutter-how-to-handle-image-network-error-like-404-or-wrong-url/66167613#66167613
// stackoverflow answered it: no 404 error in release version of the apk - so ignore in dev apk.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class SponsorGraphicWidget extends StatefulWidget {
  @override
  SponsorGraphicWidgetState createState() => SponsorGraphicWidgetState();
}

class SponsorGraphicWidgetState extends State<SponsorGraphicWidget> {
  //final String sponsorGraphicUrl = 'https://cccr2016.files.wordpress.com/2023/02/community-centre-facade-2.jpg?w=2046';

  final String sponsorGraphicUrl =
      'https://storage.googleapis.com/dam-mus-prd-7e2fdbe.mus.prd.v8.commerce.mi9cloud.com/Images/App/Service-RR-780x450.jpg';

  //location of sponsor url
  String sponsorTextURL =
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt';
  // sponsorWebURL : onTap of Sponsor graphic to go to the Sponsor website
  String sponsorWebURL = ''; // extracted from the file at sponsorTextUrl

  @override
  void initState() {
    super.initState();
    fetchSponsorURL();
  }

  @override
  Widget build(BuildContext context) {
    // This code adjusts the icon sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; //60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); //clamp to max size

    // ChatGPT : use Inkwell to wrap the sponsor graphic with onTap method
    return InkWell(
      onTap: () {
        if (sponsorWebURL != null && sponsorWebURL.isNotEmpty) {
          launchUrlString(sponsorWebURL); // onTap goto Sponsor website
        }
      },
      child: FutureBuilder(
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
              width: sizeAdjustFactor, // scale as needed
              height: sizeAdjustFactor / 1.5,
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }

  // Code to load image from web : if no image or error then hide with Visibility widget.
  Future<Widget> loadImage() async {
    print("IN loadImage ...sponsorGraphicURL is $sponsorGraphicUrl");
    try {
      // Fetch the image.
      return Image(
        image: NetworkImage(sponsorGraphicUrl),
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

  // ChatGPT : how to extract sponsor URL from remote website without downloading the file: Brill

  Future<void> fetchSponsorURL() async {
    final url = Uri.parse(sponsorTextURL); // Replace with your URL

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        extractUrl(response.body);
      } else {}
    } catch (e) {
      print('Error fetching content: $e');
    }
  }

  void extractUrl(String responseBody) {
    setState(() {
      sponsorWebURL = responseBody.trim(); // Trim to remove leading/trailing whitespace
    });
  }
}

// TODO DELETE these notes before RELEASE
// The response body will be just one line of text which is a url string address.
//ChatGPT
//If the response body contains just a single line of text that represents a URL string address,
// you can extract the URL directly from the response body without needing to parse HTML
// or use complex extraction methods.

//This approach assumes the response body contains only the URL string
// and doesn't require additional parsing or extraction logic beyond retrieving the body's content.
// Adjust the URL extraction process as needed based on the specific structure of your response body.
