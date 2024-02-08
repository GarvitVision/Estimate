import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/Accessories/enterQuantity.dart';
import 'package:newapp/Screens/Accessories/selectModelAccess.dart';
import 'package:newapp/Screens/SetUp/Models/greatWhiteSetup.dart';
import 'package:newapp/Screens/SetUp/Models/hevellsFabioSetup.dart';
import 'package:newapp/Screens/SetUp/Models/l&tSetup.dart';
import 'package:newapp/Screens/SetUp/Models/paramSetup.dart';
import 'package:newapp/Screens/SetUp/Models/paramWoodenSetup.dart';
import 'package:newapp/Screens/SetUp/Models/pentaBlackFlatSetup.dart';
import 'package:newapp/Screens/SetUp/Models/pentaBlackSetup.dart';
import 'package:newapp/Screens/SetUp/Models/pentaWhiteFlatSetup.dart';
import 'package:newapp/Screens/SetUp/Models/pentaWhiteGinaSetup.dart';
import 'package:newapp/Screens/SetUp/Models/pentaWhiteSetup.dart';
import 'package:newapp/Screens/SetUp/Models/romaClassicSetup.dart';
import 'package:newapp/Screens/SetUp/Models/romaUrbanSetup.dart';
import 'package:newapp/Screens/SetUp/Models/zivaBlackSetup.dart';
import 'package:newapp/Screens/SetUp/Models/zivaWhiteSetup.dart';
import 'package:newapp/Screens/SetUp/selectModel.dart';
import 'package:newapp/Screens/homeScreen.dart';
import 'package:newapp/Screens/splashScreen.dart';
import 'package:newapp/Utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/home': (context) => const HomePage(),
        '/pentaWhSetup': (context) => const PentaWhiteScreen(),
        '/paramSetup': (context) => const ParamPlaneScreen(),
        '/selectModelsAccess': (context) => const SelectModelAccess(),
        '/paramWoodenSetup': (context) => const ParamWoodenSetup(),
        '/zivaWhiteSetup': (context) => const ZivaWhiteSetup(),
        '/zivaBlackSetup': (context) => const ZivaBlackSetup(),
        '/pentaWhiteGinaSetup': (context) => const PentaWhiteGinaSetup(),
        '/pentaBlackSetup': (context) => const PentaBlackSetup(),
        '/pentaWhiteFlatSetup': (context) => const PentaWhiteFlatSetup(),
        '/pentaBlackFlatSetup': (context) => const PentaBlackFlatSetup(),
        '/greatWhiteSetup': (context) => const GreatWhiteSetup(),
        '/l&tSetup': (context) => const LTSetup(),
        '/hevellsFabioSetup': (context) => const HavellsFabioSetup(),
        '/romaClassicSetup': (context) => const RomaClassicSetup(),
        '/romaUrbanSetup': (context) => const RomaUrbanSetup(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primaryDarkColor,
          foregroundColor: lightColoredText,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          titleTextStyle: TextStyle(
              fontSize: screenHeight * 0.025,
              color: lightColoredText,
              fontFamily: 'JaneCaps'),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryDarkColor),
        useMaterial3: true,
        fontFamily: 'JaneCaps',
      ),
      home: const SplashScreen(),
    );
  }
}
