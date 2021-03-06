import 'package:flutter/material.dart';
import 'package:lcl/widgets/nmBox.dart';

class NMButton extends StatelessWidget {
  final bool down;
  final IconData icon;
  const NMButton({this.down, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: down ? nMboxInvert : nMbox,
      child: Icon(
        icon,
        size:30,
        color: down ? fCDD : fCLL,
      ),
    );
  }
}