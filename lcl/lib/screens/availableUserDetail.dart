import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:lcl/common/mainScreenBar.dart';
import 'package:lcl/enum/userState.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/authMethods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/chatScreens/chatScreen.dart';
import 'package:lcl/screens/dashboard_screen.dart';
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

class AvailableUserDetail extends StatefulWidget {
  final User selectedAvailableUser;
  AvailableUserDetail({this.selectedAvailableUser});

  @override
  _AvailableUserDetailState createState() => _AvailableUserDetailState();
}

class _AvailableUserDetailState extends State<AvailableUserDetail>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  FirebaseRepository _repository = FirebaseRepository();

  AnimationController controller;

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

  bool refreshLunchalize = true;

  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('en');

  @override
  void initState() {
    getLocation();
    isVega = false;
    isVege = true;
    isNVege = false;

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

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
  }

  Future<Null> refresh() {
    return _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchBatch(user).then((List<User> list) {
        setState(() {
          filterList = list;
        });
      });
    });
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
                GestureDetector(
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
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: refresh,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                width: screenWidth,
                top: 50,
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            //    Navigator.pushNamed(context, "/dashboard_screen");

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            Strings.APP_NAME,
                            style: TextStyles.appNameTextStyle,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.message,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/chatList_screen");
                          },
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
                    color: uniColors.lcRed.withOpacity(controller.value),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(children: <Widget>[
                                    Container(
                                      height: 350.0,
                                      width: 350.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                          bottomLeft: Radius.circular(25.0),
                                          bottomRight: Radius.circular(25.0),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${widget.selectedAvailableUser.profilePhoto}"),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      bottom: 10,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            FloatingActionRow(
                                              color: uniColors.lcRed,
                                              children: <Widget>[
                                                FloatingActionRowButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: uniColors.white2,
                                                      size: 25,
                                                    ),
                                                    onTap: () {}),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      bottom: 10,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            FloatingActionRow(
                                              color: uniColors.online,
                                              children: <Widget>[
                                                FloatingActionRowButton(
                                                    icon: Icon(
                                                      Icons.done,
                                                      color: uniColors.white2,
                                                      size: 25,
                                                    ),
                                                    onTap: () {}),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 350.0,
                                    width: 350.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                        bottomLeft: Radius.circular(25.0),
                                        bottomRight: Radius.circular(25.0),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${widget.selectedAvailableUser.profilePhoto}"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 350.0,
                                    width: 350.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                        bottomLeft: Radius.circular(25.0),
                                        bottomRight: Radius.circular(25.0),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${widget.selectedAvailableUser.profilePhoto}"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: controller.value,
                          child: Container(
                            // height: 150.0,
                            // width: screenWidth*0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0),
                              ),
                              color: uniColors.standardWhite,
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 10),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                      receiver: widget
                                                          .selectedAvailableUser,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    " ${widget.selectedAvailableUser.name}, ${widget.selectedAvailableUser.age}",
                                                    style: TextStyles
                                                        .profileUserName,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 3.0),
                                                    child: Text(
                                                      "(45 kms)",
                                                      style: TextStyles
                                                          .profileUserDistance,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 10),
                                              child: Text(
                                                widget
                                                    .selectedAvailableUser.bio,
                                                style: TextStyles.mainScreenBio,
                                                // textAlign: TextAlign.left
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2.0),
                                                    child: Chip(
                                                      backgroundColor:
                                                          uniColors.lcRedLight,
                                                      label: Text('Keto',
                                                          style: TextStyles
                                                              .chipStyle),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2.0),
                                                    child: Chip(
                                                      backgroundColor:
                                                          uniColors.lcRedLight,
                                                      label: Text('Gourmet',
                                                          style: TextStyles
                                                              .chipStyle),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2.0),
                                                    child: Chip(
                                                      backgroundColor:
                                                          uniColors.lcRedLight,
                                                      label: Text('Healthy',
                                                          style: TextStyles
                                                              .chipStyle),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    //   Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: uniColors.lcRed,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                            bottomLeft: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chat,
                                                    color: uniColors.white2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text("CHAT",
                                                        style: TextStyles
                                                            .chatBubble),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10, top: 10),
                                  child: Container(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: screenWidth,
                                          height: screenHeight * 0.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text(
                                                          "Farmer's Salad",
                                                          style: TextStyles
                                                              .recipeName),
                                                    ),
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0),
                                                        ),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${widget.selectedAvailableUser.profilePhoto}"),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text(
                                                          "Avocado Toast",
                                                          style: TextStyles
                                                              .recipeName),
                                                    ),
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0),
                                                        ),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${widget.selectedAvailableUser.profilePhoto}"),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text(
                                                          "Farmer's Salad",
                                                          style: TextStyles
                                                              .recipeName),
                                                    ),
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0),
                                                        ),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${widget.selectedAvailableUser.profilePhoto}"),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>
        //         InfluencerDetails(selectedInfluencer: influencer)));
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Container(height: screenHeight / 3, color: uniColors.transparent),
            Positioned(
              left: 1.0,
              top: 1.0,
              child: Hero(
                tag: availableUsers.profilePhoto,
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
            ),
            Positioned(
                left: 1.0,
                top: 145.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
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
