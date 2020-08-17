import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lcl/common/mainScreenBar.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/enum/userState.dart';
import 'package:lcl/models/favs.dart';
import 'package:lcl/models/movie.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/authMethods.dart';
import 'package:lcl/resources/favMethods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/resources/recipeMethods.dart';
import 'package:lcl/screens/availableUserDetail.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/favScreens/movieCard.dart';
import 'package:lcl/screens/favScreens/movieList.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/screens/recipeScreens/bottomSheetCustom.dart';
import 'package:lcl/screens/recipeScreens/detailedSearchScreen.dart';
import 'package:lcl/screens/recipeScreens/recipeDetails.dart';
import 'package:lcl/screens/recipeScreens/recipeMakerContainer.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:lcl/widgets/CustomTile.dart';
import 'package:lcl/widgets/nmBarButton.dart';
import 'package:lcl/widgets/nmBox.dart';
import 'package:lcl/widgets/nmButton.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:floating_action_row/floating_action_row.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<User> magicFilterList;

  List<Recipe> recipeList;

  List<Recipe> selfRecipeList;

  //For search

  List<Recipe> allRecipeList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  String loggedInId;
  String loggedInname;
  String loggedInprofilePhoto;
  String loggedInUsername;
  String loggedInBio;
  List loggedInCategories;

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
  bool showSearchPage = false;
  bool showLunchalizePage = true;
  bool showFavsPage = false;
  bool showAccountPage = false;

  bool showFavRecipes = true;
  bool showFavPeople = false;

  bool refreshLunchalize = true;
  bool refreshRecipes = true;

  int loggedUserAge1;
  int loggedUserAge2;
  int loggedUserDistance;

  String loggedUserInterestedIn;
  String loggedUserMode;

  String loggedUserLat;
  String loggedUserLon;

  List<String> fRecipes = new List<String>();
  List<String> fRecipesNames = new List<String>();
  List<String> fPeople = new List<String>();
  List<String> fPeopleNames = new List<String>();

  UserProvider userProvider;

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
          loggedInId = loggedUser['uid'];
          loggedInname = loggedUser['name'];
          loggedInUsername = loggedUser['username'];
          loggedInBio = loggedUser['bio'];
          loggedInprofilePhoto = loggedUser['profile_photo'];
          loggedInCategories = loggedUser['cuisines'];
        });
        getFavsListFromDb(loggedInId);
      });

      _repository.fetchLoggedUserSettings(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserAge1 = loggedUser.data['sAge1'];
          loggedUserAge2 = loggedUser.data['sAge2'];
          loggedUserDistance = loggedUser.data['sDistance'];
          loggedUserInterestedIn = loggedUser.data['sInterestedIn'];
          loggedUserMode = loggedUser.data['sMode'];
        });

        _repository.getCurrentUser().then((FirebaseUser user) {
          _repository.fetchBatch(user).then((List<User> list) {
             setState(() {
             
for(var i=0;i<list.length;i++){
  print("gogo: ${list[i].name}");
}

              
              if (loggedUserInterestedIn == "Men") {
                for (var i = 0; i < list.length; i++) {
                  if (list[i].gender == "Man") {
              
                    filterList.add(list[i]);
                  }
                }
              }
              if (loggedUserInterestedIn == "Women") {
                for (var i = 0; i < list.length; i++) {
                  if (list[i].gender == "Woman") {
                  
                    filterList.add(list[i]);
                  }
                }
              }
              else if (loggedUserInterestedIn == "Everyone" || loggedUserInterestedIn == null) {
               
                 filterList = list;
              }

              
            });
          });
        });
      });
    });

    // _repository.getCurrentUser().then((FirebaseUser user) {
    //   _repository.fetchBatch(user).then((List<User> list) {
    //     print("objfsfvect: ${loggedUserInterestedIn}");
    //     setState(() {
    //       filterList = list;

    //       // for (var i = 0; i < 1; i++) {
    //       // if (list[i].isInfluencer == true && list[i].isInfCert == true) {
    //       // filterList.add(list[i]);
    //       //}
    //       // }
    //     });

    //   });
    // });

    _repository.fetchRecipeBatch().then((List<Recipe> recipes) {
      setState(() {
        recipeList = recipes;
        allRecipeList = recipes;
      });
    });

    _repository.getCurrentUser().then((FirebaseUser user) {
      String currUserId = user.uid;
      _repository
          .fetchSelfRecipeBatch(currUserId)
          .then((List<Recipe> selfRecipes) {
        setState(() {
          selfRecipeList = selfRecipes;
        });
      });
    });

    super.initState();
    distance = 5;
    time = 0;
    buddyMode = true;
    romanticMode = false;
    businessMode = false;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showRecipePageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = true;
      showSearchPage = false;
      showLunchalizePage = false;
      showFavsPage = false;
      showAccountPage = false;
    });
    controller.forward();
  }

  void showSearchPageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = false;
      showSearchPage = true;
      showLunchalizePage = false;
      showFavsPage = false;
      showAccountPage = false;
    });
    controller.forward();
  }

  // Future<String> getPersonNameById(String personId) async {
  //   var personName = "ddbaro";

  //   final CollectionReference _userCollection =
  //       _firestore.collection(USERS_COLLECTION);
  //   DocumentSnapshot documentSnapshot =
  //       await _userCollection.document(personId).get();

  //   setState(() {
  //     personName = documentSnapshot.data['name'];
  //   });

  //   // _repository.fetchUserNameById(personId);

  //   return personName;
  // }

  searchAppBar(BuildContext context) {
    return GradientAppBar(
      backgroundColorStart: uniColors.standardWhite,
      backgroundColorEnd: uniColors.standardWhite,
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: uniColors.grey1),
          onPressed: () => {
                setState(() {
                  FocusScope.of(context).unfocus();
                  showSearchPage = false;
                  showLunchalizePage = true;
                })
              }),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: uniColors.black,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: uniColors.lcRedLight,
              fontSize: 25,
            ),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: uniColors.grey1),
                  onPressed: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => searchController.clear());
                    FocusScope.of(context).unfocus();
                  },
                ),
                border: InputBorder.none,
                hintText: "Enter recipe name to search",
                hintStyle: TextStyles.searchText),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    //for hashtags
    // final List<Recipe> suggestionCuisineList = (query.isEmpty)
    //     ? []
    //     : allRecipeList.where((Recipe recipe) {
    //         String _getCuisine = recipe.recipeCuisine==null? "none" : recipe.recipeCuisine.toLowerCase();
    //         String _filteredCuisine = _getCuisine.replaceAll("#", "");
    //         String _filteredQuery = query.replaceAll("#", "");
    //         _filteredQuery = _filteredQuery.toLowerCase();
    //         bool matchesCuisines = _filteredCuisine.contains(_filteredQuery);
    //         return (matchesCuisines);
    //       }).toList();

    final List<Recipe> suggestionList = (query.isEmpty)
        ? []
        : allRecipeList.where((Recipe recipe) {
            String _query = query.toLowerCase();
            String _getName = recipe.recipeName == null
                ? "none"
                : recipe.recipeName.toLowerCase();

            bool matchesName = _getName.contains(_query);
            return (matchesName);
          }).toList();

    return ListView.builder(
      //withHashtags
      // itemCount: suggestionCuisineList.length>0?suggestionCuisineList.length:suggestionList.length,
      // itemBuilder: ((context, index) {
      //   User searchedUser = User(
      //       uid: suggestionCuisineList.length>0?suggestionHashList[index].uid:suggestionList[index].uid,
      //       profilePhoto: suggestionCuisineList.length>0?suggestionHashList[index].profilePhoto:suggestionList[index].profilePhoto,
      //       name: suggestionCuisineList.length>0?suggestionHashList[index].name:suggestionList[index].name,
      //       username: suggestionCuisineList.length>0?suggestionHashList[index].username:suggestionList[index].username);

      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        //can add more details here which should be displayed
        Recipe searchedRecipe = Recipe(
          recipeId: suggestionList[index].recipeId,
          recipePicture: suggestionList[index].recipePicture,
          recipeName: suggestionList[index].recipeName,
          recipeDiet: suggestionList[index].recipeDiet,
          recipePortion: suggestionList[index].recipePortion,
          recipeIngridients: suggestionList[index].recipeIngridients,
          recipeInstructions: suggestionList[index].recipeInstructions,
          recipePreparationTime: suggestionList[index].recipePreparationTime,
          recipeCookingTime: suggestionList[index].recipeCookingTime,
          recipeRestTime: suggestionList[index].recipeRestTime,
          recipeDifficulty: suggestionList[index].recipeDifficulty,
          recipeType: suggestionList[index].recipeType,
          recipeCuisine: suggestionList[index].recipeCuisine,
          recipeCalories: suggestionList[index].recipeCalories,
          recipeYums: suggestionList[index].recipeYums,
          recipeCreatorPic: suggestionList[index].recipeCreatorPic,
          recipeCreatorName: suggestionList[index].recipeCreatorName,
        );

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      RecipeDetails(selectedRecipe: searchedRecipe)),
              (Route<dynamic> route) => false,
            );
          },
          leading: CircleAvatar(
            backgroundImage: (searchedRecipe.recipePicture == "dummyNoImage" ||
                    searchedRecipe.recipePicture == null)
                ? AssetImage("assets/plate.jpg")
                : NetworkImage("${searchedRecipe.recipePicture}"),
            backgroundColor: Colors.grey,
          ),
          title: (searchedRecipe.recipeName == "" ||
                  searchedRecipe.recipeName == null)
              ? Text("LC Recipe", style: TextStyles.searchTextResult)
              : Text(searchedRecipe.recipeName,
                  style: TextStyles.searchTextResult),
          subtitle: (searchedRecipe.recipeDifficulty == "" ||
                  searchedRecipe.recipeDifficulty == null)
              ? Text("", style: TextStyles.searchSubTextResult)
              : Text(searchedRecipe.recipeDifficulty,
                  style: TextStyles.searchSubTextResult),
        );
      }),
    );
  }

  void showLunchalizePageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = false;
      showSearchPage = false;
      showLunchalizePage = true;
      showFavsPage = false;
      showAccountPage = false;
    });
    controller.forward();
  }

  void showFavsPageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = false;
      showSearchPage = false;
      showLunchalizePage = false;
      showFavsPage = true;
      showAccountPage = false;
    });
    controller.forward();
  }

  var list = ["one", "two", "three", "four"];
  void showAccountPageNow() {
    controller.reverse();

    setState(() {
      showRecipePage = false;
      showSearchPage = false;
      showLunchalizePage = false;
      showFavsPage = false;
      showAccountPage = true;
    });
    controller.forward();
  }

  Widget chipMaker(int chipLength) {
    List<Widget> list = new List<Widget>();

    for (var i = 0; i < chipLength; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: userProvider.getUser.cuisines[i] != null
              ? Chip(
                  backgroundColor: uniColors.white2,
                  label: Text(userProvider.getUser.cuisines[i],
                      style: TextStyles.profileChipStyle),
                )
              : Container(),
        ),
      );
    }
    return new Row(children: list);
  }

  Widget favPeopleListMaker(int favPeopleCount) {
    List<Widget> list = new List<Widget>();

    for (var i = 0; i < favPeopleCount; i++) {
      list.add(
        fPeople[i] != null
            ? Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    fPeople.removeAt(i);

                    Favs _favs = Favs(
                      favId: loggedInId,
                      favRecipes: fRecipes,
                      favPeople: fPeople,
                    );

                    _favMethods.updateFavsToDb(_favs);
                  });
                },
                direction: DismissDirection.endToStart,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/lclv1-68a3b.appspot.com/o/1594762179417?alt=media&token=86c6cbc9-af75-47d6-a161-4296c07aa76b"),
                    ),
                    //     leading: SvgPicture.asset("assets/donateNew.svg", height: 30, width: 30, color: uniColors.standardBlack),

                    title: Text(fPeople[i]),

                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            fPeople.removeAt(i);

                            Favs _favs = Favs(
                              favId: loggedInId,
                              favRecipes: fRecipes,
                              favPeople: fPeople,
                            );

                            _favMethods.updateFavsToDb(_favs);
                          });
                        },
                        child: SvgPicture.asset("assets/trash.svg",
                            height: 20, width: 20, color: uniColors.white2)),
                  ),
                ),
              )

            // Chip(
            //     backgroundColor: uniColors.white2,
            //     label: Text(fPeople[i],
            //         style: TextStyles.profileChipStyle),
            //   )
            : Container(),
      );
    }
    return new Column(children: list);
  }

  Widget favRecipeListMaker(int favRecipeCount) {
    List<Widget> list = new List<Widget>();

    for (var i = 0; i < favRecipeCount; i++) {
      list.add(
        fRecipes[i] != null
            ? Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    fRecipes.removeAt(i);

                    Favs _favs = Favs(
                      favId: loggedInId,
                      favRecipes: fRecipes,
                      favPeople: fPeople,
                    );

                    _favMethods.updateFavsToDb(_favs);
                  });
                },
                direction: DismissDirection.endToStart,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/lclv1-68a3b.appspot.com/o/1595267121726?alt=media&token=84b44529-b93d-475c-b9cd-9611e62578e8"),
                    ),
                    //     leading: SvgPicture.asset("assets/donateNew.svg", height: 30, width: 30, color: uniColors.standardBlack),

                    title: Text(fRecipes[i]),

                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            fRecipes.removeAt(i);

                            Favs _favs = Favs(
                              favId: loggedInId,
                              favRecipes: fRecipes,
                              favPeople: fPeople,
                            );

                            _favMethods.updateFavsToDb(_favs);
                          });
                        },
                        child: SvgPicture.asset("assets/trash.svg",
                            height: 20, width: 20, color: uniColors.white2)),
                  ),
                ),
              )

            // Chip(
            //     backgroundColor: uniColors.white2,
            //     label: Text(fPeople[i],
            //         style: TextStyles.profileChipStyle),
            //   )
            : Container(),
      );
    }
    return new Column(children: list);
  }

  Future<Null> refresh() {
    return _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchBatch(user).then((List<User> list) {
      

        setState(() {
             

              if (loggedUserInterestedIn == "Men") {
                for (var i = 0; i < list.length; i++) {
                  if (list[i].gender == "Man") {
                    
                    filterList.add(list[i]);
                  }
                }
              }
              if (loggedUserInterestedIn == "Women") {
                for (var i = 0; i < list.length; i++) {
                  if (list[i].gender == "Woman") {
                    
                    filterList.add(list[i]);
                  }
                }
              }
              else if (loggedUserInterestedIn == "Everyone" || loggedUserInterestedIn == null) {
                
                 filterList = list;
              }

             
            });
           
      });
       
    });
  }

  Future<Null> refreshReci() {
    return _repository.fetchRecipeBatch().then((List<Recipe> recipes) {
      setState(() {
        recipeList = recipes;
      });
      initState();
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
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      position = currentPosition;
    });
  }

  final RecipeMethods _recipeMethods = RecipeMethods();

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
      scaffold: SwipeDetector(
          swipeConfiguration: SwipeConfiguration(
            verticalSwipeMinVelocity: 20.0,
            verticalSwipeMinDisplacement: 20.0,
            verticalSwipeMaxWidthThreshold: 100.0,
            // horizontalSwipeMaxHeightThreshold: 50.0,
            // horizontalSwipeMinDisplacement:50.0,
            // horizontalSwipeMinVelocity: 200.0
          ),
          child: Scaffold(
            appBar: showSearchPage ? searchAppBar(context) : null,
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
                              : "https://images.pexels.com/photos/1333318/pexels-photo-1333318.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: loggedInname != null
                            ? loggedInname.length < 15
                                ? GradientText(loggedInname,
                                    gradient: LinearGradient(colors: [
                                      uniColors.lcRed,
                                      uniColors.lcRedLight,
                                      uniColors.lcRed,
                                    ]),
                                    style: TextStyles.drawerNameTextStyle,
                                    textAlign: TextAlign.center)
                                : GradientText(
                                    "${loggedInname.substring(0, 14)}...",
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
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
                              icon: Icons.mode_edit,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                settingsPressed = !settingsPressed;
                                if (settingsPressed) {
                                  Navigator.pushNamed(
                                      context, "/edit_settings_screen");
                                }
                              });
                            },
                            child: NMButton(
                              down: settingsPressed,
                              icon: Icons.settings,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                paymentPressed = !paymentPressed;
                                if (paymentPressed) {
                                  Navigator.pushNamed(
                                      context, "/community_guidelines_screen");
                                }
                              });
                            },
                            child: NMButton(
                                down: paymentPressed, icon: Icons.info),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.15,
                    ),
                    ListTile(
                        title: new Text(
                          "Donate",
                          style: TextStyle(
                              color: uniColors.standardBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        trailing: SvgPicture.asset("assets/donateNew.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.standardBlack),
                        onTap: () {
                          //   Navigator.of(context).pop();
                          const url = 'https://www.welthungerhilfe.de/spenden/';
                          launchURL(url);

                          //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                        }),
                    ListTile(
                        title: new Text(
                          "Legal disclosure",
                          style: TextStyle(
                              color: uniColors.standardBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        trailing: SvgPicture.asset("assets/terms.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.standardBlack),
                        onTap: () {
                          Navigator.pushNamed(context, "/terms_screen");
                          //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                        }),
                    ListTile(
                        title: new Text(
                          "About",
                          style: TextStyle(
                              color: uniColors.standardBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        trailing: SvgPicture.asset("assets/aboutus.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.standardBlack),
                        onTap: () {
                          Navigator.pushNamed(context, "/about_screen");

                          // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                        }),
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
                        trailing: SvgPicture.asset("assets/logout.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.standardBlack),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: showSearchPage
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: buildSuggestions(query),
                  )
                : RefreshIndicator(
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
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Icon(Icons.menu,
                                          color: uniColors.lcRed),
                                    ),
                                    onTap: () {
                                      _scaffoldKey.currentState.openDrawer();
                                    },
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/onboarding_screen");
                                    },
                                    child: Text(
                                      Strings.APP_NAME,
                                      style: TextStyles.appNameTextStyle,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: SvgPicture.asset(
                                          "assets/message.svg",
                                          height: 30,
                                          width: 30,
                                          color: uniColors.lcRed),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/chatList_screen");
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
                                    visible: showRecipePage,
                                    child: Container(
                                      //margin: EdgeInsets.only(top: 20),
                                      height:
                                          MediaQuery.of(context).size.height -
                                              300.0,
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 0.88,
                                        primary: false,
                                        children: <Widget>[
                                          if (refreshLunchalize)
                                            if (recipeList != null)
                                              ...recipeList.map((e) {
                                                return buildRecipeGrid(e);
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
                                  //searcho
                                  Visibility(
                                    visible: showSearchPage,
                                    child: Center(
                                      child: Container(
                                          color: Colors.yellow,
                                          //margin: EdgeInsets.only(top: 20),
                                          height: screenHeight * 0.7,
                                          width: screenWidth * 0.99,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              searchAppBar(context),
                                              Center(
                                                child: buildSuggestions(query),
                                              ),
                                              // Center(child: Text("csdvfgh ")),
                                            ],
                                          )),
                                    ),
                                  ),

                                  Visibility(
                                    visible: showLunchalizePage,
                                    child: Container(
                                      //margin: EdgeInsets.only(top: 20),
                                      height:
                                          MediaQuery.of(context).size.height -
                                              300.0,
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
                                    visible: showFavsPage,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 0),
                                        // height:screenHeight*0.8,
//hhu
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              // color: uniColors.white2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        showFavRecipes = false;
                                                        showFavPeople = true;
                                                      });
                                                    },
                                                    child: Container(
                                                      child: showFavPeople
                                                          ? SvgPicture.asset(
                                                              "assets/personOutline.svg",
                                                              height: 30,
                                                              width: 30,
                                                              color: uniColors
                                                                  .black)
                                                          : SvgPicture.asset(
                                                              "assets/personOutline.svg",
                                                              height: 30,
                                                              width: 30,
                                                              color: uniColors
                                                                  .white2),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          showFavRecipes = true;
                                                          showFavPeople = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        child: showFavRecipes
                                                            ? SvgPicture.asset(
                                                                "assets/recipe.svg",
                                                                height: 30,
                                                                width: 30,
                                                                color: uniColors
                                                                    .black)
                                                            : SvgPicture.asset(
                                                                "assets/recipe.svg",
                                                                height: 30,
                                                                width: 30,
                                                                color: uniColors
                                                                    .white2),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: showFavRecipes,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Expanded(
                                                  child: Container(
                                                    width: screenWidth,
                                                    height: screenHeight * 0.67,
                                                    //goo
                                                    decoration: BoxDecoration(
                                                      color: uniColors.lcRed
                                                          .withOpacity(0.98),
                                                      borderRadius: BorderRadius.only(
                                                          // topLeft:
                                                          //     Radius.circular(5.0),
                                                          // topRight:
                                                          //     Radius.circular(5.0),
                                                          // bottomLeft:
                                                          //     Radius.circular(5.0),
                                                          // bottomRight:
                                                          //     Radius.circular(5.0),
                                                          ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                "",
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                              ),
                                                              Container(
                                                                  child: favRecipeListMaker(
                                                                      fRecipes
                                                                          .length)),
                                                                           Padding(
                         padding: const EdgeInsets.all(18.0),
                         child: Text(
                                  "Add to Favourite Recipes: Under construction",
                                  style: TextStyles.filterNames,
                                ),
                       ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: showFavPeople,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Expanded(
                                                  child: Container(
                                                    width: screenWidth,
                                                    height: screenHeight * 0.67,
                                                    //goo
                                                    decoration: BoxDecoration(
                                                      color: uniColors.lcRed
                                                          .withOpacity(0.98),
                                                      borderRadius: BorderRadius.only(
                                                          // topLeft:
                                                          //     Radius.circular(5.0),
                                                          // topRight:
                                                          //     Radius.circular(5.0),
                                                          // bottomLeft:
                                                          //     Radius.circular(5.0),
                                                          // bottomRight:
                                                          //     Radius.circular(5.0),
                                                          ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                "",
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                              ),
                                                              Container(
                                                                  child: favPeopleListMaker(
                                                                      fPeople
                                                                          .length)),
                                                                          Padding(
                         padding: const EdgeInsets.all(18.0),
                         child: Text(
                                  "Add to Favourite People: Under construction",
                                  style: TextStyles.filterNames,
                                ),
                       ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),

                                  Visibility(
                                    visible: showAccountPage,
                                    child: Column(
                                      children: <Widget>[
                                        // Container(
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height -
                                        //       300.0,
                                        //   child: Center(
                                        //     child: Text("AccountPage"),
                                        //   ),
                                        // ),
                                        //User details
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  //  color: uniColors.white1,

                                                  height: screenWidth * 0.35,
                                                  width: screenWidth * 0.3,
                                                  decoration: BoxDecoration(
                                                    color: uniColors.white1,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25.0),
                                                      topRight:
                                                          Radius.circular(25.0),
                                                      bottomLeft:
                                                          Radius.circular(25.0),
                                                      bottomRight:
                                                          Radius.circular(25.0),
                                                    ),
                                                    image: DecorationImage(
                                                        image: (loggedInprofilePhoto ==
                                                                null)
                                                            ? AssetImage(
                                                                "assets/defaultUserPicture.png")
                                                            : NetworkImage(
                                                                "${loggedInprofilePhoto}"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 1.0),
                                                child: Container(
                                                  //   color: uniColors.gold1,
                                                  //  height: screenWidth / 2.0,
                                                  width: screenWidth * 0.58,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15.0),
                                                          child: Container(
                                                            child: (loggedInname ==
                                                                        null ||
                                                                    loggedInname ==
                                                                        "")
                                                                ? Text(
                                                                    "LC User Name",
                                                                    style: TextStyles
                                                                        .selfProfileUserName,
                                                                  )
                                                                : loggedInname
                                                                            .length <
                                                                        15
                                                                    ? Text(
                                                                        "${loggedInname}",
                                                                        style: TextStyles
                                                                            .selfProfileUserName,
                                                                      )
                                                                    : Text(
                                                                        "${loggedInname.substring(0, 14)}...",
                                                                        style: TextStyles
                                                                            .selfProfileUserName,
                                                                      ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0),
                                                          child: Container(
                                                            child: (loggedInBio ==
                                                                        null ||
                                                                    loggedInBio ==
                                                                        "")
                                                                ? Text(
                                                                    "The bio of LC User",
                                                                    style: TextStyles
                                                                        .selfProfileUserBio,
                                                                  )
                                                                : Text(
                                                                    "${loggedInBio}",
                                                                    style: TextStyles
                                                                        .selfProfileUserBio,
                                                                  ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0),
                                                          child: Container(
                                                            width: screenWidth *
                                                                0.58,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        100.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        25.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                              ),
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    "/edit_profile_screen");
                                                              },
                                                              color: uniColors
                                                                  .standardWhite,

                                                              // borderSide: BorderSide.solid,
                                                              child: Text(
                                                                "EDIT PROFILE",
                                                                style: TextStyles
                                                                    .selfProfileUserEdit,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets
                                                        //               .only(
                                                        //           top: 10.0),
                                                        //   child: Container(
                                                        //     child: Row(
                                                        //       mainAxisSize: MainAxisSize.min,
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .center,
                                                        //       children: <Widget>[
                                                        //         CupertinoButton(
                                                        //           onPressed: () {
                                                        //             Navigator.pushNamed(
                                                        //                 context,
                                                        //                 "/edit_profile_screen");
                                                        //           },
                                                        //           color: uniColors
                                                        //               .standardWhite,

                                                        //           // borderSide: BorderSide.solid,
                                                        //           child: Text(
                                                        //               "EDIT PROFILE",
                                                        //               style: TextStyles
                                                        //                   .selfProfileUserEdit),
                                                        //         ),
                                                        //       ],
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //User chips
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                loggedInCategories != null
                                                    ? chipMaker(userProvider
                                                        .getUser
                                                        .cuisines
                                                        .length)
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //User recipes
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, left: 5, right: 5),
                                          child: Container(
                                            //  color: uniColors.gold4,
                                            height: screenHeight * 0.45,
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              color: uniColors.backgroundGrey,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight: Radius.circular(25.0),
                                                bottomLeft:
                                                    Radius.circular(15.0),
                                                bottomRight:
                                                    Radius.circular(15.0),
                                              ),
                                            ),

                                            child: GridView.count(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 1,
                                              childAspectRatio: 0.98,
                                              primary: false,
                                              children: <Widget>[
                                                if (selfRecipeList != null)
                                                  ...selfRecipeList.map((e) {
                                                    return buildSelfRecipeGrid(
                                                        e);
                                                  }).toList(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (showRecipePage),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              //  height:80,
                              margin: EdgeInsets.only(bottom: 55),
                              child: FloatingActionRow(
                                color: uniColors.white2,
                                children: <Widget>[
                                  // FloatingActionRowButton(
                                  //     icon: Icon(Icons.add), onTap: () {}),
                                  // FloatingActionRowDivider(),
                                  // FloatingActionRowButton(
                                  //     icon: Icon(
                                  //       Icons.favorite,
                                  //       color: uniColors.lcRed,
                                  //       size: 25,
                                  //     ),
                                  //     onTap: () {}),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FloatingActionRowButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: uniColors.lcRed,
                                          size: 50,
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: uniColors.white1,
                                            builder: (context) =>
                                                RecipeMakerContainer(),
                                          );
                                        }),
                                  ),
                                  FloatingActionRowDivider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FloatingActionRowButton(
                                        icon: Icon(
                                          Icons.search,
                                          color: uniColors.lcRed,
                                          size: 50,
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: uniColors.white1,
                                            builder: (context) =>
                                                DetailedSearchScreen(),
                                          );
                                        }),
                                  ),
                                  FloatingActionRowDivider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FloatingActionRowButton(
                                        icon: Icon(
                                          Icons.refresh,
                                          color: uniColors.lcRed,
                                          size: 50,
                                        ),
                                        onTap: () {
                                          refreshReci();
                                        }),
                                  ),

                                  // FloatingActionRowButton(
                                  //     icon: Icon(
                                  //       Icons.atm,
                                  //       color: uniColors.lcRed,
                                  //       size: 25,
                                  //     ),
                                  //     onTap: () {}),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (showLunchalizePage),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              //  height:80,
                              margin: EdgeInsets.only(bottom: 55),
                              child: FloatingActionRow(
                                color: uniColors.white2,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: loggedUserMode == "Flirt Mode"
                                        ? SvgPicture.asset("assets/heart.svg",
                                            height: 30,
                                            width: 30,
                                            color: uniColors.grey2)
                                        : SvgPicture.asset(
                                            "assets/friendMode.svg",
                                            height: 30,
                                            width: 30,
                                            color: uniColors.grey2),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: FloatingActionRowButton(
                                        icon: Icon(
                                          Icons.refresh,
                                          color: uniColors.lcRed,
                                          size: 60,
                                        ),
                                        onTap: () {
                                          refresh();
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    //uncomment the distance
                                    child: 34 < 200
                                        ? SvgPicture.asset("assets/local.svg",
                                            height: 30,
                                            width: 30,
                                            color: uniColors.grey2)
                                        : SvgPicture.asset("assets/globe.svg",
                                            height: 30,
                                            width: 30,
                                            color: uniColors.grey2),
                                  ),
                                  // FloatingActionRowButton(
                                  //     icon: Icon(
                                  //       Icons.location_on,
                                  //       color: uniColors.lcRed,
                                  //       size: 25,
                                  //     ),
                                  //     onTap: () async {
                                  //       getLocation();
                                  //       // Navigator.pushNamed(context, "/splash_screen");
                                  //     }),
                                ],
                              ),
                            ),
                          ),
                        )
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
              notchMargin: 1.0,
              child: Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset("assets/recipe.svg",
                          height: 30, width: 30, color: uniColors.lcRed),
                      onPressed: () {
                        // setState(() {
                        //   showRecipePage = true;
                        //   showLunchalizePage = false;
                        //   showFavsPage = false;
                        // });
                        showRecipePageNow();
                      },
                    ),

                    IconButton(
                      icon:
                          Icon(Icons.search, color: uniColors.lcRed, size: 35),
                      onPressed: () {
                        // setState(() {
                        //   showRecipePage = true;
                        //   showLunchalizePage = false;
                        //   showFavsPage = false;
                        // });
                        showSearchPageNow();
                      },
                    ),
                    //           IconButton(
                    //             icon: Image.asset("assets/LCO.png",
                    // height:200,width:300),
                    //             onPressed: () {
                    //               refresh();
                    //               // setState(() {
                    //               //   showRecipePage = false;
                    //               //   showLunchalizePage = true;
                    //               //   showFavsPage = false;
                    //               // });
                    //               showLunchalizePageNow();

                    //               print('Star it');
                    //             },
                    //           ),
                    GestureDetector(
                      onTap: () {
                        refresh();
                        // setState(() {
                        //   showRecipePage = false;
                        //   showLunchalizePage = true;
                        //   showFavsPage = false;
                        // });
                        showLunchalizePageNow();
                      },
                      child:
                          Image.asset("assets/LCO.png", height: 150, width: 80),
                    ),
                    IconButton(
                      icon: Icon(Icons.star, color: uniColors.lcRed, size: 35),
                      onPressed: () {
                        // setState(() {
                        //   showRecipePage = false;
                        //   showLunchalizePage = false;
                        //   showFavsPage = true;
                        // });
                        showFavsPageNow();
                      },
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.person, color: uniColors.lcRed, size: 35),
                      onPressed: () {
                        // setState(() {
                        //   showRecipePage = false;
                        //   showLunchalizePage = false;
                        //   showFavsPage = true;
                        // });
                        showAccountPageNow();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          onSwipeUp: () => (showRecipePage)
              ? showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: uniColors.white1,
                  builder: (context) => RecipeMakerContainer(),
                )
              : {}

          // showModalBottomSheetCustom(
          //   //   isScrollControlled: true,
          //   context: context,
          //   //   backgroundColor: uniColors.white1,
          //   builder: (context) => RecipeMakerContainer(),
          // ),
          ),
    );
  }

  buildFilterGrid(User availableUsers) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(CupertinoPageRoute(
        //     builder: (context) =>
        //         AvailableUserDetail(selectedAvailableUser: availableUsers)));

        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  AvailableUserDetail(selectedAvailableUser: availableUsers)),
          (Route<dynamic> route) => false,
        );
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
                        image: (availableUsers.profilePhoto == null)
                            ? AssetImage("assets/defaultUserPicture.png")
                            : NetworkImage("${availableUsers.profilePhoto}"),
                        fit: BoxFit.cover),
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
                              color: uniColors.offline,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: availableUsers.name.length < 13
                                    ? Text(availableUsers.name,
                                        style: TextStyles.selfProfileRecipeName,
                                        textAlign: TextAlign.center)
                                    : Text(
                                        "${availableUsers.name.substring(0, 10)}...",
                                        style: TextStyles.selfProfileRecipeName,
                                        textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.done,
                              color: uniColors.online,
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

  void deletePicDialog(Recipe selfRecipeList) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        // title: new Text("Discard"),
        content: new Text("Do you want to delete this recipe?",
            style: TextStyles.recipe),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              _recipeMethods.deleteRecipeFromDb(selfRecipeList);
              refreshReci();
              Navigator.pop(context);
            },
            child: new Text("Yes", style: TextStyles.alertConfirmation),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: new Text("No", style: TextStyles.alertConfirmation),
          ),
        ],
      ),
    );
  }

  buildRecipeGrid(Recipe availableRecipes) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  RecipeDetails(selectedRecipe: availableRecipes)),
          (Route<dynamic> route) => false,
        );
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
              top: 1.0,
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: screenWidth * 0.45,
                  width: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                     bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    image: DecorationImage(
                        image: (availableRecipes.recipePicture ==
                                    "dummyNoImage" ||
                                availableRecipes.recipePicture == null)
                            ? AssetImage("assets/plate.jpg")
                            : NetworkImage("${availableRecipes.recipePicture}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 1.0,
                top: 146.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: screenWidth * 0.45,
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
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: (availableRecipes.recipeName == "" ||
                                        availableRecipes.recipeName == null)
                                    ? Text("LC RECIPE",
                                        style: TextStyles.selfProfileRecipeName,
                                        textAlign: TextAlign.center)
                                    : availableRecipes.recipeName.length <= 16
                                        ? Text(availableRecipes.recipeName,
                                            style: TextStyles
                                                .selfProfileRecipeName,
                                            textAlign: TextAlign.center)
                                        : Text(
                                            "${availableRecipes.recipeName.substring(0, 15)}...",
                                            style: TextStyles
                                                .selfProfileRecipeName,
                                            textAlign: TextAlign.center),
                              ),
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

  //recipe grid
  buildSelfRecipeGrid(Recipe selfRecipeList) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Stack(
        children: <Widget>[
          Container(
              //height: 250,
              // width: screenWidth / 1.75,
              color: uniColors.transparent),
          Positioned(
            left: 1.0,
            top: 1.0,
            child: Opacity(
              opacity: 1,
              child: GestureDetector( 
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            RecipeDetails(selectedRecipe: selfRecipeList)),
                    (Route<dynamic> route) => false,
                  );
                },
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: screenWidth / 3,
                    width: screenWidth / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      image: DecorationImage(
                          image: (selfRecipeList.recipePicture ==
                                      "dummyNoImage" ||
                                  selfRecipeList.recipePicture == null)
                              ? AssetImage("assets/plate.jpg")
                              : NetworkImage("${selfRecipeList.recipePicture}"),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 11.0,
              top: 120.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: screenWidth / 2.5,
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
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: (selfRecipeList.recipeName == "" ||
                                      selfRecipeList.recipeName == null)
                                  ? Text("LC RECIPE",
                                      style: TextStyles.selfProfileRecipeName,
                                      textAlign: TextAlign.left)
                                  : selfRecipeList.recipeName.length < 15
                                      ? Text(selfRecipeList.recipeName,
                                          style:
                                              TextStyles.selfProfileRecipeName,
                                          textAlign: TextAlign.left)
                                      : Text(
                                          "${selfRecipeList.recipeName.substring(0, 14)}...",
                                          style:
                                              TextStyles.selfProfileRecipeName,
                                          textAlign: TextAlign.left),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              deletePicDialog(selfRecipeList);
                            },
                            child: Icon(
                              Icons.delete,
                              color: uniColors.grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
