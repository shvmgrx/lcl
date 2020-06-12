import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';

class TextStyles {

  TextStyles._();

  static final TextStyle appNameTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: uniColors.lcRed,
    fontFamily: 'PT',
  );
  static final TextStyle tagLineTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: uniColors.lcRedLight,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle bigHeadingTextStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
    color: uniColors.lcRed,
    fontFamily: 'CaviarDreams',
  );
  static final TextStyle loginPageLogoTextStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
    color: uniColors.lcRed,
    fontFamily: 'CaviarDreams',
  );
  static final TextStyle drawerNameTextStyle = TextStyle(
    letterSpacing: 1.2,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    //color: uniColors.standardBlack,
    fontFamily: 'CaviarDreams',
  );
    static final TextStyle drawerNameBarButtonTextStyle = TextStyle(
    letterSpacing: 4,
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: uniColors.lcRed,
    fontFamily: 'Raleway',
  );
    static final TextStyle mainScreenBio = TextStyle(
    fontSize: 14,
    //fontWeight: FontWeight.w400,
    color: uniColors.grey2,
    fontFamily: 'Raleway',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
    static final TextStyle mainScreenProfileName = TextStyle(
    fontSize: 14,
    //fontWeight: FontWeight.w400,
    color: uniColors.grey2,
    fontFamily: 'Raleway',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

  
      static final TextStyle cookTime = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: uniColors.grey2,
    fontFamily: 'Bebas',
    letterSpacing: 1.5
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
  static final TextStyle profileUserName = TextStyle(
    fontSize: 20,
    //fontWeight: FontWeight.w400,
    color: uniColors.lcRed,
    fontFamily: 'Raleway',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );

    static final TextStyle recipeDetails = TextStyle(
    fontSize: 12,
    //fontWeight: FontWeight.w400,
    color: uniColors.standardBlack,
    fontFamily: 'Raleway',
    // shadows: <Shadow>[
    //   Shadow(
    //     blurRadius: 2.0,
    //     color: UniversalVariables.gold2,
    //   ),
    // ],
  );
    static final TextStyle profileUserDistance = TextStyle(
    fontSize: 14,
    //fontWeight: FontWeight.w400,
    color: uniColors.lcRed,
    fontFamily: 'Raleway',
    shadows: <Shadow>[
      Shadow(
        blurRadius: 2.0,
        color: uniColors.standardWhite,
      ),
    ],
  );
  static final TextStyle bodyTextStyle = TextStyle(
    letterSpacing: 0.8,
    fontSize: 20,
   // fontWeight: FontWeight.w400,
    color: uniColors.standardBlack,
    fontFamily: 'Roboto',
  );
  static final TextStyle buttonTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle subscriptionTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle subscriptionAmountTextStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: 'Ubuntu',
  );
  static final TextStyle body2TextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 1.4,
    fontWeight: FontWeight.w700,
    color: Colors.white.withOpacity(0.5),
    fontFamily: 'Ubuntu',
  );
  static final TextStyle body3TextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.white.withOpacity(0.8),
    height: 1.2,
    fontFamily: 'Ubuntu',
  );
}