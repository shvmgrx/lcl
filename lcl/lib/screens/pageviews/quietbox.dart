import 'package:flutter/material.dart';
import 'package:lcl/screens/dashboard_screen.dart';

import 'package:lcl/utils/uniColors.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: uniColors.lcRed,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is where all the contacts are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Search for your friends and family to start calling or chatting with them",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 25),
              FlatButton(
                color: uniColors.lcRed,
                child: Text("START SEARCHING"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}