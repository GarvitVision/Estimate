import 'package:flutter/material.dart';

late double screenWidth;
late double screenHeight;
double getxw(w) => (w / screenWidth);
getScreenSize(BuildContext context) {
  screenWidth = MediaQuery.sizeOf(context).width;
  screenHeight = MediaQuery.sizeOf(context).height;
}

screenSizeAndPlatform(BuildContext context) {
  getScreenSize(context);
}