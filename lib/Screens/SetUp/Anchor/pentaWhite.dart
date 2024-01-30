// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PentaWhiteScreen extends StatefulWidget {
  const PentaWhiteScreen({super.key});

  @override
  State<PentaWhiteScreen> createState() => _PentaWhiteScreenState();
}

class _PentaWhiteScreenState extends State<PentaWhiteScreen> {
  @override
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = createTextEditingControllers();
    getPrefValue();
  }

  Future getPrefValue() async {
    var prefs = await SharedPreferences.getInstance();
    controllers.forEach((itemName, controller) {
      String? value = prefs.getString(itemName);
      if (value != null) {
        controller.text = value;
      }
      print("SHARED PREFRENCES VALUE====== $value");
    });
  }

  Map<String, TextEditingController> createTextEditingControllers() {
    Map<String, TextEditingController> result = {};
    pentaWhItems.forEach((itemName, _) {
      result[itemName] = TextEditingController();
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Anchor Penta White",
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pentaWhItems.length,
              itemBuilder: (context, index) {
                String itemName = pentaWhItems.keys.elementAt(index);
                return Card(
                  margin: EdgeInsets.all(screenHeight * 0.015),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.01),
                    child: Row(
                      children: [
                        Text("$index. "),
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
                            decoration: const InputDecoration(
                              hintText: "Enter MRP",
                              border: UnderlineInputBorder(
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
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  Future<void> storeValuesInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    controllers.forEach(
      (itemName, controller) {
        prefs.setString(itemName, controller.text);
      },
    );
  }
}
