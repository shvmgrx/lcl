import 'package:flutter/material.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/widgets/nmBox.dart';

class NMBarButton extends StatelessWidget {
  final bool down;
  final IconData icon;
  final String iconText;
  const NMBarButton({this.down, this.icon,this.iconText});
  @override
  Widget build(BuildContext context) {
    return Container(
     // width: 50,
      height: 55,
      decoration: down ? nMboxInvert : nMbox,
      child: 
      
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(iconText,
            style:TextStyles.drawerNameBarButtonTextStyle
            ),
            Spacer(),
            Icon(
              icon,
              size:30,
              color: down ? fCDD : fCLL,
            ),
          ],
        ),
      ),
    );
  }
}