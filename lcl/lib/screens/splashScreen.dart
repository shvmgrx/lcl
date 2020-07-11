import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcl/common/customAppBar.dart';
import 'package:lcl/ui_elements/settingsContainer.dart';
// import 'package:lcl/common/subscription_container.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';

import 'dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
              top:250,
              left:130,
              right:130,
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                                      width: 160.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage("assets/lcGradient.jpg"),),
                                        ),
                                      ),
                                    
            
             //    Center(child: Image(image: AssetImage("assets/lcGradient.jpg"),))
              
                ],
              ),
            ),
            Positioned(
              bottom: 78,
              left: 124,
              right:100,
              child: Text(Strings.APP_NAME,
                  style: TextStyles.appNameTextStyle),
            ),
            
          ],
        ));
  }
}
