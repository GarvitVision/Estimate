// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/Accessories/description.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterQuantity extends StatefulWidget {
  final String modelCode;
  const EnterQuantity({
    Key? key,
    required this.modelCode,
  }) : super(key: key);

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

  Future getItemPrice(itemName) async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString("${widget.modelCode}$itemName") ?? "";
    return value;
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
                            Text("$index. "),
                            Text(
                              itemName,
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.1,
                            ),
                            FutureBuilder(
                              future: getItemPrice(itemName),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  String itemPrice = snapshot.data!;

                                  return Text(
                                    "$itemPrice₹ MRP",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
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
                  await storeValuesInSharedPreferences();
                  onTapEnterLessPercentage();
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
        prefs.setString("Quantity$itemName", controller.text);
      },
    );
  }

  onTapEnterLessPercentage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text("Enter overall less %"),
          actions: [
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return TextFormField(
                        controller: lessPercent,
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1),
                          contentPadding: EdgeInsets.all(screenHeight * 0.01),
                          hintText: "Enter % value",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(221, 221, 221, 1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemsDescription(
                                  lessPercentage: lessPercent.text),
                            ),
                          );
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
