
import 'package:flutter/material.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/screens/initialSettings.dart';
import 'package:lcl/screens/onboardingScreens.dart/stepModel.dart';
import 'package:lcl/utils/uniColors.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<StepModel> list = StepModel.list;
  var _controller = PageController();
  var initialPage = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round();
      });
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          _body(_controller),
          _indicator(),
        ],
      ),
    );
  }

  _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (initialPage > 0)
                _controller.animateToPage(initialPage - 1,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: uniColors.lcRed,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(Icons.arrow_back_ios, color:uniColors.white2),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (initialPage < list.length)
                _controller.animateToPage(list.length,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              index == 4
                  ? _displayText(list[index].text, list[index].textDes)
                  : _displayImage(list[index].id),
           
              index == 4
                  ? _displayImage(list[index].id)
                  : _displayText(list[index].text, list[index].textDes),
              
            ],
          );
        },
      ),
    );
  }

  _indicator() {
    return Container(
        width: 90,
        height: 90,
        margin: EdgeInsets.only(top: 1,bottom:40),
        child: Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Container(
          width: 90,
          height: 90,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
            value: (initialPage + 1) / (list.length + 1),
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            if (initialPage < list.length)
              _controller.animateToPage(initialPage + 1,
                  duration: Duration(microseconds: 500),
                  curve: Curves.easeIn);
          },
          child: InkWell(
             onTap: () {
       if(initialPage==3){
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InitialSettings()),
          (Route<dynamic> route) => false,
        );
       }
      },
                      child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: uniColors.lcRed,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
    ],
        ),
      );
  }

  _displayText(String text, String textDes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:28.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 25,
          fontWeight: FontWeight.w800,
          color: uniColors.lcRed,
          fontFamily: 'Raleway',
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textDes,
              style: TextStyle(
                fontSize: 15,
            fontWeight: FontWeight.w800,
            color: uniColors.standardBlack,
            fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _displayImage(String path) {
    return Image.asset(
      "assets/$path.jpg",
      height: MediaQuery.of(context).size.height * .40,
    );
  }
}