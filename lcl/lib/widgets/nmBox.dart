import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';


Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCD = uniColors.grey2.withOpacity(0.075);
Color mmCD = uniColors.gold4.withOpacity(0.7);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = uniColors.gold1;
Color fCL = uniColors.gold2;
Color fCDD = uniColors.lcRed;
// Color fCLL = UniversalVariables.gold4.withOpacity(0.7);
Color fCLL = uniColors.lcRedLight;

// Color mC = Colors.grey.shade100;
// Color mCL = Colors.white;
// Color mCD = Colors.black.withOpacity(0.075);
// Color mCC = Colors.green.withOpacity(0.65);
// Color fCD = Colors.grey.shade700;
// Color fCL = Colors.grey;


BoxDecoration nMbox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: mC,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    BoxShadow(
      color: mCL,
      offset: Offset(-10, -10),
      blurRadius: 10,
    ),
  ]
);
BoxDecoration priceSendBox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: fCLL,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    BoxShadow(
      color: mCL,
      offset: Offset(-10, -10),
      blurRadius: 10,
    ),
  ]
);


BoxDecoration buttonPressed = BoxDecoration(

  
  // boxShadow: [
  //   BoxShadow(
  //     color: mCD,
  //     offset: Offset(10, 10),
  //     blurRadius: 10,
  //   ),
  //   BoxShadow(
  //     color: mCL,
  //     offset: Offset(-10, -10),
  //     blurRadius: 10,
  //   ),
  // ]
);

BoxDecoration nMboxInvert = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: mCD,
  boxShadow: [
    BoxShadow(
      color: mCL,
      offset: Offset(3, 3),
      blurRadius: 3,
      spreadRadius: -3
    ),
  ]
);

BoxDecoration categoryInvert = BoxDecoration(
  borderRadius: BorderRadius.circular(100),
  color: mmCD,
  boxShadow: [
    BoxShadow(
      color: mCL,
      offset: Offset(3, 3),
      blurRadius: 3,
      spreadRadius: -3
    ),
  ]
);

BoxDecoration buttonNotPressed = BoxDecoration(

  // boxShadow: [
  //   BoxShadow(
  //     color: mCL,
  //     offset: Offset(3, 3),
  //     blurRadius: 3,
  //     spreadRadius: -3
  //   ),
  // ]
);


BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: mCC);

BoxDecoration nMbtn = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: mC,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(2, 2),
      blurRadius: 2,
    )
  ]
);