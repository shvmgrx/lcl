import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/user.dart';

import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/utilities.dart';
import 'package:provider/provider.dart';
import 'package:lcl/utils/uniColors.dart';

class EditSettings extends StatefulWidget {
  @override
  _EditSettingsState createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _portionKey = GlobalKey<FormBuilderState>();

  FirebaseRepository _repository = FirebaseRepository();

  final GlobalKey<FormBuilderState> _settingsFormKey =
      GlobalKey<FormBuilderState>();

  bool _autoValidate = false;
  ImageUploadProvider _imageUploadProvider;
  File tempProfilePicture;
  String tempProfilePictureUrl;

  FirebaseUser loggedUser;

  String loggedUserName;
  int loggedUserAge;
  String loggedUserGender;
  String loggedUserBio;
  List loggedUserCategory;
  String loggedUserProfilePhoto;

  String loggedUserEmail;
  String loggedUserUsername;
  String loggedUserStatus;
  int loggedUserState;

  String loggedUserPosition;

  int loggedUserAbusiveFlag;
  int loggedUserUsageFlag;

  void pickProfilePhoto({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);

    _repository.getCurrentUser().then((user) {
      _repository.changeProfilePhoto(
          image: selectedImage,
          imageUploadProvider: _imageUploadProvider,
          currentUser: user);
    });
  }

  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserName = loggedUser['name'];
          loggedUserEmail = loggedUser['email'];
          loggedUserUsername = loggedUser['username'];
          loggedUserStatus = loggedUser['status'];
          loggedUserState = loggedUser['state'];
          loggedUserProfilePhoto = loggedUser['profile_photo'];
          loggedUserGender = loggedUser['gender'];
          loggedUserBio = loggedUser['bio'];
          loggedUserPosition = loggedUser['position'];
          loggedUserAge = loggedUser['age'];
          loggedUserAbusiveFlag = loggedUser['abusiveFlag'];
          loggedUserUsageFlag = loggedUser['usageFlag'];
          loggedUserCategory = loggedUser['cuisines'];
        });
      });
    });

    super.initState();
  }

  StorageReference _storageReference;
  Future<String> uploadImageToStorage(File tempRecipePicture) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask storageUploadTask =
          _storageReference.putFile(tempRecipePicture);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

      return url;
    } catch (e) {
      return null;
    }
  }

  Future<File> pickImage({@required ImageSource source}) async {
    File selectedProPic = await Utils.pickImage(source: source);

    //File compImgHigh;
    //   File compImgLow;

    // compImgLow = await compressImageLow(selectedImg);

    setState(() {
      tempProfilePicture = selectedProPic;
    });

    // // compImgHigh = await compressImageHigh(selectedImg);

    tempProfilePictureUrl = await uploadImageToStorage(tempProfilePicture);

    setState(() {
      loggedUserProfilePhoto = tempProfilePictureUrl;
    });
  }

  static final Firestore firestore = Firestore.instance;

  User user = User();

  void updateProfileDataToDb() {
    _settingsFormKey.currentState.save();
    _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.updateProfiletoDb(
        user,
        loggedUserName,
        loggedUserEmail,
        loggedUserUsername,
        loggedUserStatus,
        loggedUserState,
        loggedUserProfilePhoto,
        loggedUserGender,
        loggedUserBio,
        loggedUserPosition,
        loggedUserAge,
        loggedUserAbusiveFlag,
        loggedUserUsageFlag,
        loggedUserCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return PickupLayout(
      scaffold: Scaffold(
        key: _scaffoldKey,
        backgroundColor: uniColors.backgroundGrey,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // updateProfileDataToDb();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: uniColors.lcRed,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          Strings.EDIT_SETTINGS,
                          style: TextStyles.editProfile,
                        )
                      ],
                    ),
                  ),
                ),
                FormBuilder(
                  key: _settingsFormKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      //AGE
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top:10),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child:
                                  Text(Strings.AGE, style: TextStyles.recipe),
                            ),
                            SizedBox(width: 65),
                            Container(
                              width: screenWidth * 0.65,
                              child: FormBuilderRangeSlider(
                                attribute: "age",
                                // validators: [FormBuilderValidators.min(6)],
                                min: 18.0,
                                max: 100.0,
                                initialValue:RangeValues(18, 25),
                                divisions:82,                        
                                decoration: InputDecoration(labelText: ""),
                                onChanged: (value) {
                                  setState(() {
                                    //recipeCalories = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top:10),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.DISTANCE,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: screenWidth * 0.65,
                              child: FormBuilderSlider(
                                attribute: "distance",
                                // validators: [FormBuilderValidators.min(6)],
                                min: 0.0,
                                max: 200.0,
                                initialValue: 5.0,
                                divisions: 200,
                                decoration: InputDecoration(labelText: ""),
                                onChanged: (value) {
                                  setState(() {
                                    //recipeCalories = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 30),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.INTERESTED_IN,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 40),
                            Container(
                              width: screenWidth * 0.45,
                              child: FormBuilderDropdown(
                                attribute: "loggedUserGender",
                                decoration: InputDecoration(labelText: ""),
                                // initialValue: loggedUserGender != null
                                //     ? loggedUserGender
                                //     : "",
                                //  hint: Text('Select Gender'),
                                // validators: [FormBuilderValidators.required()],
                                items: ['Men', 'Woman', 'Non-binary', 'Others']
                                    .map((gender) => DropdownMenuItem(
                                        value: gender, child: Text("$gender")))
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    //loggedUserGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //MODE
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 30),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child:
                                  Text(Strings.MODE, style: TextStyles.recipe),
                            ),
                            SizedBox(width: 40),
                            Container(
                              width: screenWidth * 0.45,
                              child: FormBuilderDropdown(
                                attribute: "loggedUserGender",
                                decoration: InputDecoration(labelText: ""),
                                // initialValue: loggedUserGender != null
                                //     ? loggedUserGender
                                //     : "",
                                //  hint: Text('Select Gender'),
                                // validators: [FormBuilderValidators.required()],
                                items: ['Friend Mode', 'Flirt Mode']
                                    .map((gender) => DropdownMenuItem(
                                        value: gender, child: Text("$gender")))
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    //  loggedUserGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 200),
                      // ListTile(
                      //   title: new Text(
                      //     "Privacy Policy",
                      //     style: TextStyle(
                      //         color: uniColors.standardBlack,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16),
                      //   ),
                      //   trailing: new Icon(
                      //     Icons.description,
                      //     color: uniColors.standardBlack,
                      //   ),
                      //   onTap: () {
                      //    // Navigator.of(context).pop();
                      //     //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                      //   }),
                      //   ListTile(
                      //   title: new Text(
                      //     "Licenses",
                      //     style: TextStyle(
                      //         color: uniColors.standardBlack,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16),
                      //   ),
                      //   trailing: new Icon(
                      //     Icons.description,
                      //     color: uniColors.standardBlack,
                      //   ),
                      //   onTap: () {
                      //    // Navigator.of(context).pop();
                      //     //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                      //   }),
                      // ListTile(
                      //   title: new Text(
                      //     "Terms of Service",
                      //     style: TextStyle(
                      //         color: uniColors.standardBlack,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16),
                      //   ),
                      //   trailing: new Icon(
                      //     Icons.description,
                      //     color: uniColors.standardBlack,
                      //   ),
                      //   onTap: () {
                      //    // Navigator.of(context).pop();
                      //     //  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));
                      //   }),
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: FractionalOffset.bottomCenter,
                            height: screenHeight / 5,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.70),
                BlendMode.srcATop,
              ),
                                image: AssetImage("assets/donateCrop.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
       
                          ),
                          Positioned(
                            left: 1,
                            bottom: 50,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                  padding: const EdgeInsets.only(left:18.0,top:30),
                  child: FlatButton(
                  color: uniColors.backgroundGrey,
                 
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset("assets/donateNew.svg",
                            height: 30,
                            width: 30,
                            color: uniColors.online),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(Strings.DONATE,style: TextStyles.donationTextStyle,),
                          ),
                        ],
                      ),
                    ),
                 
                  onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DashboardScreen(),
                  //   ),
                  // ),
                  }
              ),
                ),
            
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: <Widget>[
                //     MaterialButton(
                //       child: Text("Submit"),
                //       onPressed: () {
                //         if (_settingsFormKey.currentState.saveAndValidate()) {
                //           print(_settingsFormKey.currentState.value);
                //         }
                //       },
                //     ),
                //     MaterialButton(
                //       child: Text("Reset"),
                //       onPressed: () {
                //         _settingsFormKey.currentState.reset();
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
