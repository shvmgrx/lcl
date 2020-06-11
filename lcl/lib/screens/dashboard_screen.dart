import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lcl/common/mainScreenBar.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language_pickers.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FirebaseRepository _repository = FirebaseRepository();

  String loggedInname;
  String loggedInprofilePhoto;
  String loggedInUsername;
  String loggedInBio;

  int distance;
  int time;
  List<String> currentLanguages = new List();
  Position position;
  bool buddyMode;
  bool romanticMode;
  bool businessMode;
  bool isVega;
  bool isVege;
  bool isNVege;

  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('en');

  @override
  void initState() {
    getLocation();
    isVega=false;
    isVege=true;
    isNVege=false;
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedInname = loggedUser['name'];
          loggedInUsername = loggedUser['username'];
          loggedInBio = loggedUser['bio'];
          loggedInprofilePhoto = loggedUser['photoUrl'];
          // isVega = loggedUser['isVegan'];
          // isVege = loggedUser['isVegetarian'];
          // isNVege = loggedUser['isNVegetarian'];
        });
      });
    });

    // TODO: implement initState
    super.initState();
    distance = 5;
    time = 0;
    buddyMode = true;
    romanticMode = false;
    businessMode = false;
    
  }

  // Widget buildDropdownItem(Language language) {
  //   return Row(
  //     children: <Widget>[
  //       SizedBox(
  //         width: 8.0,
  //       ),
  //       Text("${language.name}"),
  //     ],
  //   );
  // }

  Widget buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name}"),
      ],
    );
  }

  void getLocation() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 15,
        child: Column(
          children: <Widget>[
            Container(
             
              height: screenHeight / 3,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                     loggedInprofilePhoto!=null? loggedInprofilePhoto: "https://i.pinimg.com/736x/20/fb/5d/20fb5dc251af2d68822bd0420dcb0a8e.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: <Widget>[
                  Text("Distance"),
                  Slider(
                    value: distance.toDouble(),
                    min: 0.0,
                    max: 250.0,
                    activeColor: uniColors.lcRed,
                    inactiveColor: uniColors.backgroundGrey,
                    onChanged: (double newValue) {
                      setState(() {
                        distance = newValue.round();
                      });
                    },
                  ),
                  (distance < 250) ? Text("$distance kms") : Text("Global"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: <Widget>[
                  Text("Time"),
                  Slider(
                    value: time.toDouble(),
                    min: 0.0,
                    max: 60.0,
                    activeColor: uniColors.lcRed,
                    inactiveColor: uniColors.standardWhite,
                    onChanged: (double newTime) {
                      setState(() {
                        time = newTime.round();
                      });
                    },
                  ),
                  (time < 60) ? Text("$time minutes") : Text("No Limit"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: <Widget>[
                  Text("Languages:"),
                  Text(currentLanguages.toString()),
                  LanguagePickerDropdown(
                    initialValue: 'en',
                    itemBuilder: buildDropdownItem,
                    onValuePicked: (Language language) {
                      _selectedDropdownLanguage = language;
                      print(_selectedDropdownLanguage.name);
                      print(_selectedDropdownLanguage.isoCode);
                      setState(() {
                        currentLanguages
                            .add(_selectedDropdownLanguage.name.toString());
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Buddy mode:"),
                          Checkbox(
                              value: buddyMode,
                              onChanged: (bool newBuddyValue) {
                                setState(() {
                                  buddyMode = newBuddyValue;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Flirt mode:"),
                          Checkbox(
                              value: romanticMode,
                              onChanged: (bool newRomanticValue) {
                                setState(() {
                                  romanticMode = newRomanticValue;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Business mode:"),
                          Checkbox(
                              value: businessMode,
                              onChanged: (bool newBusinessValue) {
                                setState(() {
                                  businessMode = newBusinessValue;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Vegetarian:"),
                          Checkbox(
                              value: isVege,
                              onChanged: (bool vegetarianValue) {
                                setState(() {
                                  isVege = vegetarianValue;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Vegan:"),
                          Checkbox(
                              value: isVega,
                              onChanged: (bool veganValue) {
                                setState(() {
                                  isVega = veganValue;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Non-Vegetarian"),
                          Checkbox(
                              value: isNVege,
                              onChanged: (bool nVegeValue) {
                                setState(() {
                                  isNVege = nVegeValue;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: uniColors.lcRed,
              height: screenHeight / 30,
              width: screenWidth,
              child: FlatButton(
                child: Text('SUBMIT'),
                onPressed: () {
                  _repository.getCurrentUser().then((FirebaseUser user) {
                    _repository.updateDatatoDb(
                      user,
                      loggedInname,
                      loggedInUsername,
                      loggedInBio,
                      isVega,
                      isVege,
                      isNVege,
                      position.toString(),
                      currentLanguages,
                      loggedInprofilePhoto,
                    );
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: uniColors.lcRed,
              height: screenHeight / 30,
              width: screenWidth,
              child: FlatButton(
                child: Text('LOGOUT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.40,
            child: Container(
              child: Stack(
                children: <Widget>[
                  //Image.asset(
                  // "assets/banner2.jpg",
                  //  width: MediaQuery.of(context).size.width,
                  //  height: 500,
                  //  fit: BoxFit.fitWidth,
                  // ),
                  Column(
                    children: <Widget>[
                      MainScreenBar(
                        opacity: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Text(
                          Strings.APP_NAME,
                          style: TextStyles.appNameTextStyle,
                        ),
                      ),
                      // Expanded(
                      //  child: Align(
                      //   alignment: Alignment(0, -0.6),
                      //child: Text(
                      // Strings.welcomeToAPlanet,
                      //  style: TextStyles.bigHeadingTextStyle,
                      //   textAlign: TextAlign.center,
                      //  ),
                      //  ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.85,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                color: Color(0xFFEC2639),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 16,
                    ),
                    child: Text(
                      Strings.relatedToYou,
                      style: TextStyles.buttonTextStyle,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "assets/man3.jpg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    Strings.lifeWithATiger,
                                    style: TextStyles.titleTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    Strings.loremIpsum1,
                                    style: TextStyles.body3TextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "assets/woman1.jpg",
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    Strings.wildAnimals,
                                    style: TextStyles.titleTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    Strings.loremIpsum2,
                                    style: TextStyles.body3TextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Text(
                      Strings.quickCategories,
                      style: TextStyles.titleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                getLocation();
                                _scaffoldKey.currentState.openDrawer();
                                // showDialog(
                                //   context: context,
                                //   barrierDismissible:
                                //       false, // user must tap button!
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: Center(child: Text('Distance')),
                                //       elevation: 2.5,
                                //       backgroundColor:
                                //           Colors.white.withOpacity(0.8),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.only(
                                //         topRight: Radius.circular(20),
                                //         topLeft: Radius.circular(20),
                                //         bottomLeft: Radius.circular(10),
                                //         bottomRight: Radius.circular(10),
                                //       )),
                                //       content: SingleChildScrollView(
                                //         child: ListBody(
                                //           children: <Widget>[
                                //             Text("$distance"),
                                //             Slider(
                                //               value: distance.toDouble(),
                                //               min: 0.0,
                                //               max: 220.0,
                                //               activeColor: uniColors.lcRed,
                                //               inactiveColor:
                                //                   uniColors.standardWhite,
                                //               onChanged: (double newValue) {
                                //                 setState(() {
                                //                   distance = newValue.round();
                                //                 });
                                //               },
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       actions: <Widget>[
                                //         Row(
                                //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: <Widget>[
                                //             FlatButton(
                                //               child: Text('CANCEL'),
                                //               onPressed: () {
                                //                 Navigator.of(context).pop();
                                //               },
                                //             ),
                                //             FlatButton(
                                //               child: Text('SUBMIT'),
                                //               onPressed: () {
                                //                 Navigator.of(context).pop();
                                //               },
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Image.asset(
                                  "assets/city1.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.location,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Image.asset(
                                "assets/time2.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.lion,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        // Column(
                        //   children: <Widget>[
                        //     Container(
                        //       padding: const EdgeInsets.all(12),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         color: Colors.white
                        //       ),
                        //       child: Image.asset(
                        //         "assets/meal2.png",
                        //         height: 50,
                        //         width: 50,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 4,
                        //     ),
                        //     Text(
                        //       Strings.reptiles,
                        //       style: TextStyles.body2TextStyle,
                        //     ),
                        //   ],
                        // ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Image.asset(
                                "assets/mode.png",
                                height: 50,
                                width: 50,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.pets,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
