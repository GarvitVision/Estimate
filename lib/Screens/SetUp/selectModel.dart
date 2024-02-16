// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/commonHelper.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/accessories.dart';
import 'package:newapp/Utils/colors.dart';
import 'package:newapp/Utils/models.dart';
import 'package:newapp/Utils/setupStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectModelSetup extends StatefulWidget {
  const SelectModelSetup({super.key});

  @override
  State<SelectModelSetup> createState() => _SelectModelSetupState();
}

class _SelectModelSetupState extends State<SelectModelSetup> {
  late TextEditingController itemController;
  final _addItemKey = GlobalKey<FormState>();
  FocusNode? _itemFocus;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
    _itemFocus = FocusNode();
    doneItemSetup();
  }

  Future getSetupStatus() async {
    await setupStatus();
    var pref = await SharedPreferences.getInstance();
    String value = pref.getString(SETUP_STATUS) ?? "0.0";
    return value;
  }

  Future doneItemSetup() async {
    var pref = await SharedPreferences.getInstance();
    var value = pref.getBool("FIRSTSETUP") ?? true;
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
            body: Stack(
              children: [
                SingleChildScrollView(
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
                              var fraction = snapshot.data ?? 0.0;
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
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1),
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
                                          backgroundColor:
                                              Colors.lightBlue.shade50,
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
                FutureBuilder(
                  future: doneItemSetup(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      bool doneItem = snapshot.data ?? true;
                      return Visibility(
                        visible: doneItem ? true : false,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenWidth * 0.97,
                            height: screenHeight * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: doneItemSetup(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      bool doneItem = snapshot.data ?? true;
                      return Visibility(
                        visible: doneItem ? true : false,
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: screenWidth * 0.93,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: screenHeight * 0.05,
                                    decoration: const BoxDecoration(
                                      color: primaryDarkColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add items to Accessories List",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenHeight * 0.025,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.03,
                                      vertical: screenHeight * 0.04,
                                    ),
                                    child: Form(
                                      key: _addItemKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.8,
                                            child: Text(
                                              "* Note :- This is the starter setup. You need to add all items to this list one by one. You can add them again later.*",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: screenHeight * 0.025,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.02,
                                          ),
                                          Text(
                                            "Enter item name :",
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.025,
                                            ),
                                          ),
                                          TextFormField(
                                            focusNode: _itemFocus,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Field Required";
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: itemController,
                                            decoration: InputDecoration(
                                              hintText: "6A Switch",
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: screenHeight * 0.03,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                  color: darkColoredText,
                                                ),
                                              ),
                                              fillColor: lightColoredText,
                                              filled: true,
                                            ),
                                            onTapOutside: (event) {
                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenHeight * 0.01,
                                              vertical: screenHeight * 0.02,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (_addItemKey
                                                          .currentState!
                                                          .validate()) {
                                                        var item = {
                                                          itemController.text:
                                                              null
                                                        };
                                                        items.addEntries(
                                                            item.entries);
                                                        await saveItems();
                                                        await fetchItems();
                                                        itemController.clear();
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                _itemFocus);
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.all(
                                                        screenHeight * 0.01,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: primaryDarkColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: const Text(
                                                        "Add More",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.1,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      var pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      pref.setBool(
                                                        "FIRSTSETUP",
                                                        false,
                                                      );
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SelectModelSetup(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.all(
                                                        screenHeight * 0.01,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: primaryDarkColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: const Text(
                                                        "Submit All",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
