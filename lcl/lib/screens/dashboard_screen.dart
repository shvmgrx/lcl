import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:lcl/common/mainScreenBar.dart';
import 'package:lcl/enum/userState.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/authMethods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/availableUserDetail.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:lcl/widgets/nmBarButton.dart';
import 'package:lcl/widgets/nmBox.dart';
import 'package:lcl/widgets/nmButton.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  FirebaseRepository _repository = FirebaseRepository();
  final AuthMethods _authMethods = AuthMethods();

  AnimationController controller;
  Animation animation;
  Animation anim;

  List<User> refreshList;

  List<User> filterList;

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

  bool paymentPressed = false;
  bool profilePressed = false;
  bool settingsPressed = false;
  bool category1Pressed = true;
  bool category2Pressed = false;
  bool category3Pressed = false;
  bool category4Pressed = false;

  bool showBottomBar = true;

  bool showRecipePage = false;
  bool showLunchalizePage = true;
  bool showFavsPage = false;

  bool refreshLunchalize = true;

  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('en');

  UserProvider userProvider;

  @override
  void initState() {
    getLocation();
    isVega = false;
    isVege = true;
    isNVege = false;

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser.uid,
        userState: UserState.Online,
      );
    });

    WidgetsBinding.instance.addObserver(this);

    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedInname = loggedUser['name'];
          loggedInUsername = loggedUser['username'];
          loggedInBio = loggedUser['bio'];
          loggedInprofilePhoto = loggedUser['profile_photo'];
          // isVega = loggedUser['isVegan'];
          // isVege = loggedUser['isVegetarian'];
          // isNVege = loggedUser['isNVegetarian'];
        });
      });
    });

    _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchBatch(user).then((List<User> list) {
        setState(() {
          filterList = list;
          // for (var i = 0; i < 1; i++) {
          // if (list[i].isInfluencer == true && list[i].isInfCert == true) {
          // filterList.add(list[i]);
          //}
          // }
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

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    print(controller.value);
    controller.addListener(() {
      setState(() {});
    });

    showLunchalizePageNow();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


    void showRecipePageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = true;
      showLunchalizePage = false;
      showFavsPage = false;
    });
    controller.forward();
  }

  void showLunchalizePageNow() {
   controller.reverse();

    setState(() {
      showRecipePage = false;
      showLunchalizePage = true;
      showFavsPage = false;
    });
    controller.forward();
  }

    void showFavsPageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = false;
      showLunchalizePage = false;
      showFavsPage = true;
    });
    controller.forward();
  }




  Future<Null> refresh() {
    return _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchBatch(user).then((List<User> list) {
        print("objedct");
        setState(() {
          filterList = list;
        });
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
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

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    final AuthMethods authMethods = AuthMethods();

    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        // set userState to offline as the user logs out'
        authMethods.setUserState(
          userId: userProvider.getUser.uid,
          userState: UserState.Offline,
        );

        Navigator.pop(context);
        // move the user to login screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return PickupLayout(
      scaffold: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          elevation: 15,
          child: Container(
            color: uniColors.backgroundGrey,
            child: new ListView(
              children: <Widget>[
                Container(
                  height: screenHeight / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(loggedInprofilePhoto != null
                          ? loggedInprofilePhoto
                          : "https://i.pinimg.com/736x/20/fb/5d/20fb5dc251af2d68822bd0420dcb0a8e.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: loggedInname != null
                        ? GradientText(loggedInname,
                            gradient: LinearGradient(colors: [
                              uniColors.lcRed,
                              uniColors.lcRedLight,
                              uniColors.lcRed,
                            ]),
                            style: TextStyles.drawerNameTextStyle,
                            textAlign: TextAlign.center)
                        : Text(""),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            profilePressed = !profilePressed;
                            if (profilePressed) {
                              Navigator.pushNamed(
                                  context, "/edit_profile_screen");
                            }
                          });
                        },
                        child: NMButton(
                          down: profilePressed,
                          icon: Icons.settings,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            settingsPressed = !settingsPressed;
                            if (settingsPressed) {
                              Navigator.pushNamed(context, "/settings_screen");
                            }
                          });
                        },
                        child: NMButton(
                          down: settingsPressed,
                          icon: Icons.mode_edit,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            paymentPressed = !paymentPressed;
                          });
                        },
                        child: NMButton(
                            down: paymentPressed, icon: Icons.restaurant_menu),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.27,
                ),
                InkWell(
                  onTap: () => signOut(),
                  child: ListTile(
                    title: new Text(
                      "LOGOUT",
                      style: TextStyle(
                          color: uniColors.standardBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    trailing: new Icon(
                      Icons.attach_money,
                      color: uniColors.standardBlack,
                    ),
                  ),
                ),
                ListTile(
                    title: new Text(
                      "Terms of Service",
                      style: TextStyle(
                          color: uniColors.standardBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    trailing: new Icon(
                      Icons.description,
                      color: uniColors.standardBlack,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                    }),

                //  NMBarButton(
                //     down: profilePressed,
                //     icon: Icons.description,
                //     iconText: "Terms and Conditions"),
                //     SizedBox(height: 5,),
                // NMBarButton(
                //     down: profilePressed,
                //     icon: Icons.settings,
                //     iconText: "Donate"),
              ],
            ),
          ),
        ),
        // drawer: Drawer(
        //   elevation: 15,
        //   child: Column(
        //     children: <Widget>[
        //       Container(

        //         height: screenHeight / 3,
        //         width: screenWidth,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage(
        //                loggedInprofilePhoto!=null? loggedInprofilePhoto: "https://i.pinimg.com/736x/20/fb/5d/20fb5dc251af2d68822bd0420dcb0a8e.jpg"),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 3),
        //         child: Row(
        //           children: <Widget>[
        //             Text("Distance"),
        //             Slider(
        //               value: distance.toDouble(),
        //               min: 0.0,
        //               max: 250.0,
        //               activeColor: uniColors.lcRed,
        //               inactiveColor: uniColors.backgroundGrey,
        //               onChanged: (double newValue) {
        //                 setState(() {
        //                   distance = newValue.round();
        //                 });
        //               },
        //             ),
        //             (distance < 250) ? Text("$distance kms") : Text("Global"),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 3),
        //         child: Row(
        //           children: <Widget>[
        //             Text("Time"),
        //             Slider(
        //               value: time.toDouble(),
        //               min: 0.0,
        //               max: 60.0,
        //               activeColor: uniColors.lcRed,
        //               inactiveColor: uniColors.standardWhite,
        //               onChanged: (double newTime) {
        //                 setState(() {
        //                   time = newTime.round();
        //                 });
        //               },
        //             ),
        //             (time < 60) ? Text("$time minutes") : Text("No Limit"),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 3),
        //         child: Row(
        //           children: <Widget>[
        //             Text("Languages:"),
        //             Text(currentLanguages.toString()),
        //             LanguagePickerDropdown(
        //               initialValue: 'en',
        //               itemBuilder: buildDropdownItem,
        //               onValuePicked: (Language language) {
        //                 _selectedDropdownLanguage = language;
        //                 print(_selectedDropdownLanguage.name);
        //                 print(_selectedDropdownLanguage.isoCode);
        //                 setState(() {
        //                   currentLanguages
        //                       .add(_selectedDropdownLanguage.name.toString());
        //                 });
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //       Divider(),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 5),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: <Widget>[
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Buddy mode:"),
        //                     Checkbox(
        //                         value: buddyMode,
        //                         onChanged: (bool newBuddyValue) {
        //                           setState(() {
        //                             buddyMode = newBuddyValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Flirt mode:"),
        //                     Checkbox(
        //                         value: romanticMode,
        //                         onChanged: (bool newRomanticValue) {
        //                           setState(() {
        //                             romanticMode = newRomanticValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Business mode:"),
        //                     Checkbox(
        //                         value: businessMode,
        //                         onChanged: (bool newBusinessValue) {
        //                           setState(() {
        //                             businessMode = newBusinessValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       Divider(),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 5),
        //         child: Row(
        //           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           //crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Vegetarian:"),
        //                     Checkbox(
        //                         value: isVege,
        //                         onChanged: (bool vegetarianValue) {
        //                           setState(() {
        //                             isVege = vegetarianValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Vegan:"),
        //                     Checkbox(
        //                         value: isVega,
        //                         onChanged: (bool veganValue) {
        //                           setState(() {
        //                             isVega = veganValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: <Widget>[
        //                     Text("Non-Vegetarian"),
        //                     Checkbox(
        //                         value: isNVege,
        //                         onChanged: (bool nVegeValue) {
        //                           setState(() {
        //                             isNVege = nVegeValue;
        //                           });
        //                         }),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         color: uniColors.lcRed,
        //         height: screenHeight / 30,
        //         width: screenWidth,
        //         child: FlatButton(
        //           child: Text('SUBMIT'),
        //           onPressed: () {
        //             _repository.getCurrentUser().then((FirebaseUser user) {
        //               _repository.updateDatatoDb(
        //                 user,
        //                 loggedInname,
        //                 loggedInUsername,
        //                 loggedInBio,
        //                 isVega,
        //                 isVege,
        //                 isNVege,
        //                 position.toString(),
        //                 currentLanguages,
        //                 loggedInprofilePhoto,
        //               );
        //             });
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //       Container(
        //         color: uniColors.lcRed,
        //         height: screenHeight / 30,
        //         width: screenWidth,
        //         child: FlatButton(
        //           child: Text('LOGOUT'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: refresh,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: "AvailableUserDetail",
                child: FractionallySizedBox(
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
              ),
              FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    color: uniColors.lcRed,
                  ),
                  child: Opacity(
                    opacity: controller.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 16,
                          ),
                          // child: Text(
                          //   Strings.relatedToYou,
                          //   style: TextStyles.buttonTextStyle,
                          // ),
                        ),

                        Visibility(
                          visible: showLunchalizePage,
                          child: Container(
                            //margin: EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height - 300.0,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.88,
                              primary: false,
                              children: <Widget>[
                                if (refreshLunchalize)
                                  if (filterList != null)
                                    ...filterList.map((e) {
                                      print(filterList);
                                      return buildFilterGrid(e);
                                    }).toList(),
                                // Text("Main screen"),
                                // CupertinoButton(
                                //     child: Text("update data"),
                                //     onPressed: () {
                                //       _repository.getCurrentUser().then((FirebaseUser user) {
                                //         print(user.displayName);
                                //         _repository.updateDatatoDb(
                                //             user, user.displayName, user.displayName, 6);
                                //       });
                                //     }),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: showRecipePage,
                          child: Container(
                              //margin: EdgeInsets.only(top: 20),
                              height:
                                  MediaQuery.of(context).size.height - 300.0,
                              child: Center(child: Text("RecipePage"))),
                        ),
                        Visibility(
                          visible: showFavsPage,
                          child: Container(
                              //margin: EdgeInsets.only(top: 20),
                              height:
                                  MediaQuery.of(context).size.height - 300.0,
                              child: Center(child: Text("FavouritesPage"))),
                        ),

                        // Expanded(
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: Row(
                        //       children: <Widget>[
                        //         Container(
                        //           margin: const EdgeInsets.only(left: 16),
                        //           width: MediaQuery.of(context).size.width * 0.5,
                        //            height: MediaQuery.of(context).size.height *0.3,
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Expanded(
                        //                 child: ClipRRect(
                        //                   child: Image.asset(
                        //                     "assets/man3.jpg",
                        //                     fit: BoxFit.fill,
                        //                     width: MediaQuery.of(context).size.width *0.5,
                        //                    // height: MediaQuery.of(context).size.height *0.2,
                        //                   ),
                        //                   borderRadius: BorderRadius.circular(12),
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.symmetric(vertical: 6),
                        //                 child: Text(
                        //                   Strings.lifeWithATiger,
                        //                   style: TextStyles.titleTextStyle,
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.symmetric(vertical: 6),
                        //                 child: Text(
                        //                   Strings.loremIpsum1,
                        //                   style: TextStyles.body3TextStyle,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Container(
                        //           width: MediaQuery.of(context).size.width * 0.5,
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Expanded(
                        //                 child: ClipRRect(
                        //                   child: Image.asset(
                        //                     "assets/woman1.jpg",
                        //                     width: MediaQuery.of(context).size.width *
                        //                         0.5,
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                   borderRadius: BorderRadius.circular(12),
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.symmetric(vertical: 6),
                        //                 child: Text(
                        //                   Strings.wildAnimals,
                        //                   style: TextStyles.titleTextStyle,
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.symmetric(vertical: 6),
                        //                 child: Text(
                        //                   Strings.loremIpsum2,
                        //                   style: TextStyles.body3TextStyle,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 16,
                        //     vertical: 16,
                        //   ),
                        //   child: Text(
                        //     Strings.quickCategories,
                        //     style: TextStyles.titleTextStyle,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: <Widget>[
                        //       Column(
                        //         children: <Widget>[
                        //           GestureDetector(
                        //             onTap: () {
                        //               getLocation();
                        //               _scaffoldKey.currentState.openDrawer();
                        //               // showDialog(
                        //               //   context: context,
                        //               //   barrierDismissible:
                        //               //       false, // user must tap button!
                        //               //   builder: (BuildContext context) {
                        //               //     return AlertDialog(
                        //               //       title: Center(child: Text('Distance')),
                        //               //       elevation: 2.5,
                        //               //       backgroundColor:
                        //               //           Colors.white.withOpacity(0.8),
                        //               //       shape: RoundedRectangleBorder(
                        //               //           borderRadius: BorderRadius.only(
                        //               //         topRight: Radius.circular(20),
                        //               //         topLeft: Radius.circular(20),
                        //               //         bottomLeft: Radius.circular(10),
                        //               //         bottomRight: Radius.circular(10),
                        //               //       )),
                        //               //       content: SingleChildScrollView(
                        //               //         child: ListBody(
                        //               //           children: <Widget>[
                        //               //             Text("$distance"),
                        //               //             Slider(
                        //               //               value: distance.toDouble(),
                        //               //               min: 0.0,
                        //               //               max: 220.0,
                        //               //               activeColor: uniColors.lcRed,
                        //               //               inactiveColor:
                        //               //                   uniColors.standardWhite,
                        //               //               onChanged: (double newValue) {
                        //               //                 setState(() {
                        //               //                   distance = newValue.round();
                        //               //                 });
                        //               //               },
                        //               //             ),
                        //               //           ],
                        //               //         ),
                        //               //       ),
                        //               //       actions: <Widget>[
                        //               //         Row(
                        //               //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               //           children: <Widget>[
                        //               //             FlatButton(
                        //               //               child: Text('CANCEL'),
                        //               //               onPressed: () {
                        //               //                 Navigator.of(context).pop();
                        //               //               },
                        //               //             ),
                        //               //             FlatButton(
                        //               //               child: Text('SUBMIT'),
                        //               //               onPressed: () {
                        //               //                 Navigator.of(context).pop();
                        //               //               },
                        //               //             ),
                        //               //           ],
                        //               //         ),
                        //               //       ],
                        //               //     );
                        //               //   },
                        //               // );
                        //             },
                        //             child: Container(
                        //               padding: const EdgeInsets.all(12),
                        //               decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(8),
                        //                   color: Colors.white),
                        //               // child: Image.asset(
                        //               //   "assets/city1.png",
                        //               //   height: 50,
                        //               //   width: 50,
                        //               // ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 4,
                        //           ),
                        //           Text(
                        //             Strings.location,
                        //             style: TextStyles.body2TextStyle,
                        //           ),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: <Widget>[
                        //           Container(
                        //             padding: const EdgeInsets.all(12),
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(8),
                        //                 color: Colors.white),
                        //             // child: Image.asset(
                        //             //   "assets/time2.png",
                        //             //   height: 50,
                        //             //   width: 50,
                        //             // ),
                        //           ),
                        //           SizedBox(
                        //             height: 4,
                        //           ),
                        //           Text(
                        //             Strings.lion,
                        //             style: TextStyles.body2TextStyle,
                        //           ),
                        //         ],
                        //       ),
                        //       // Column(
                        //       //   children: <Widget>[
                        //       //     Container(
                        //       //       padding: const EdgeInsets.all(12),
                        //       //       decoration: BoxDecoration(
                        //       //         borderRadius: BorderRadius.circular(8),
                        //       //         color: Colors.white
                        //       //       ),
                        //       //       child: Image.asset(
                        //       //         "assets/meal2.png",
                        //       //         height: 50,
                        //       //         width: 50,
                        //       //       ),
                        //       //     ),
                        //       //     SizedBox(
                        //       //       height: 4,
                        //       //     ),
                        //       //     Text(
                        //       //       Strings.reptiles,
                        //       //       style: TextStyles.body2TextStyle,
                        //       //     ),
                        //       //   ],
                        //       // ),
                        //       Column(
                        //         children: <Widget>[
                        //           Container(
                        //             padding: const EdgeInsets.all(12),
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(8),
                        //                 color: Colors.white),
                        //             // child: Image.asset(
                        //             //   "assets/mode.png",
                        //             //   height: 50,
                        //             //   width: 50,
                        //             // ),
                        //           ),
                        //           SizedBox(
                        //             height: 4,
                        //           ),
                        //           Text(
                        //             Strings.pets,
                        //             style: TextStyles.body2TextStyle,
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 32,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: Visibility(
        //     visible: showBottomBar,
        //     child: FloatingActionButton(
        //       elevation: 6,
        //       onPressed: () {
        //        refresh();
        //       },
        //       backgroundColor: uniColors.standardWhite ,
        //       child: Icon(
        //        Icons.restaurant_menu,
        //         size: 30,
        //         color: uniColors.lcRed
        //       ),
        //     ),
        //   ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: uniColors.standardWhite,
          elevation: 2.0,
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.0,
          child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: uniColors.lcRed, size: 35),
                  onPressed: () {
                    // setState(() {
                    //   showRecipePage = true;
                    //   showLunchalizePage = false;
                    //   showFavsPage = false;
                    // });
                    showRecipePageNow();

                    print('Star it');
                  },
                ),
                IconButton(
                  icon:
                      Icon(Icons.restaurant, color: uniColors.lcRed, size: 35),
                  onPressed: () {
                    refresh();
                    // setState(() {
                    //   showRecipePage = false;
                    //   showLunchalizePage = true;
                    //   showFavsPage = false;
                    // });
                    showLunchalizePageNow();

                    print('Star it');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: uniColors.lcRed, size: 35),
                  onPressed: () {
                    // setState(() {
                    //   showRecipePage = false;
                    //   showLunchalizePage = false;
                    //   showFavsPage = true;
                    // });
                    showFavsPageNow();

                    print('Star it');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildFilterGrid(User availableUsers) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                AvailableUserDetail(selectedAvailableUser: availableUsers)));
      },
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Stack(
          children: <Widget>[
            Container(
                //height: 250,
                // width: screenWidth / 1.75,
                color: uniColors.transparent),
            Positioned(
              left: 1.0,
              top: 5.0,
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: screenWidth / 2.4,
                  width: screenWidth / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${availableUsers.profilePhoto}"),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 1.0,
                top: 155.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: screenWidth / 2.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          color: uniColors.white2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.close,
                              color: uniColors.lcRed,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(availableUsers.name,
                                    style: TextStyles.mainScreenProfileName,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.favorite,
                              color: uniColors.lcRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
