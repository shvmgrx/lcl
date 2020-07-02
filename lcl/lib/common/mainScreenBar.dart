import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MainScreenBar extends StatelessWidget {
  final double opacity;

  const MainScreenBar({Key key, this.opacity = 0.8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.red,
            ),
            Spacer(),
            GestureDetector(
              child: Icon(
                Icons.message,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/chatList_screen");
              },
            ),
          ],
        ),
      ),
    );
  }
}
