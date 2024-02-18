// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/SetUp/selectModel.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/setupStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    wheretoNavigate();
  }

  wheretoNavigate() async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString(SETUP_STATUS) ?? "0.0";
    if (pref.getString("ITEMS") != null) {
      await getItems();
    }
    await fetchItems();
    if (num.parse(value).toStringAsFixed(2) == "1.00") {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectModelSetup(),
            ),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Container(
            width: screenHeight * 0.4,
            height: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/BELogo.png",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
