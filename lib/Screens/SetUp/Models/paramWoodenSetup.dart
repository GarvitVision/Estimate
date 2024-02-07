// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/commonHelper.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:newapp/Utils/models.dart';
import 'package:newapp/Utils/setupStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParamWoodenSetup extends StatefulWidget {
  const ParamWoodenSetup({super.key});

  @override
  State<ParamWoodenSetup> createState() => _ParamWoodenSetupState();
}

class _ParamWoodenSetupState extends State<ParamWoodenSetup> {
  late Map<String, GlobalKey<FormState>> _formKeys;
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = createTextEditingControllers();
    _formKeys = createGlobalKeys();
    getPrefValue();
  }

  Future getPrefValue() async {
    var prefs = await SharedPreferences.getInstance();
    controllers.forEach((itemName, controller) {
      String? value = prefs.getString("paramWooden$itemName");
      if (value != null) {
        controller.text = value;
      }
      print("SHARED PREFRENCES VALUE====== $value");
    });
  }

  Map<String, TextEditingController> createTextEditingControllers() {
    Map<String, TextEditingController> result = {};
    paramWoodenItems.forEach((itemName, _) {
      result[itemName] = TextEditingController();
    });
    return result;
  }

  Map<String, GlobalKey<FormState>> createGlobalKeys() {
    Map<String, GlobalKey<FormState>> result = {};
    paramWoodenItems.forEach((itemName, _) {
      result[itemName] = GlobalKey<FormState>();
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: Scaffold(
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
                  itemCount: paramWoodenItems.length,
                  itemBuilder: (context, index) {
                    String itemName = paramWoodenItems.keys.elementAt(index);
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
                            Form(
                              key: _formKeys[itemName],
                              child: SizedBox(
                                width: screenWidth * 0.3,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field Required";
                                    } else {
                                      return null;
                                    }
                                  },
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
                  if (_formKeys.values
                      .every((element) => element.currentState!.validate())) {
                    var pref = await SharedPreferences.getInstance();
                    pref.setString(modelPrefs[CommonHelper.index], "Done");
                    await setupStatus();
                    await storeValuesInSharedPreferences();
                    Navigator.pop(context);
                  }
                },
                child: const Text("Submit"),
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
        prefs.setString("paramWooden$itemName", controller.text);
      },
    );
  }
}
