// sponsor_widget.dart :: ChatGPT assisted code. Fix on Stackoverflow

// This code displays the Sponsor Graphic fetched from the Radio station website - sponsor.jpg
// it also loads the Sponsor text file which contains the Sponsor Website URL sponsorURL.txt
// Users can tap on the Sponsor Graphic and goto the Sponsor Website ... big selling benefit.
// if there is an error in displaying the Sponsor image load an asset placeholder image

// Note in debug mode the web error codes are displayed but not when you release in release mode.
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

  String sponsorGraphicURL = AppParameters.sponsorGraphicUrl;
  String sponsorTextURL = AppParameters.sponsorTextURL;

  // Define default sponsorWebsiteURL : onTap of Sponsor graphic to go to the Sponsor website
  String sponsorWebsiteURL = 'https://cr.ie/'; // Default jic
  String sponsorPlaceholder = AppParameters.sponsorPlaceholder; //jic if no graphic

  bool allowOnTap =
      false; // only allow onTap on sponsor image if we get legit sponsor graphic and legit URL
  bool showPlaceholder = false; // use this boolean if network Sponsor image or URL fails

  @override
  void initState() {
    super.initState();
    getSponsorURL(); // from radio station text file called sponsor.txt
  }

  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters

    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);

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
            return const SizedBox(
              width: 20.0, // Adjust the width as needed
              height: 20.0, // Adjust the height as needed
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue), // Replace with your desired color
                strokeWidth: 2.0, // Adjust the stroke width as needed
              ),
            );
          } else if (snapshot.hasError) {
            // print("PRINT >>>>>>>>>Error in FutureBuilder: ${snapshot.error}");
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
      // print("PRINT >>>>>>>>>>>before response ");
      final response = await http.get(Uri.parse(sponsorGraphicURL));
      // print("PRINT >>>>>>>>>>>after response ");
      if (response.statusCode == 200) {
        //  print("PRINT >>>>>>>>>>>Got statusCode = 200 valid link"); // todo UnRem
        showPlaceholder = false; // got good response so don't show placeholder
        allowOnTap = true; // Sponsor Image then allow Tap to go to Sponsor website

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
      } else {
        //print("PRINT >>>>>>> in show sponsorPlaceholder"); // todo UnRem
        showPlaceholder = true;
        allowOnTap = false; // if no Sponsor then do not allow Tap to go to website

        return FractionallySizedBox(
          widthFactor: 0.5,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                //'assets/sponsorPlaceholder.jpg',

                sponsorPlaceholder,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      //print("Error in getSponsorImage: $e"); // todo UnRem
      return Container(); // Return an empty container in case of an error
    }
  }

  // ChatGPT : how to extract sponsor URL from remote website without downloading the file: Brill use raw
  // URL extraction code
  Future<void> getSponsorURL() async {
    final url = Uri.parse(sponsorTextURL); // extract the URL from the sponsor.txt file
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 200 is success code from browser so get website URL from text file and trim.
      sponsorWebsiteURL = (response.body).trim(); //
      allowOnTap = true; // allow tap on Sponsor image to go to the sponsor Website
    } else {
      allowOnTap = false;
    }
  }
}

// TODO Note the text in sponsor.txt must be a simple http link with no extra data
// The response body will be just one line of text which is a URL string address.
//ChatGPT
//If the response body contains just a single line of text that represents a URL string address,
// you can extract the URL directly from the response body without needing to parse HTML
// or use complex extraction methods.

//This approach assumes the response body contains only the URL string
// and doesn't require additional parsing or extraction logic beyond retrieving the body's content.
// Adjust the URL extraction process as needed based on the specific structure of your response body.

/*
ChatGPT : Can you explain to an experienced coder.

ChatGPT
Certainly! Let's dive into a more technical explanation for an experienced coder:

Code Overview:
Import Statements:

Import necessary packages for Flutter (material.dart), HTTP requests (http), app parameters (app_parameters.dart), and URL launching (url_launcher).
Class Definition:

Define a SponsorGraphicWidget class that extends StatefulWidget.
 This class will handle the display of the sponsor's graphic.

Initializing Variables:

Initialize variables to store URLs and related information.
dart
Copy code
String sponsorGraphicURL = AppParameters.sponsorGraphicURL;
String sponsorTextURL = AppParameters.sponsorTextURL;
String sponsorWebsiteURL = 'https://cr.ie/';
String sponsorPlaceholder = AppParameters.sponsorPlaceholder;
bool allowOnTap = false;
bool showPlaceholder = false;
Init State Function:

In the initState method, fetch the sponsor's website URL asynchronously
 using getSponsorURL().
Build Function:

The build method returns a widget tree. It uses an InkWell widget, making the sponsor's graphic tappable.
Within it, a FutureBuilder is used to handle the asynchronous loading of the sponsor's image.
InkWell for Tapping:

The InkWell is wrapped around the sponsor's graphic to make it interactive.
The onTap callback is configured to launch the sponsor's website using the url_launcher package.
Function to Get Sponsor Image:

getSponsorImage is an asynchronous function that fetches the sponsor's image from the given URL.
If successful, it returns a FractionallySizedBox containing the image.
If there's an error or the status code is not 200, it returns a placeholder image.
Function to Get Sponsor URL:

getSponsorURL asynchronously fetches the sponsor's website URL from a remote text file (sponsorTextURL).
If successful, it sets allowOnTap to true, allowing tapping on the sponsor's image to launch the website.
Key Points:
Dynamic Loading:

Images and URLs are loaded dynamically based on the content retrieved from the internet.
Error Handling:

The code gracefully handles errors, such as HTTP errors or failure to retrieve the website URL.
Interactive UI:

The UI is designed to be interactive, allowing users to tap on the sponsor's graphic to visit the sponsor's website.
Asynchronous Operations:

Asynchronous operations are used for fetching data from the internet to avoid blocking the UI thread.
Note:
The code architecture focuses on providing a seamless experience for users,
handling potential errors gracefully, and ensuring the UI remains responsive
during network operations. It leverages Flutter's widget-based approach
 and asynchronous programming for effective UI development.




 */
