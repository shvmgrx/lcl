import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                            updateProfileDataToDb();
                          
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
                          Strings.EDIT_PROFILE,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          //add image here

                          child: Stack(
                            children: <Widget>[
                              loggedUserProfilePhoto == "notUploadedYet"
                                  ? Container(
                                      width: 160.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/defaultUserPicture.png"),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 160.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              loggedUserProfilePhoto),
                                        ),
                                      ),
                                    ),
                              Positioned(
                                top: 126,
                                bottom: 0,
                                right: 9,
                                child: InkWell(
                                  onTap: () {
                                    pickImage(source: ImageSource.gallery);
                                  },
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 43,
                                    color: uniColors.lcRed,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //NAME
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.LOGGEDUSER_NAME,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 55),
                            Container(
                              width: screenWidth * 0.45,
                              child: FormBuilderTextField(
                                initialValue: loggedUserName != null
                                    ? loggedUserName
                                    : "",
                                attribute: "loggedUserName",
                                //    decoration:InputDecoration(labelText: "Recipe Name",helperStyle: TextStyles.recipe),
                                keyboardType: TextInputType.text,
                                validators: [
                                  // FormBuilderValidators.
                                  FormBuilderValidators.max(25),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    loggedUserName = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //AGE
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.LOGGEDUSER_AGE,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 65),
                            Container(
                              width: screenWidth * 0.45,
                              child: FormBuilderTouchSpin(
                                // decoration: InputDecoration(labelText: "Stepper"),
                                attribute: "loggedUserAge",
                                initialValue:
                                    loggedUserAge != null ? loggedUserAge : 18,
                                min: 18,
                                step: 1,

                                onChanged: (value) {
                                  setState(() {
                                    loggedUserAge = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //GENDER
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.LOGGEDUSER_GENDER,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 35),
                            Container(
                              width: screenWidth * 0.45,
                              child: FormBuilderDropdown(
                                attribute: "loggedUserGender",
                                decoration: InputDecoration(labelText: ""),
                                initialValue: loggedUserGender != null
                                    ? loggedUserGender
                                    : "",
                                //  hint: Text('Select Gender'),
                                // validators: [FormBuilderValidators.required()],
                                items: [
                                  'Male',
                                  'Female',
                                  'Non-Binary',
                                  'Transgender',
                                  'Other'
                                ]
                                    .map((gender) => DropdownMenuItem(
                                        value: gender, child: Text("$gender")))
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    loggedUserGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Bio
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.LOGGEDUSER_BIO,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 70),
                            Container(
                              width: screenWidth * 0.70,
                              child: FormBuilderTextField(
                                initialValue:
                                    loggedUserBio != null ? loggedUserBio : "",
                                attribute: "loggedUserBio",
                                //    decoration:InputDecoration(labelText: "Recipe Name",helperStyle: TextStyles.recipe),
                                keyboardType: TextInputType.multiline,

                                onChanged: (value) {
                                  setState(() {
                                    loggedUserBio = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Category
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 15),
                        child: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(Strings.LOGGEDUSER_CATEGORY,
                                  style: TextStyles.recipe),
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: screenWidth * 0.70,
                              child: FormBuilderFilterChip(
                                attribute: "loggedUserCategory",
                                initialValue: loggedUserCategory != null
                                    ? loggedUserCategory
                                    : null,
                                options: [
                                  FormBuilderFieldOption(
                                      child: Text("Vegan"), value: "Vegan"),
                                  FormBuilderFieldOption(
                                      child: Text("Vegetarian"),
                                      value: "Vegetarian"),
                                  FormBuilderFieldOption(
                                      child: Text("Non-Vegetarian"),
                                      value: "Non-Vegetarian"),
                                  FormBuilderFieldOption(
                                      child: Text("Keto"), value: "Keto"),
                                  FormBuilderFieldOption(
                                      child: Text("Organic"), value: "Organic"),
                                  FormBuilderFieldOption(
                                      child: Text("Healthy Eater"),
                                      value: "Healthy Eater"),
                                  FormBuilderFieldOption(
                                      child: Text("Lactose-free"),
                                      value: "Lactose-free"),
                                  FormBuilderFieldOption(
                                      child: Text("Gluten-free"),
                                      value: "Gluten-free"),
                                  FormBuilderFieldOption(
                                      child: Text("Gourmet"), value: "Gourmet"),
                                  FormBuilderFieldOption(
                                      child: Text("Chef Pro"),
                                      value: "Chef Pro"),
                                  FormBuilderFieldOption(
                                      child: Text("Sweet Tooth"),
                                      value: "Sweet Tooth"),
                                  FormBuilderFieldOption(
                                      child: Text("Raw"), value: "Raw"),
                                  FormBuilderFieldOption(
                                      child: Text("Paleo"), value: "Paleo"),
                                  FormBuilderFieldOption(
                                      child: Text("Intermittent Fasting"),
                                      value: "Intermittent Fasting"),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    loggedUserCategory = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
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
