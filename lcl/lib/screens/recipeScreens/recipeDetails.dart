import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/enum/userState.dart';
import 'package:lcl/models/favs.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/authMethods.dart';
import 'package:lcl/resources/favMethods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/availableUserDetail.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/utils/uniColors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

class RecipeDetails extends StatefulWidget {
  final Recipe selectedRecipe;
  RecipeDetails({this.selectedRecipe});

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _portionKey = GlobalKey<FormBuilderState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  FirebaseRepository _repository = FirebaseRepository();

  AnimationController controller;

  List<User> refreshList;

  List<User> filterList;

  List<Recipe> selectedUserProfileRecipes;

  int localPortion;

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

  static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;

  final CollectionReference _favCollection =
      _firestore.collection(FAV_COLLECTION);

  User recipeChef;

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
        });
        getFavsListFromDb(loggedInId);
      });
    });

    // getFavRecipesListFromDb(loggedInId);

    _repository
      ..fetchUserById(widget.selectedRecipe.userId).then((user) {
        setState(() {
          recipeChef = user;
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
  }

  void storeRecipeFavs(String recipeId) async {
    var counter = 0;

    for (var i = 0; i < fRecipes.length; i++) {
      if (fRecipes[i] == recipeId) {
        counter++;
      }
    }

    if (counter == 0) {
      fRecipes.add(widget.selectedRecipe.recipeId);
    }
  }

  bool favSent = false;
  void sendFavs(String recipeId) async {
    var counter = 0;

    for (var i = 0; i < fRecipes.length; i++) {
      if (fRecipes[i] == recipeId) {
        counter++;
      }
    }

    if (counter == 0) {
      fRecipes.add(widget.selectedRecipe.recipeId);

      Favs _favs = Favs(
        favId: loggedInId,
        favRecipes: fRecipes,
        favPeople: fPeople,
      );

      _favMethods.addFavsToDb(_favs);
    }
  }

  Widget ingridientMaker(localPortion) {
    int recipeIngridientCount = widget.selectedRecipe.recipeIngridients.length;

    List<Widget> list = new List<Widget>();

    for (var i = 0; i < recipeIngridientCount - 1; i++) {
      var amt =
          widget.selectedRecipe.recipeIngridients[i]['igAmt${i + 1}'] != null
              ? widget.selectedRecipe.recipeIngridients[i]['igAmt${i + 1}']
              : "portion";
      var unit =
          widget.selectedRecipe.recipeIngridients[i]['igUnit${i + 1}'] != null
              ? widget.selectedRecipe.recipeIngridients[i]['igUnit${i + 1}']
              : "";
      var name =
          widget.selectedRecipe.recipeIngridients[i]['igName${i + 1}'] != null
              ? widget.selectedRecipe.recipeIngridients[i]['igName${i + 1}']
              : "";

      // var amtPortion;
      // var thePortion;
      // if (amt != "portion") {
      //   amtPortion =  double.parse(amt);

      //   if(amtPortion.runtimeType ==double){
      //     thePortion=amtPortion*localPortion;
      //   }

      // } else {
      //   amtPortion = "";
      //   thePortion="";
      // }

      if (name != "") {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: widget.selectedRecipe.recipeIngridients[i] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            //mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Text("$amt",
                                    style:
                                        TextStyles.selectedRecipeIngridientAmt),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("$unit",
                                    style: TextStyles
                                        .selectedRecipeIngridientUnit),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("$name",
                                    style: TextStyles
                                        .selectedRecipeIngridientName),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Text("f"),
          ),
        );
      }
    }
    return new Column(children: list);
  }

  Widget instructionMaker() {
    Widget instruc = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10),
      child: widget.selectedRecipe.recipeInstructions != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: Text(
                    "${widget.selectedRecipe.recipeInstructions}",
                    style: TextStyles.selectedRecipeInstructions,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            )
          : Text(""),
    );

    return instruc;
  }

  Widget timeMaker() {
    var prepTime = widget.selectedRecipe.recipePreparationTime;
    var cookTime = widget.selectedRecipe.recipeCookingTime;
    var restTime = widget.selectedRecipe.recipeRestTime;

    var duPrep =
        prepTime != null && prepTime != "" ? double.parse(prepTime) : 0;
    var duCook =
        cookTime != null && cookTime != "" ? double.parse(cookTime) : 0;
    var duRest =
        restTime != null && restTime != "" ? double.parse(restTime) : 0;

    var totalTime = duPrep + duCook + duRest;

    Widget instruc = totalTime > 0
        ? Text(
            "Time: ${totalTime.toInt()} mins",
            style: TextStyles.cookTime,
          )
        : Text("");

    return instruc;
  }

  Widget difficultyMaker() {
    Widget diffi;

    List<Widget> list = new List<Widget>();

    if (widget.selectedRecipe.recipeDifficulty == "Fool proof") {
      diffi = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefEm.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefEm.svg",
              height: 30, width: 30, color: uniColors.white2)
        ],
      );
    }

    if (widget.selectedRecipe.recipeDifficulty == "Average") {
      diffi = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefEm.svg",
              height: 30, width: 30, color: uniColors.white2)
        ],
      );
    }

    if (widget.selectedRecipe.recipeDifficulty == "Pro") {
      diffi = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2),
          SvgPicture.asset("assets/chefFi.svg",
              height: 30, width: 30, color: uniColors.white2)
        ],
      );
    }

    return diffi;
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
                            child: SvgPicture.asset("assets/message.svg",
                                height: 30, width: 30, color: uniColors.lcRed),
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
                  child: FormBuilder(
                    key: _portionKey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                        color: uniColors.lcRed,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Stack(children: <Widget>[
                              Container(
                                height: screenHeight * 0.4,
                                //  width: screenHeight * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                    // bottomLeft: Radius.circular(25.0),
                                    //  bottomRight: Radius.circular(25.0),
                                  ),
                                  image: DecorationImage(
                                      image: (widget.selectedRecipe
                                                      .recipePicture ==
                                                  "dummyNoImage" ||
                                              widget.selectedRecipe
                                                      .recipePicture ==
                                                  null)
                                          ? AssetImage("assets/plate.jpg")
                                          : NetworkImage(
                                              "${widget.selectedRecipe.recipePicture}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              // Container(
                              //     height: screenHeight * 0.4,
                              //     //  width: screenHeight * 0.4,
                              //     child: PhotoView(
                              //       imageProvider:
                              //           (widget.selectedRecipe
                              //                         .recipePicture ==
                              //                     "dummyNoImage" ||
                              //                 widget.selectedRecipe
                              //                         .recipePicture ==
                              //                     null)
                              //             ? AssetImage("assets/plate.jpg")
                              //             : NetworkImage(
                              //                 "${widget.selectedRecipe.recipePicture}"),
                              //     )),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: timeMaker(),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: widget.selectedRecipe
                                                .recipeDifficulty !=
                                            null
                                        ? difficultyMaker()
                                        : Container(),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          //name container
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 12),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      (widget.selectedRecipe.recipeName ==
                                                  null ||
                                              widget.selectedRecipe
                                                      .recipeName ==
                                                  "")
                                          ? Text(
                                              "LC Recipe Name",
                                              style: TextStyles
                                                  .selectedProfileName,
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    widget
                                                                .selectedRecipe
                                                                .recipeName
                                                                .length <
                                                            18
                                                        ? Text(
                                                            widget
                                                                .selectedRecipe
                                                                .recipeName,
                                                            style: TextStyles
                                                                .selectedProfileName)
                                                        : Text(
                                                            "${widget.selectedRecipe.recipeName.substring(0, 18)}...",
                                                            style: TextStyles
                                                                .selectedProfileName),

                                                    // Text(
                                                    //   "${widget.selectedRecipe.recipeName}",
                                                    //   style: TextStyles
                                                    //       .selectedProfileName,
                                                    // ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          //   getFavRecipesListFromDb(userProvider.getUser.uid);

                                                          //    print("printing here: $fRecipes");
                                                          setState(() {
                                                            favSent = true;
                                                          });
                                                          sendFavs(widget
                                                              .selectedRecipe
                                                              .recipeId);
                                                        },
                                                        child: favSent
                                                            ? Icon(
                                                                Icons.star,
                                                                size: 40,
                                                                color: uniColors
                                                                    .white2,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .star_border,
                                                                size: 40,
                                                                color: uniColors
                                                                    .white2,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                AvailableUserDetail(
                                                                    selectedAvailableUser:
                                                                        recipeChef)));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0, right: 0),
                                                    child: Text(
                                                        "by ${widget.selectedRecipe.recipeCreatorName}",
                                                        style: TextStyles
                                                            .selfProfileUserBio),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                                //portion
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 12.0, top: 0),
                                //   child:
                                //       //Text("for 2 people",style: TextStyles.selectedRecipePortion),

                                //       FormBuilderTouchSpin(
                                //     decoration:
                                //         const InputDecoration(labelText: ''),
                                //     attribute: 'portion',
                                //     initialValue: 1,
                                //     step: 1,
                                //     iconSize: 48.0,
                                //     addIcon: const Icon(Icons.arrow_right,
                                //         color: Colors.white),
                                //     subtractIcon: const Icon(Icons.arrow_left,
                                //         color: Colors.white),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         localPortion = value;
                                //       });
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          //ingridients container
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 12, right: 12),
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: uniColors.white2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                              child: widget.selectedRecipe.recipeIngridients !=
                                      null
                                  ? Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 10),
                                          child: Container(
                                            child: Text("Ingridients",
                                                style: TextStyles
                                                    .selectedRecipeIngridients),
                                          ),
                                        ),
                                        ingridientMaker(localPortion),
                                      ],
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(height: 20),
                          //instructions container
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: uniColors.white2,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 10),
                                  child: Container(
                                    child: Text("Instructions",
                                        style: TextStyles
                                            .selectedRecipeIngridients),
                                  ),
                                ),
                                Container(
                                  child: instructionMaker(),
                                ),
                              ],
                            ),
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
