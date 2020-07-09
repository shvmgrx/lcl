import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcl/common/customAppBar.dart';
import 'package:lcl/ui_elements/settingsContainer.dart';
// import 'package:lcl/common/subscription_container.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';

import 'dashboard_screen.dart';

class InitialSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomAppBar(),
               
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: SettingsContainer(
                    text: Strings.AGE_PREFERENCE,
                    imagePath: "assets/ageGroup.jpg",
                  ),
                ),
                 SettingsContainer(
                  text: Strings.DISTANCE_PREFERENCE,
                  imagePath: "assets/locationGroup.jpg",
                ),
                 SettingsContainer(
                  text: Strings.LANGUAGES,
                  imagePath: "assets/languageGroup.jpg",
                ),
                 SettingsContainer(
                  text: Strings.MODE_PREFERENCE,
                  imagePath: "assets/modeChoose.png",
                ),

                Padding(
                  padding: const EdgeInsets.only(left:18.0,top:30),
                  child: FlatButton(
                  color: uniColors.backgroundGrey,
                 
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset("assets/donateNew.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.online),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(Strings.DONATE,style: TextStyles.donationTextStyle,),
                          ),
                        ],
                      ),
                    ),
                 
                  onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DashboardScreen(),
                  //   ),
                  // ),
                  }
              ),
                ),
            
              ],
            ),
            Positioned(
              bottom: 48,
              left: 16,
              child: Text(Strings.LAST_STEP_TO_ENJOY,
                  style: TextStyles.buttonTextStyle),
            ),
            Positioned(
              bottom: -30,
              right: -30,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: uniColors.lcRedLight),
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
        ));
  }
}
