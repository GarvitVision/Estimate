import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsDescription extends StatefulWidget {
  final String lessPercentage;
  const ItemsDescription({
    Key? key,
    required this.lessPercentage,
  }) : super(key: key);

  @override
  State<ItemsDescription> createState() => Items_DescriptionState();
}

class Items_DescriptionState extends State<ItemsDescription> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = createTextEditingControllers();
    getPrefValue();
  }

  Map<String, TextEditingController> createTextEditingControllers() {
    Map<String, TextEditingController> result = {};
    enterQuantity.forEach((itemName, _) {
      result[itemName] = TextEditingController();
    });
    return result;
  }

  Future getPrefValue() async {
    var prefs = await SharedPreferences.getInstance();

    controllers.forEach((itemName, controller) {
      String? value = prefs.getString(itemName);
      if (value != null) {
        controller.text = (num.parse(value) -
                (num.parse(value) * (num.parse(widget.lessPercentage) / 100)))
            .toStringAsFixed(2)
            .toString();
      }
      print("SHARED PREFRENCES VALUE====== ${controller.text}");
    });
  }

  List itemsAfterLess = [];
  List itemsMRP = [];
  Future getItemPrice(itemName) async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString(itemName) ?? "";
    return value;
  }

  num calculateDiscountedPrice(
      num originalPrice, num discountPercentage, num quantity) {
    return (originalPrice - (originalPrice * (discountPercentage / 100))) *
        quantity;
  }

  Future getItemQuantity(itemName) async {
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString("Quantity$itemName") ?? "";
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryDarkColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text(
                  "Item Description",
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    var total = itemsAfterLess.isEmpty
                        ? 0
                        : itemsAfterLess.reduce((sum, num) => sum + num);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenHeight * 0.02),
                              child: Text(
                                "Estimate",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.05,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.04,
                                horizontal: screenHeight * 0.02,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Total Estimate :",
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.03),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "$total",
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.03),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Get Estimate"),
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05,
              horizontal: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                Text(
                  "List Description",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                        screenHeight * 0.01,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: enterQuantity.length,
                        itemBuilder: (context, index) {
                          itemsAfterLess.clear();
                          itemsMRP.clear();
                          String itemName = enterQuantity.keys.elementAt(index);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}. $itemName",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    itemsMRP.add(num.parse(itemPrice));
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
                              FutureBuilder(
                                future: getItemQuantity(itemName),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    num itemQuantity =
                                        num.parse(snapshot.data!);
                                    return IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.1,
                                            child: TextFormField(
                                              onEditingComplete: () {
                                                setState(() {});
                                              },
                                              scrollPadding:
                                                  const EdgeInsets.all(0),
                                              expands: false,
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              selectionHeightStyle:
                                                  BoxHeightStyle.tight,
                                              controller: controllers[itemName],
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                border: InputBorder.none,
                                                hintMaxLines: 1,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "* ${itemQuantity.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.02,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: Future.wait([
                                  getItemPrice(itemName),
                                  getItemQuantity(itemName),
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    num itemPrice =
                                        num.parse(controllers[itemName]!.text);
                                    num itemQuantity =
                                        num.parse(snapshot.data![1]);
                                    itemsAfterLess
                                        .add(itemPrice * itemQuantity);
                                    return Text(
                                      "${(num.parse(controllers[itemName]!.text) * itemQuantity).toStringAsFixed(2)} ₹",
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
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
