import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/commonHelper.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:newapp/Utils/models.dart';
import 'package:newapp/Utils/setupStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectModelSetup extends StatelessWidget {
  const SelectModelSetup({super.key});

  Future getSetupStatus() async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString(SETUP_STATUS) ?? "";
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectModelSetup(),
              ),
              (route) => false),
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(247, 244, 248, 1),
            appBar: AppBar(
              title: Row(
                children: [
                  const Text(
                    "Select Model",
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/home");
                    },
                    icon: const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.91,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: FutureBuilder(
                      future: getSetupStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              height: screenHeight * 0.04,
                              width: screenWidth * 0.91,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          );
                        } else {
                          var fraction = snapshot.data;
                          return Stack(
                            children: [
                              Container(
                                height: screenHeight * 0.04,
                                width: screenWidth * 0.91,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: double.parse(fraction),
                                child: Container(
                                  height: screenHeight * 0.04,
                                  decoration: const BoxDecoration(
                                    color: primaryDarkColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${(double.parse(fraction) * 100).toStringAsFixed(2)} % Setup Complete",
                                    style: TextStyle(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: screenHeight * 0.02,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    color: const Color.fromRGBO(247, 244, 248, 1),
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.035,
                    ),
                    child: Wrap(
                      runSpacing: screenHeight * 0.01,
                      alignment: WrapAlignment.center,
                      spacing: screenWidth * 0.01,
                      children: [
                        for (var index = 0; index < models.length; index++)
                          SizedBox(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.4,
                            child: GestureDetector(
                              onTap: () {
                                CommonHelper.index = index;
                                Navigator.pushNamed(
                                    context, '${Navigate[index]}');
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                elevation: 4,
                                shadowColor: Colors.grey.shade200,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue.shade50,
                                      radius: screenWidth * 0.1,
                                      backgroundImage:
                                          AssetImage(modelImages[index]),
                                    ),
                                    const Spacer(),
                                    Text(
                                      models[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.02,
                                        fontWeight: FontWeight.w500,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
