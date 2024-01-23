import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/SetUp/selectModel.dart';
import 'package:newapp/Screens/homeScreen.dart';
import 'package:newapp/Screens/setupScreen.dart';
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
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          backgroundColor: primaryDarkColor,
          foregroundColor: lightColoredText,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),

            )
          ),
          titleTextStyle: TextStyle(
            fontSize: screenHeight * 0.025,
            color: lightColoredText,
            fontFamily: 'JaneCaps'
          ),
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: primaryDarkColor),
        useMaterial3: true,
        fontFamily: 'JaneCaps',
      ),

      home:  const SelectModelSetup(),
    );
  }
}

