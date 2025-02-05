import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/Accessories/enterQuantity.dart';
import 'package:newapp/Screens/SetUp/selectModel.dart';
import 'package:newapp/Screens/addItems.dart';
import 'package:newapp/Utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.white,
            width: screenWidth * 0.5,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.01,
                  vertical: screenHeight * 0.1,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectModelSetup(),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.02,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee_rounded,
                              ),
                              const Spacer(),
                              Text(
                                "Change Models MRP",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          showDragHandle: true,
                          enableDrag: true,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return AddItems();
                          },
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.02,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: screenWidth * 0.33,
                                child: Text(
                                  "Add more Items to Accessories",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EnterQuantity(),
                    ),
                  );
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
