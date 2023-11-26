// app_parameters.dart : commonly used params across the app.

class AppParameters {
  static double getScreenSizeAdjustFactor(double screenWidth) {
    double sizeAdjustFactor = screenWidth;
    double iconSize = sizeAdjustFactor * 0.6; // 60% of container size
    double maxSize = 200.0; // set a max jic - realistic
    sizeAdjustFactor = sizeAdjustFactor.clamp(0.0, maxSize); // clamp to maxsize
    iconSize = iconSize.clamp(0.0, maxSize * 0.5); // clamp to max size

    return sizeAdjustFactor;
  }
}

// How to use in the APP
// // Import the app_parameters.dart file where needed
// import 'app_parameters.dart';
//
// // Use the parameters in your widget
// double screenWidth = MediaQuery.of(context).size.width;
// double sizeAdjustFactor = AppParameters.getScreenSizeAdjustFactor(screenWidth);
// double iconSize = sizeAdjustFactor * 0.6; // 60% of container size
