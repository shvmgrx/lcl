import 'package:lcl/common/customAppBar.dart';
// import 'package:lcl/common/subscription_container.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';

class InitialSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Text(Strings.chooseAPlan, style: TextStyles.headingTextStyle,),
              ),
              // SubscriptionContainer(
              //   text: Strings.weekSubscription,

              //   imagePath: "assets/city.jpg",
              // ),
              // SubscriptionContainer(
              //   text: Strings.oneMonthSubscription,

              //   imagePath: "assets/time.jpg",
              // ),
              // SubscriptionContainer(
              //   text: Strings.threeMonthSubscription,

              //   imagePath: "assets/languages.jpg",
              // ),
              // SubscriptionContainer(
              //   text: Strings.sixMonthSubscription,

              //   imagePath: "assets/mode.jpg",
              // ),
            ],
          ),
          Positioned(
            bottom: 48,
            left: 16,
            child: Text(
                Strings.LAST_STEP_TO_ENJOY,
                style: TextStyles.buttonTextStyle
            ),
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
                  shape: BoxShape.circle,
                  color: Color(0xFFEC2639).withOpacity(0.8),
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
      )
    );
  }
}
