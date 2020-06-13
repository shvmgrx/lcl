import 'package:flutter/material.dart';

class uniColors {

  static final Color lcRed = Color(0xFFEC2639);
  static final Color lcRedLight = Color(0xffff5757);
  static final Color standardWhite = Colors.white;
   static final Color standardBlack = Color(0xff58585e);
   

  static final Color backgroundGrey = Colors.grey[200];


  static final Color white1 = Color(0xffD7E1EC);
  static final Color white2 = Color(0xffFFFFFF);

    static final Color transparent =  Colors.transparent;


  // static final Gradient whiteGradient = LinearGradient(
  //     colors: [gold1,white1, gold2],
  //     begin: Alignment.bottomCenter,
  //     end: Alignment.topCenter);
  static final Color offline = Color(0xffFA1304);
  static final Color online = Colors.green;
  static final Color away = Color(0xffa95f39);


  static final Color grey1 = Color(0xff343942);
  static final Color grey2 = Color(0xff878E9A);
  static final Color grey3 = Color(0xff575C66);

  static final Color gold1 = Color(0xffa48c64);
  static final Color gold2 = Color(0xffba9765);
  static final Color gold3 = Color(0xffa48c64);
  static final Color gold4 = Color(0xffc1b59c);


  static final Color gradientColorStart = lcRed;
  static final Color gradientColorEnd = lcRedLight;
    static final Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

}
