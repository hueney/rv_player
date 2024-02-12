//Fail :wont display sponsor image from network  403 returned ???

// sponsor_widget.dart :: ChatGPT assisted code. Fix on Stackoverflow

// This code displays the Sponsor Graphic fetched from the Radio station website - sponsor.jpg
// it also loads the Sponsor text file from the Radio station website
// which contains the Sponsor Website URL The file must be called sponsorURL.txt
// Users can tap on the Sponsor Graphic and goto the Sponsor Website ... big selling benefit.
// if there is an error in displaying the Sponsor image load an asset placeholder image

// Note in debug mode the web error codes are displayed but not whee in release mode.
// stackoverflow answered it: no 404 error in release version of the apk - so ignore in dev apk.
// https://stackoverflow.com/questions/52568872/flutter-how-to-handle-image-network-error-like-404-or-wrong-URL/66167613#66167613

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rv_player/app_parameters.dart';
import 'package:url_launcher/URL_launcher_string.dart';

class SponsorGraphicWidget extends StatefulWidget {
  // Add a named key parameter to the constructor
  const SponsorGraphicWidget({Key? key}) : super(key: key);
  @override
  SponsorGraphicWidgetState createState() => SponsorGraphicWidgetState();
}

class SponsorGraphicWidgetState extends State<SponsorGraphicWidget> {
  // Enter your radio station's URLs in app_parameters.dart
  // Use AppParameters to access your parameters

  String sponsorGraphicURL = AppParameters.sponsorGraphicUrl; // on the station server
  String sponsorTextURL = AppParameters.sponsorTextURL; // on the station server

  // a default general sponsorWebsiteURL is defined in App Params jic
  String sponsorWebsiteURL = AppParameters.sponsorWebsiteURL; // default url jic
  String sponsorPlaceholder = AppParameters.sponsorPlaceholder; // from assets.

//  allow onTap sponsor image if legit sponsor graphic AND sponsor URL
  bool validSponsorGraphic = false;
  bool validSponsorURL = false;

  bool showPlaceholder =
      false; // show Placeholder from assets if sponsor image or URL fails

  @override
  void initState() {
    super.initState();
    getSponsorURL(); // from radio station text file called sponsor.txt
  }

  //===============================================
  // ChatGPT : how to extract sponsor URL from remote website file without downloading the file:
  // Brill -use raw URL extraction code
//======================================
  // ToDo: GET SPONSOR URL - Two steps
  // A. Get the sponsor.txt file from the station server and extract the sponsor URL
  // B. Assign this sponsor URL to sponsorWebsiteURL

  Future<void> getSponsorURL() async {
    final url = Uri.parse(sponsorTextURL); // sponsor URL in sponsorUrl.txt file on server
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 200 is success code from browser so get sponsor website URL from text file and trim.
      sponsorWebsiteURL = (response.body).trim(); //
      // print("GET URL VU is ${validSponsorURL} + VG is $validSponsorGraphic");
      validSponsorURL = true;
    } else {
      // print("get url  status code = ${response.statusCode} + $sponsorWebsiteURL");
      validSponsorURL = false;
      //  showPlaceholder = true;
    }
    // print("GET URL VU is ${validSponsorURL} + VG is $validSponsorGraphic");
  }

// Build Screen code
  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters
    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);

    // print("GET URL VU is ${validSponsorURL} + VG is $validSponsorGraphic");
    // ChatGPT : use Inkwell to wrap the sponsor graphic with onTap method to launch link to the Sponsor website
    return InkWell(
      onTap: () {
        print(" onTap  VU is ${validSponsorURL} + VG is $validSponsorGraphic");
        //allow OnTap if we load the Sponsor Image else don't.
        if (validSponsorURL && validSponsorGraphic) {
          launchUrlString(sponsorWebsiteURL);
        }
      },
      child: FutureBuilder(
        future: http.get(Uri.parse(sponsorGraphicURL)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // ??? if snapshot.data is null accept it and dont throw error
            // !!! Not equal to
            if (snapshot.hasError || snapshot.data?.statusCode != 200) {
              validSponsorGraphic = false;
              // Display placeholder image if there's an error or status code is not 200
              return FractionallySizedBox(
                widthFactor: 0.5,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      sponsorPlaceholder, // 'assets/sponsorPlaceholder.jpg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              );
            } else {
              validSponsorGraphic = true;
              // Display sponsor image if status code is 200
              return FractionallySizedBox(
                widthFactor: 0.5,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      sponsorGraphicURL,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              );
            }
          } else {
            validSponsorGraphic = false;
            // Return a loading indicator while waiting for the future to complete
            return Transform.scale(
              scale: 0.5,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue), // Replace with your desired color
                strokeWidth: 2.0, // Adjust the stroke width as needed
              ),
            );
          }
        },
      ),
    );
  } // end Build screen
} // END

// Coder Dojo Club
// Ray Neville 2023
// Denis O'Mahony
// Nathan Manley
