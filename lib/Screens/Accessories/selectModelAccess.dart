import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Screens/Accessories/description.dart';
import 'package:newapp/Utils/colors.dart';

import '../../Utils/models.dart';

class SelectModelAccess extends StatefulWidget {
  const SelectModelAccess({super.key});

  @override
  State<SelectModelAccess> createState() => _SelectModelAccessState();
}

class _SelectModelAccessState extends State<SelectModelAccess> {
  late TextEditingController lessPercent;
  final _lessKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    lessPercent = TextEditingController();
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
                  "Select Model",
                ),
                Spacer(),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
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
                          onTapEnterLessPercentage(index);
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
                                backgroundImage: AssetImage(modelImages[index]),
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
          ),
        ),
      ),
    );
  }

  onTapEnterLessPercentage(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            "Enter overall less %",
            style: TextStyle(
              fontSize: screenHeight * 0.02,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _lessKey,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Value Required";
                            } else if (num.parse(value) <= 0) {
                              return "Value can't be less than 0";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: lessPercent,
                          decoration: InputDecoration(
                            errorBorder: InputBorder.none,
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color.fromRGBO(245, 245, 245, 1),
                            contentPadding: EdgeInsets.all(screenHeight * 0.01),
                            hintText: "Enter % value",
                            hintStyle: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(128, 128, 128, 1),
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
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          if (_lessKey.currentState!.validate()) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemsDescription(
                                    modelCode: modelsCode[index],
                                    lessPercentage: lessPercent.text),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
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
