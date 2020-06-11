import 'dart:ui';

import 'package:lcl/common/customAppBar.dart';
//import 'package:lcl/screens/initial_settings_screen.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image.asset(
          //   "assets/banner.jpg",
          //   height: height,
          //   fit: BoxFit.fitHeight,
          // ),
          Column(
            children: <Widget>[
              // CustomAppBar(),
              SizedBox(height: screenHeight*0.65),
              
              Padding(
                
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                  left: 32,
                  right: 32,
                ),
                child: RichText(
                  
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: Strings.READY_TO_LUNCHALIZE,
                        style: TextStyles.bigHeadingTextStyle,
                      ),
                      TextSpan(text: "\n"),
                      TextSpan(text: "\n"),
                      TextSpan(
                        text: Strings.LANDING_SUBTEXT,
                        style: TextStyles.bodyTextStyle,
                      ),
                      TextSpan(text: "\n"),
                      

                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -30,
            right: -30,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: uniColors.lcRed,
                ),
                child: Align(
                  alignment: Alignment(-0.4, -0.4),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
