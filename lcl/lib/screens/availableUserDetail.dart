import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lcl/common/mainScreenBar.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/enum/userState.dart';
import 'package:lcl/models/favs.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/authMethods.dart';
import 'package:lcl/resources/favMethods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/chatScreens/chatScreen.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/screens/recipeScreens/recipeDetails.dart';
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

  List<Recipe> selectedUserProfileRecipes;

  String loggedInId;
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

    List<String> fTempRecipes = new List<String>();
  List<String> fRecipes = new List<String>();
  List<String> fPeople = new List<String>();

  Language _selectedDropdownLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('en');

    static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;

  final CollectionReference _favCollection =
      _firestore.collection(FAV_COLLECTION);

    final FavMethods _favMethods = FavMethods();

  void getFavsListFromDb(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _favCollection.document(userId).get();

    for (var i = 0; i < documentSnapshot.data['favRecipes'].length; i++) {
      setState(() {
        fRecipes.add(documentSnapshot.data['favRecipes'][i]);
      });
    }
        for (var i = 0; i < documentSnapshot.data['favPeople'].length; i++) {
      setState(() {
        fPeople.add(documentSnapshot.data['favPeople'][i]);
      });
    }
  }


  @override
  void initState() {
    getLocation();
    isVega = false;
    isVege = true;
    isNVege = false;

    String userIdd = widget.selectedAvailableUser.uid;

    _repository
        .fetchRecipeBatchById(userIdd)
        .then((List<Recipe> profileRecipes) {
      setState(() {
        selectedUserProfileRecipes = profileRecipes;
      });
    });

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedInId = loggedUser['uid'];
          loggedInname = loggedUser['name'];
          loggedInUsername = loggedUser['username'];
          loggedInBio = loggedUser['bio'];
          loggedInprofilePhoto = loggedUser['profile_photo'];
          // isVega = loggedUser['isVegan'];
          // isVege = loggedUser['isVegetarian'];
          // isNVege = loggedUser['isNVegetarian'];
        });
        getFavsListFromDb(loggedInId);

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

    void storePersonFavs(String personId) async {
    var counter = 0;

    for (var i = 0; i < fPeople.length; i++) {
      if (fPeople[i] == personId) {
        counter++;
      }
    }

    if (counter == 0) {
      fRecipes.add(widget.selectedAvailableUser.uid);
    }
  }
