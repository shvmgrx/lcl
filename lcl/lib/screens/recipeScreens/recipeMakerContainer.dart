import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';

class RecipeMakerContainer extends StatefulWidget {
  @override
  _RecipeMakerContainerState createState() => _RecipeMakerContainerState();
}

class _RecipeMakerContainerState extends State<RecipeMakerContainer> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
      
          height: screenHeight * 0.84,
       
        
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                         //  height:screenHeight*3,
                          //    width:screenWidth*3,
                          child: Center(
                            child: Text("recipe maker1"),
                          ),
                        ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
               
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                    //     height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                       //  height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                       //  height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                      //   height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                      //   height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                      //   height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                       Container(
                     //    height:screenHeight*3,
                        //    width:screenWidth*3,
                        child: Center(
                          child: Text("recipe maker1"),
                        ),
                      ),
                      
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
