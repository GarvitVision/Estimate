// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/Accessories/selectModelAccess.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterQuantity extends StatefulWidget {
  const EnterQuantity({
    super.key,
  });

  @override
  State<EnterQuantity> createState() => _EnterQuantityState();
}

class _EnterQuantityState extends State<EnterQuantity> {
  late Map<String, TextEditingController> controllers;
  late TextEditingController lessPercent;
  @override
  void initState() {
    super.initState();
    controllers = createTextEditingControllers();
    lessPercent = TextEditingController();
  }

  Map<String, TextEditingController> createTextEditingControllers() {
    Map<String, TextEditingController> result = {};
    enterQuantity.forEach((itemName, _) {
      result[itemName] = TextEditingController();
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(247, 244, 248, 1),
          appBar: AppBar(
            title: const Row(
              children: [
                Text(
                  "Enter Quantity",
                ),
                Spacer(),
              ],
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: enterQuantity.length,
                  itemBuilder: (context, index) {
                    String itemName = enterQuantity.keys.elementAt(index);
                    return Card(
                      margin: EdgeInsets.all(screenHeight * 0.015),
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(screenHeight * 0.01),
                        child: Row(
                          children: [
                            Text(
                              "${index + 1}. ",
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              itemName,
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: screenWidth * 0.3,
                              child: TextFormField(
                                controller: controllers[itemName],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Enter Quantity",
                                  hintStyle: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                  ),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightColoredText,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  await storeValuesInSharedPreferences();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectModelAccess(),
                    ),
                  );
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> storeValuesInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    controllers.forEach(
      (itemName, controller) {
        prefs.setString("Quantity$itemName", controller.text);
      },
    );
  }
}
