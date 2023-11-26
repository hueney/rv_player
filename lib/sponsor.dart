// sponsor.dart :: ChatGPT assisted code. Fix on Stackoverflow

// This code displays the Sponsor Graphic fetched from the Radio station website - sponsor.jpg
// it also loads the Sponsor text file which contains the Sponsor Website url sponsorURL.txt
// Users can tap on the Sponsor Graphic and goto the Sponsor Website ... big selling benefit.
// if there is an error in displaying the Sponsor image load an asset placeholder image

// Note in debug mode the web error codes are displayed but not when you release in release mode.
// stackoverflow answered it: no 404 error in release version of the apk - so ignore in dev apk.
// https://stackoverflow.com/questions/52568872/flutter-how-to-handle-image-network-error-like-404-or-wrong-url/66167613#66167613

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class SponsorGraphicWidget extends StatefulWidget {
  // Add a named key parameter to the constructor
  const SponsorGraphicWidget({Key? key}) : super(key: key);
  @override
  SponsorGraphicWidgetState createState() => SponsorGraphicWidgetState();
}

class SponsorGraphicWidgetState extends State<SponsorGraphicWidget> {
  //Test url
  final String sponsorGraphicUrl =
      'https://cccr2016.files.wordpress.com/2023/02/community-centre-facade-2.jpg?w=2046';

  // final String sponsorGraphicUrl =
  // 'https://storage.googleapis.com/dam-mus-prd-7e2fdbe.mus.prd.v8.commerce.mi9cloud.com/Images/App/Service-RR-780x450.jpg';

  //location of sponsor website url in sponsorURL.txt on the App owner website.
  String sponsorTextURL =
      'https://raw.githubusercontent.com/rayzor/rv_player/main/sponsorURL.txt';

  // sponsorWebsiteURL : onTap of Sponsor graphic to go to the Sponsor website
  String sponsorWebsiteURL =
      'https://cr.ie/'; // Default jic : extracted from the file at sponsorTextUrl

  bool allowOnTap =
      false; // only allow onTap on sponsor image if we get legit sponsor graphic and legit url
  bool showPlaceholder = false; // use this boolean if network image fails

  @override
  void initState() {
    super.initState();
    getSponsorURL(); // from radio station text file called sponsor.txt
  }

  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; //60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); //clamp to max size

    // ChatGPT : use Inkwell to wrap the sponsor graphic with onTap method to launch link to the Sponsor website
    return InkWell(
      onTap: () {
        //allow OnTap if we load the Sponsor Image else don't.
        if (allowOnTap) {
          launchUrlString(sponsorWebsiteURL);
        }
      },
      child: FutureBuilder(
        future: getSponsorImage(sizeAdjustFactor),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // print("Error in FutureBuilder: ${snapshot.error}");
            return Container(); // Or any other non-null widget
          } else {
            return snapshot.data ?? Container();
          }
        },
      ),
    );
  } // end Build screen

  // IMAGE get code
  // Code to load image from web : if no image or error then show placeholder
  Future<Widget> getSponsorImage(double sizeAdjustFactor) async {
    try {
      final response = await http.get(Uri.parse(sponsorGraphicUrl));

      if (response.statusCode == 200) {
        showPlaceholder = false; // got good response so dont show placeholder
        allowOnTap = true; // Sponsor Image then allow Tap to go to Sponsor website

        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            sponsorGraphicUrl,
            width: sizeAdjustFactor,
            height: sizeAdjustFactor / 1.5,
            fit: BoxFit.cover,
          ),
        );
      } else {
        showPlaceholder = true;
        allowOnTap = false; // if no Sponsor then do not allow Tap to go to website

        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            'assets/sponsorPlaceholder.jpg',
            width: sizeAdjustFactor,
            height: sizeAdjustFactor / 1.5,
            fit: BoxFit.cover,
          ),
        );
      }
    } catch (e) {
      // print("Error in getSponsorImage: $e");
      return Container(); // Return an empty container in case of an error
    }
  }

  // ChatGPT : how to extract sponsor URL from remote website without downloading the file: Brill use raw
  // URL extraction code
  Future<void> getSponsorURL() async {
    final url = Uri.parse(sponsorTextURL); // extract the URL from the sponsor.txt file
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 200 is success code from browser so get website url from text file and trim.
      sponsorWebsiteURL = (response.body).trim(); //
      allowOnTap = true; // allow tap on Sponsor image to go to their Website
    } else {
      allowOnTap = false;
    }
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
