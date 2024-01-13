// social_links_widget.dart
// This file builds the social media icons and urls Row Module
// It is called from main.dart to build the social media icons row in main.dart
// ChatGPT assisted code. Oct 2023.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_parameters.dart';

// This code has the icons and colors and links for the social media buttons.
class SocialMediaLinksRow extends StatelessWidget {
  const SocialMediaLinksRow({Key? key}) : super(key: key);

  // Your own PlayStore or AppStore Link
  final String appStoreLink = AppParameters.appStoreLink;
  final String subject = AppParameters.emailSubject;
  final Color customColor1 = AppParameters.customColor1;

  @override
  Widget build(BuildContext context) {
    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.,
      children: <Widget>[
        const Spacer(), // ChatGPT assist spacer ..outer spacer!
        const CircularSocialMediaIcon(
          icon: FontAwesomeIcons.globe, // website icon
          backgroundColor: Colors.pink, //
          url: 'https://cr.ie', // Cork Community Radio website
        ),
        const Spacer(),
        const CircularSocialMediaIcon(
          icon: FontAwesomeIcons.facebook,
          backgroundColor: Colors.blue, // Blue background for Facebook
          url: 'https://www.facebook.com/CorkCityCommunityRadio',
        ),
        const Spacer(),
        const CircularSocialMediaIcon(
            icon: FontAwesomeIcons.twitter,
            backgroundColor: Colors.blue, // Blue background for Twitter
            url: 'http://twitter.com/CorkCity_radio' //'https://twitter.com/',
            ),

        /*
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.youtube,
          backgroundColor: Colors.red, // Red background for Youtube
          url: 'https://youtube.com/channel/UChxo4t9JesLZKd2tjI_KmJg',
        ),
         CircularSocialMediaIcon(
          icon: FontAwesomeIcons.instagram,
          backgroundColor: Colors.red, // Red background for Instagram
          url: 'https://www.instagram.com/corkcitycommunityradio/',
        ),
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.tiktok,
          backgroundColor: Colors.black, // Black background for TikTok
          url: 'https://www.tiktok.com/@corkcitycommunityradio?_t=8X9fGFmX9Da&_r=1',
        ),*/

/*        // SHARE BUTTON - Use Builder to get the widget context
        Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () => _onShare(context),
              child: const Text('Share'),
            );
          },
        ),*/

        const Spacer(),

        // Chat GPT Brill : Share button with an icon
        Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => _onShare(context),
              child: Container(
                width: sizeAdjustFactor / 7, //30, // Adjust the size as needed
                height: sizeAdjustFactor / 7, // 30, // Adjust the size as needed
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Change the color as needed
                ),
                child: const Center(
                  child: Icon(
                    Icons.share,
                    color: Colors.white, // Change the color as needed
                  ),
                ),
              ),
            );
          },
        ),
        const Spacer(),
      ],
    );
  }

  _onShare(BuildContext context) async {
    // ToDo: Note: we use the package info plugin to get the package name and then concantanate into the Google Play store link
    // This avoids embedding the link in the code. ToDo Apple App Store version?
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    //String version = packageInfo.version;
    //String buildNumber = packageInfo.buildNumber;

    String playStoreLink = 'https://play.google.com/store/apps/details?id=$packageName';

    await Share.share(
      //appStoreLink,
      playStoreLink,
      subject: subject,
      // sharePositionOrigin: box?.localToGlobal(Offset.zero) & box.size
    );
  }
} // END CLASS

// This code takes the icon, url link and container color
// It builds the icons in containers which can be pressed to goto Facebook etc
class CircularSocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String url; // links to  Cork Radio social media sites.
  final Color backgroundColor;

  // This code is called the Constructor: It is needed to setup memory for the variables.
  const CircularSocialMediaIcon(
      //{Key? key}) : super(key: key);

      {
    required this.icon,
    required this.url,
    required this.backgroundColor,
  });

// This code is a Future to launch the url link
// see docs on pub.dev for all options We use the 'launch in browser'
  Future<void> launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url'; // error msg if it fails for any reason
    }
  }

  // This code Builds the onTap Container
  @override
  Widget build(BuildContext context) {
    // Parameters: This code adjusts the icon/text sizes for different screen sizes, phones , iPads, TVs.
    // It gets the device screen size from MediaQuery in app_parameters.dart file
    // usage of parameters from AppParameters
    //final Color customColor1 = AppParameters.customColor1;
    //final double iconSize = AppParameters.getIconSize(context);
    //final double screenWidth = AppParameters.getScreenWidth(context);
    final double sizeAdjustFactor = AppParameters.getSizeAdjustFactor(context);
    ////////////

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Handle the url icon tap e.g., open a web page - Facebook etc
          // You can use the url_launcher library package for this on pub.dev.
          // Example: launchUrl(url as Uri);
          // Convert the url to Uri before launching it
          launchUrl(Uri.parse(url)); // ChatGPT suggest parse : works
        },
        child: Container(
          width: sizeAdjustFactor / 3, // adjusts to screen sizes based on screen size
          height: sizeAdjustFactor / 7, // adjusts to screen sizes
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Center(
            child: Icon(
              icon,
              size: sizeAdjustFactor / 10,
              color: Colors.white, // icon color
            ),
          ),
        ),
      ),
    );
  }
}
//
//Chat GPT assisted code:
//The CircularSocialMediaIcon widget now accepts a backgroundColor parameter,
// allowing you to specify the background color for each social media icon.
//In the CircularSocialMediaIcon widget, a Container is used with a circular shape (shape: BoxShape.circle)
// and the specified backgroundColor.
//The Icon is placed inside the circular container with a white icon color,
// and you can adjust the size and other properties as needed.
//Now, each social media icon will have its own circular background with the specified color.
// You can customize the backgroundColor for each social media platform to match the design you desire.

// ChatGPT on launchUrl
//We use await with canLaunch to check if the URL can be launched.
//If it can be launched, we use await with launch to open the URL.
//The uri.toString() method converts the Uri to a string before passing it to canLaunch and launch.
//Please make sure to use the corrected code above to handle URL launching.
// The await keyword should be used in these specific functions to ensure they complete successfully
// before moving on to the next step
