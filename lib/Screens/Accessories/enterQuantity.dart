// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterQuantity extends StatefulWidget {
  const EnterQuantity({super.key});

  @override
  State<EnterQuantity> createState() => _EnterQuantityState();
}

class _EnterQuantityState extends State<EnterQuantity> {
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
    });
  }

  Map<String, TextEditingController> createTextEditingControllers() {
    Map<String, TextEditingController> result = {};
    enterQuantity.forEach((itemName, _) {
      result[itemName] = TextEditingController();
    });
    return result;
  }

  Future<String> getItemPrice(itemName) async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString(itemName) ?? "";

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Future<String> itemPrice = getItemPrice(itemName);
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
                        Text("$itemPrice"),
                        const Spacer(),
                        SizedBox(
                          width: screenWidth * 0.3,
                          child: TextFormField(
                            controller: controllers[itemName],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Enter Quantity",
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
              await calculatePreferences();
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  Future<void> calculatePreferences() async {
    var total;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    controllers.forEach(
      (itemName, controller) {
        total = int.parse(controller.text) *
            int.parse(prefs.getString(itemName) ?? "0");
      },
    );
  }
}
