
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newapp/CommonHelpers/getScreenSize.dart';
import 'package:newapp/Utils/models.dart';

class SelectModelSetup extends StatelessWidget {
  const SelectModelSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 244, 248, 1),
      appBar: AppBar(
        title: const Text(
          "Select Model",
        ),
      ),
      body:  Container(
        color: Color.fromRGBO(247, 244, 248, 1),
        width: screenWidth ,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.035,
        ),
        child: Wrap(
          runSpacing: screenHeight * 0.01,
          alignment: WrapAlignment.center,
          spacing: screenWidth*0.01,
          children: [
            for(var index=0 ; index<models.length; index ++)
              SizedBox(
                width: screenWidth * 0.3,
                height: screenWidth * 0.36,
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
                          fontSize: screenHeight*0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
