import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryDarkColor,
            centerTitle: true,
            title: const Text(
              "Home Page",
            ),
          ),
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/selectModelsAccess');
                },
                child: Card(
                  margin: EdgeInsets.all(screenHeight * 0.015),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Container(
                    width: double.maxFinite,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/accessories2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.01),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          Text(
                            "Only \nAccessories",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.04,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
