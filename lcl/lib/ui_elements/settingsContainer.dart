  

import 'package:flutter/material.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/uniColors.dart';

class SettingsContainer extends StatelessWidget {
  final String amount, text, imagePath;

  const SettingsContainer({
    Key key,
    this.amount,
    this.text,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1),
                BlendMode.srcATop,
              ),
              child: Image.asset(
                imagePath,
                height: height * 0.15,
                width: width*0.95,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          
          Positioned(
           
             top: 95,
            // bottom: 0,
            // left: 10,
            // right: 1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
            //  mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                //  width:width*0.55,
                  decoration: BoxDecoration(
                              borderRadius: 
                              BorderRadius.only(
                                topRight: Radius.circular(10),
                               
                              ),
                              color: uniColors.backgroundGrey.withOpacity(0.95),
                            ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:13.0,right:13,top:5,bottom:5),
                    child: Text(
                      text,
                      style: TextStyles.subscriptionTextStyle,
                    ),
                  ),
                ),
              
                // Text(
                //   "\$$amount",
                //   style: TextStyles.subscriptionAmountTextStyle,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}