import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDarkColor,
        centerTitle: true,
        title: const Text(
          "Home Page",
        ),
      ),
    );
  }
}