bool favSent=false;
  void sendFavs(String peopleId) async {
    var counter = 0;

    for (var i = 0; i < fPeople.length; i++) {
      if (fPeople[i] == peopleId) {
        counter++;
      }
    }

    if (counter == 0) {

      
      fPeople.add(widget.selectedAvailableUser.uid);

      Favs _favs = Favs(
        favId: loggedInId,
        favRecipes: fRecipes,
        favPeople: fPeople,
      );
      
      _favMethods.addFavsToDb(_favs);
    }
  }

  Widget chipMaker(User selectedAvailableUser) {
    int categoryLength = selectedAvailableUser.cuisines !=null? selectedAvailableUser.cuisines.length:0;

    List<Widget> list = new List<Widget>();

    for (var i = 0; i < categoryLength; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: selectedAvailableUser.cuisines[i] != null
              ? Chip(
                  backgroundColor: uniColors.white2,
                  label: Text(selectedAvailableUser.cuisines[i],
                      style: TextStyles.profileChipStyle),
                )
              : Container(),
        ),
      );
    }
    return new Row(children: list);
  }

  Widget chipMakerr(User selectedAvailableUser) {
    int categoryLength = selectedAvailableUser.cuisines.length;

    List<Widget> list = new List<Widget>();

    for (var i = 0; i < categoryLength; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: selectedAvailableUser.cuisines[i] != null
              ? Chip(
                  backgroundColor: uniColors.white2,
                  label: Text(selectedAvailableUser.cuisines[i],
                      style: TextStyles.profileChipStyle),
                )
              : Container(),
        ),
      );
    }
    return new Row(children: list);
  }

  Widget recipeDisplayMaker() {
    List<Widget> list = new List<Widget>();

    for (var i in selectedUserProfileRecipes) {
      i.recipeName != null
          ? list.add(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            RecipeDetails(selectedRecipe: i)),
                    (Route<dynamic> route) => false,
                  );
                },
                                  child: Column(
                    children: <Widget>[
                     i.recipeName.length<10 ?
                        Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(i.recipeName,style: TextStyles.recipeProfileName),
                      ):
                       
                        Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text("${i.recipeName.substring(0,11)}...",style: TextStyles.recipeProfileName),
                      ),
                    

                   
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                              image: (i.recipePicture == "dummyNoImage" ||
                                      i.recipePicture == null)
                                  ? AssetImage("assets/defaultUserPicture.png")
                                  : NetworkImage("${i.recipePicture}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : list.add(Container());
    }

    return new Row(children: list);
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
            color: uniColors.white2,
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
                            child: SvgPicture.asset(
                                          "assets/message.svg",
                                          height: 30,
                                          width: 30,
                                          color: uniColors.lcRed),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                                    child: Stack(
                                      children: <Widget>[
                                      Container(
                                        height: screenHeight * 0.4,
                                        width: screenHeight * 0.4,
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
                                      // Positioned(
                                      //   left: 10,
                                      //   bottom: 10,
                                      //   child: Container(
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceAround,
                                      //       children: <Widget>[
                                      //         FloatingActionRow(
                                      //           color: uniColors.lcRed,
                                      //           children: <Widget>[
                                      //             FloatingActionRowButton(
                                      //                 icon: Icon(
                                      //                   Icons.close,
                                      //                   color: uniColors.white2,
                                      //                   size: 25,
                                      //                 ),
                                      //                 onTap: () {}),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      Positioned(
                                        right: 10,
                                        bottom: 10,
                                        child: GestureDetector(
                                          onTap: (){
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
                                                                                  child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                FloatingActionRow(
                                                  color: uniColors.white2,
                                                  children: <Widget>[
                                                    FloatingActionRowButton(
                                                        icon: Icon(
                                                          Icons.message,
                                                          color:
                                                              uniColors.lcRed,
                                                          size: 25,
                                                        ),
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
                                                        }),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Text(
                                                        "CHAT",
                                                        style: TextStyles
                                                            .profileChat,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
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
                                 width: screenWidth*0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0),
                                  ),
                                   //  color: uniColors.standardWhite,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                          bottomLeft: Radius.circular(25.0),
                                          bottomRight: Radius.circular(25.0),
                                        ),
                                       //  color: uniColors.standardWhite,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 15.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child:
                                                      (widget.selectedAvailableUser.name ==
                                                                  null ||
                                                              widget.selectedAvailableUser.name ==
                                                                  "")
                                                          ? Text(
                                                              "LC User Name",
                                                              style: TextStyles
                                                                  .selectedProfileName,
                                                            )
                                                          : widget.selectedAvailableUser.name.length<15? Text(
                                                              "${widget.selectedAvailableUser.name}",
                                                              style: TextStyles
                                                                  .selectedProfileName,
                                                            ):
                                                            Text(
                                                              "${widget.selectedAvailableUser.name.substring(0,14)}...",
                                                              style: TextStyles
                                                                  .selectedProfileName,
                                                            ),
                                                ),
                                                Container(
                                                  child:
                                                      (widget.selectedAvailableUser.age ==
                                                                  null ||
                                                              widget.selectedAvailableUser.age == "")
                                                          ? Text(
                                                              "",
                                                              style: TextStyles
                                                                  .selectedProfileAge,
                                                            )
                                                          : Text(
                                                              "  ${widget.selectedAvailableUser.age}",
                                                              style: TextStyles
                                                                  .selectedProfileAge,
                                                            )
                                                ),
                                                Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          //   getFavRecipesListFromDb(userProvider.getUser.uid);

                                                          //    print("printing here: $fRecipes");
                                                          setState(() {
                                                            favSent=true;
                                                          });
                                                          sendFavs(widget
                                                              .selectedAvailableUser
                                                              .uid);
                                                        },
                                                        child:favSent? Icon(
                                                          Icons.star,
                                                          size: 40,
                                                          color:
                                                              uniColors.white2,
                                                        ):
                                                        Icon(
                                                          Icons.star_border,
                                                          size: 40,
                                                          color:
                                                              uniColors.white2,
                                                        ),
                                                      ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 15),
                                            child: Container(
                                              child:
                                                  (userProvider.getUser.bio ==
                                                              null ||
                                                          userProvider.getUser
                                                                  .bio ==
                                                              "")
                                                      ? Text(
                                                          "The bio of LC User",
                                                          style: TextStyles
                                                              .selectedProfileUserBio,
                                                        )
                                                      : Text(
                                                          "${widget.selectedAvailableUser.bio}",
                                                          style: TextStyles
                                                              .selectedProfileUserBio,
                                                        ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                          //width: screenWidth,
                                          //color: uniColors.white2,
                                          child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          color: uniColors.lcRed,
                                          child: chipMaker(
                                              widget.selectedAvailableUser),
                                        ),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                          height: screenHeight * 0.25,
                                          //  width: screenWidth*0.9,

                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              //width: screenWidth*0.9,
                                              decoration: BoxDecoration(
                                                color: uniColors.transparent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  bottomLeft:
                                                      Radius.circular(8.0),
                                                  bottomRight:
                                                      Radius.circular(8.0),
                                                ),
                                              ),
                                              child: recipeDisplayMaker(),
                                            ),
                                          )),
                                    ),

                                    //For insta pics
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top:8.0),
                                    //   child: Container(
                                    //     height:screenHeight*0.15,
                                    //    width: screenWidth*0.9,

                                    //     child: SingleChildScrollView(
                                    //       scrollDirection: Axis.horizontal,
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           color:uniColors.transparent,
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(8.0),
                                    //         topRight: Radius.circular(8.0),
                                    //         bottomLeft: Radius.circular(8.0),
                                    //         bottomRight: Radius.circular(8.0),
                                    //       ),

                                    //     ),
                                    //         child:recipeDisplayMaker(),),
                                    //     )
                                    //   ),
                                    // ),
                                  ],
                                )),
                          ),
                        ],
                      ),
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
}
