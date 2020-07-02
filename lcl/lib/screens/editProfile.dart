import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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

  FirebaseUser loggedUser;

  String loggedUserName;
  int loggedUserAge;
  String loggedUserGender;
  String loggedUserBio;
  List loggedUserCategory;
  String loggedUserProfilePhoto;
  // String loggedUserDisplayName;
  // String loggedUserEmail;
  // String loggedUserUserName;
  // String loggedUserStatus;
  // int loggedUserState;
  // String loggedUserProfilePic;
  // int loggedUseranswerPrice1;
  // int loggedUseranswerPrice2;
  // int loggedUseranswerPrice3;
  // int loggedUseranswerDuration;
  // String loggedUserBio;
  // bool loggedUserisInfCert;
  // int loggedUsermaxQuestionCharcount;
  // int loggedUserRating;
  // String loggedUserCategory;
  // int loggedUserReviews;
  // int loggedUserinfWorth;
  // int loggedUserinfSent;
  // int loggedUserinfReceived;
  // bool loggedUserisInfluencer;
  // String loggedUserHashtags;

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
          loggedUserAge = loggedUser['age'];
          loggedUserGender = loggedUser['gender'];
          loggedUserBio = loggedUser['bio'];
          loggedUserCategory = loggedUser['cuisines'];


        });
      });
    });

    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user) {
      loggedUserProfilePhoto = user.photoUrl;
    
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
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _settingsFormKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      //NAME
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top:20),
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
                        padding: const EdgeInsets.only(left: 10.0,top:20),
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
                                initialValue: 18,
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
                         padding: const EdgeInsets.only(left: 10.0,top:20),
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
                                // initialValue: 'Male',
                              //  hint: Text('Select Gender'),
                                // validators: [FormBuilderValidators.required()],
                                items: [
                                  'Male',
                                  'Female',
                                  'Other',
                                  'Prefer not to say'
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
                        padding: const EdgeInsets.only(left: 10.0,top:20),
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
                        padding: const EdgeInsets.only(left: 10.0,top:15),
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
                                options: [
                                  FormBuilderFieldOption(
                                      child: Text("Vegan"), value: "Vegan"),
                                  FormBuilderFieldOption(
                                      child: Text("Vegetarian"), value: "Vegetarian"),
                                  FormBuilderFieldOption(
                                      child: Text("Non-Vegetarian"), value: "Non-Vegetarian"),
                                  FormBuilderFieldOption(
                                      child: Text("Keto"), value: "Keto"),
                                   FormBuilderFieldOption(
                                      child: Text("Organic"), value: "Organic"),
                                   FormBuilderFieldOption(
                                      child: Text("Healthy Eater"), value: "Healthy Eater"),
                                   FormBuilderFieldOption(
                                      child: Text("Lactose-free"), value: "Lactose-free"),
                                   FormBuilderFieldOption(
                                      child: Text("Gluten-free"), value: "Gluten-free"),
                                    FormBuilderFieldOption(
                                      child: Text("Gourmet"), value: "Gourmet"),
                                   FormBuilderFieldOption(
                                      child: Text("Chef Pro"), value: "Chef Pro"),
                                  FormBuilderFieldOption(
                                      child: Text("Sweet Tooth"), value: "Sweet Tooth"),
                                  FormBuilderFieldOption(
                                      child: Text("Raw"), value: "Raw"),
                                  FormBuilderFieldOption(
                                      child: Text("Paleo"), value: "Paleo"),
                                  FormBuilderFieldOption(
                                      child: Text("Intermittent Fasting"), value: "Intermittent Fasting"),
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

                      SizedBox(height: 200),
                      FormBuilderDateTimePicker(
                        attribute: "date",
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration:
                            InputDecoration(labelText: "Appointment Time"),
                      ),
                      FormBuilderSlider(
                        attribute: "slider",
                        validators: [FormBuilderValidators.min(6)],
                        min: 0.0,
                        max: 10.0,
                        initialValue: 1.0,
                        divisions: 20,
                        decoration:
                            InputDecoration(labelText: "Number of things"),
                      ),
                      FormBuilderCheckbox(
                        attribute: 'accept_terms',
                        label: Text(
                            "I have read and agree to the terms and conditions"),
                        validators: [
                          FormBuilderValidators.requiredTrue(
                            errorText:
                                "You must accept terms and conditions to continue",
                          ),
                        ],
                      ),
                      FormBuilderDropdown(
                        attribute: "gender",
                        decoration: InputDecoration(labelText: "Gender"),
                        // initialValue: 'Male',
                        hint: Text('Select Gender'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                                value: gender, child: Text("$gender")))
                            .toList(),
                      ),
                      FormBuilderTextField(
                        attribute: "age",
                        decoration: InputDecoration(labelText: "Age"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(70),
                        ],
                      ),
                      FormBuilderSegmentedControl(
                        decoration:
                            InputDecoration(labelText: "Movie Rating (Archer)"),
                        attribute: "movie_rating",
                        options: List.generate(5, (i) => i + 1)
                            .map((number) =>
                                FormBuilderFieldOption(value: number))
                            .toList(),
                      ),
                      FormBuilderSwitch(
                        label: Text('I Accept the tems and conditions'),
                        attribute: "accept_terms_switch",
                        initialValue: true,
                      ),
                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: "Stepper"),
                        attribute: "stepper",
                        initialValue: 10,
                        step: 1,
                      ),
                      FormBuilderCheckboxList(
                        decoration: InputDecoration(
                            labelText: "The language of my people"),
                        attribute: "languages",
                        initialValue: ["Dart"],
                        options: [
                          FormBuilderFieldOption(value: "Dart"),
                          FormBuilderFieldOption(value: "Kotlin"),
                          FormBuilderFieldOption(value: "Java"),
                          FormBuilderFieldOption(value: "Swift"),
                          FormBuilderFieldOption(value: "Objective-C"),
                        ],
                      ),
                      FormBuilderChoiceChip(
                        attribute: "favorite_ice_cream",
                        options: [
                          FormBuilderFieldOption(
                              child: Text("Vanilla"), value: "vanilla"),
                          FormBuilderFieldOption(
                              child: Text("Chocolate"), value: "chocolate"),
                          FormBuilderFieldOption(
                              child: Text("Strawberry"), value: "strawberry"),
                          FormBuilderFieldOption(
                              child: Text("Peach"), value: "peach"),
                        ],
                      ),
                      FormBuilderFilterChip(
                        attribute: "pets",
                        options: [
                          FormBuilderFieldOption(
                              child: Text("Cats"), value: "cats"),
                          FormBuilderFieldOption(
                              child: Text("Dogs"), value: "dogs"),
                          FormBuilderFieldOption(
                              child: Text("Rodents"), value: "rodents"),
                          FormBuilderFieldOption(
                              child: Text("Birds"), value: "birds"),
                        ],
                      ),
                      FormBuilderSignaturePad(
                        decoration: InputDecoration(labelText: "Signature"),
                        attribute: "signature",
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_settingsFormKey.currentState.saveAndValidate()) {
                          print(_settingsFormKey.currentState.value);
                        }
                      },
                    ),
                    MaterialButton(
                      child: Text("Reset"),
                      onPressed: () {
                        _settingsFormKey.currentState.reset();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        // Form(
        //   key: _formKey,
        //   autovalidate: _autoValidate,
        //   child: ListView(
        //     children: <Widget>[
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           Align(
        //             alignment: Alignment.topLeft,
        //             child: IconButton(
        //               icon: Icon(
        //                 Icons.close,
        //                 color: uniColors.grey2,
        //               ),
        //               onPressed: () {
        //                 Navigator.pushReplacement(context,
        //                     MaterialPageRoute(builder: (context) {
        //                   return DashboardScreen();
        //                 }));
        //               },
        //             ),
        //           ),
        //           Align(
        //             alignment: Alignment.center,
        //             child:  Text(
        //                         Strings.APP_NAME,
        //                         style: TextStyles.appNameTextStyle,
        //                       ),
        //             // GradientText("FAVEEZ",
        //             //     gradient: LinearGradient(colors: [
        //             //       UniversalVariables.gold1,
        //             //       UniversalVariables.gold2,
        //             //       UniversalVariables.gold3,
        //             //       UniversalVariables.gold4
        //             //     ]),
        //             //     style: TextStyles.appNameLogoStyle,
        //             //     textAlign: TextAlign.center),
        //           ),
        //           Align(
        //             alignment: Alignment.topRight,
        //             child: IconButton(
        //               icon: Icon(
        //                 Icons.done,
        //                 color: uniColors.grey2,
        //               ),
        //               onPressed: () {
        //                 if (!_formKey.currentState.validate()) {
        //                   return;
        //                 }

        //                 _formKey.currentState.save();

        //                 // _repository.getCurrentUser().then((FirebaseUser user) {

        //                 //   _repository.updateProfiletoDb(
        //                 //     user,
        //                 //     loggedUserDisplayName,
        //                 //     loggedUserEmail,
        //                 //     loggedUserUserName,
        //                 //     loggedUserStatus,
        //                 //     loggedUserState,
        //                 //     loggedUserProfilePic,
        //                 //     loggedUseranswerPrice1,
        //                 //     loggedUseranswerPrice2,
        //                 //     loggedUseranswerPrice3,
        //                 //     loggedUseranswerDuration,
        //                 //     loggedUserBio,
        //                 //     loggedUserisInfCert,
        //                 //     loggedUsermaxQuestionCharcount,
        //                 //     loggedUserRating,
        //                 //     loggedUserCategory,
        //                 //     loggedUserReviews,
        //                 //     loggedUserinfWorth,
        //                 //     loggedUserinfSent,
        //                 //     loggedUserinfReceived,
        //                 //     loggedUserisInfluencer,
        //                 //     loggedUserHashtags,
        //                 //   );
        //                 // });

        //                 Navigator.pushNamed(context, "/dashboard_screen");
        //               },
        //             ),
        //           )
        //         ],
        //       ),
        //       SizedBox(height: 25),
        //       // CupertinoButton(child: Text("Squueze"), onPressed: ()=>{
        //       //    print(_imageUploadProvider.runtimeType)
        //       // }),
        //       Center(
        //         child: Container(
        //           child: Column(
        //             children: <Widget>[
        //               Container(
        //                 //add image here

        //                 child: Container(
        //                   width: 160.0,
        //                   height: 160.0,
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     image: DecorationImage(
        //                       fit: BoxFit.cover,
        //                       image: NetworkImage(loggedUserProfilePic != null
        //                           ? loggedUserProfilePic
        //                           : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Crystal_Clear_kdm_user_female.svg/1200px-Crystal_Clear_kdm_user_female.svg.png"),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 child: OutlineButton(
        //                   onPressed: () => {
        //                     //buttonDisabled
        //                     //pickProfilePhoto(source: ImageSource.gallery),
        //                   },
        //                   child: Text(
        //                     "Change Profile Picture",
        //                     style: TextStyles.editHeadingName,
        //                   ),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(15.0),
        //                 child: Container(
        //                   child: Column(
        //                     children: <Widget>[
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                         children: <Widget>[
        //                           Expanded(
        //                             flex: 3,
        //                             child: Text("Name:",
        //                                 style: TextStyles.editHeadingName,
        //                                 textAlign: TextAlign.left),
        //                           ),
        //                           Expanded(
        //                             flex: 5,
        //                             child: TextField(
        //                               cursorColor: uniColors.gold2,
        //                               decoration: InputDecoration(
        //                                 contentPadding:
        //                                     EdgeInsets.only(bottom: 10),
        //                                 hintText: loggedUserDisplayName,
        //                                 hintStyle: TextStyles.hintTextStyle,
        //                               ),
        //                               maxLength: 20,
        //                               style: TextStyles.whileEditing,
        //                               // validator: (String value) {
        //                               //   if (value.isEmpty) {
        //                               //     return 'Name is Required';
        //                               //   }

        //                               //   return null;
        //                               // },
        //                               onChanged: (String value) {
        //                                 setState(() {
        //                                   loggedUserDisplayName = value;
        //                                 });
        //                               },
        //                             ),
        //                           )
        //                           // Text(loggedUserDisplayName)
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                         children: <Widget>[
        //                           Expanded(
        //                             flex: 3,
        //                             child: Text("Username:",
        //                                 style: TextStyles.editHeadingName,
        //                                 textAlign: TextAlign.left),
        //                           ),
        //                           Expanded(
        //                             flex: 5,
        //                             child: TextFormField(
        //                               cursorColor: uniColors.lcRed,
        //                               decoration: InputDecoration(
        //                                 contentPadding:
        //                                     EdgeInsets.only(bottom: 10),
        //                                 hintText: loggedUserUserName,
        //                                 hintStyle: TextStyles.hintTextStyle,
        //                               ),
        //                               maxLength: 10,
        //                               style: TextStyles.whileEditing,
        //                               // validator: (String value) {

        //                               //   if (value.isEmpty) {
        //                               //     return 'Enter username';
        //                               //   }
        //                               //   return null;
        //                               // },
        //                               onChanged: (String value) {
        //                                 setState(() {
        //                                   loggedUserUserName = value;
        //                                   _autoValidate = true;
        //                                 });
        //                               },
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                         children: <Widget>[
        //                           Expanded(
        //                             flex: 3,
        //                             child: Text("Bio:",
        //                                 style: TextStyles.editHeadingName,
        //                                 textAlign: TextAlign.left),
        //                           ),
        //                           Expanded(
        //                             flex: 5,
        //                             child: TextField(
        //                               cursorColor: uniColors.lcRed,
        //                               decoration: InputDecoration(
        //                                 contentPadding:
        //                                     EdgeInsets.only(bottom: 10),
        //                                 hintText: loggedUserBio,
        //                                 hintStyle: TextStyles.hintTextStyle,
        //                               ),
        //                               maxLength: 120,
        //                               style: TextStyles.whileEditing,
        //                               // validator: (String value) {
        //                               //   if (value.isEmpty) {
        //                               //     return 'Enter bio';
        //                               //   }

        //                               //   return null;
        //                               // },
        //                               onChanged: (String value) {
        //                                 setState(() {
        //                                   loggedUserBio = value;
        //                                 });
        //                               },
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                       // Row(
        //                       //   children: <Widget>[
        //                       //     Expanded(
        //                       //       flex: 3,
        //                       //       child: Column(
        //                       //         crossAxisAlignment: CrossAxisAlignment.start,
        //                       //         children: <Widget>[
        //                       //           Text("Text Reply Price:",
        //                       //               style: TextStyles.editHeadingName,
        //                       //               textAlign: TextAlign.left),
        //                       //               SizedBox(height:5),
        //                       //           // Text("\$${loggedUseranswerPrice1*0.65} (post-charges)",
        //                       //           //     style: TextStyles.postCommissionsPrice,
        //                       //           //     textAlign: TextAlign.left),

        //                       //         ],
        //                       //       ),
        //                       //     ),
        //                       //     Expanded(
        //                       //       flex: 5,
        //                       //       child: TextField(
        //                       //           cursorColor: UniversalVariables.gold2,
        //                       //           decoration: InputDecoration(
        //                       //             contentPadding:
        //                       //                 EdgeInsets.only(bottom: 10),
        //                       //             hintText: '\$$loggedUseranswerPrice1',
        //                       //             hintStyle: TextStyles.hintTextStyle,
        //                       //           ),
        //                       //           keyboardType: TextInputType.number,
        //                       //           style: TextStyles.whileEditing,
        //                       //           inputFormatters: <TextInputFormatter>[
        //                       //             WhitelistingTextInputFormatter
        //                       //                 .digitsOnly
        //                       //           ],
        //                       //           maxLength: 9,
        //                       //           onChanged: (input) => {
        //                       //                 loggedUseranswerPrice1 =
        //                       //                     num.tryParse(input)
        //                       //               }),
        //                       //     )
        //                       //   ],
        //                       // ),
        //                       // Row(
        //                       //   children: <Widget>[
        //                       //     Expanded(
        //                       //       flex: 3,
        //                       //       child: Column(
        //                       //         crossAxisAlignment: CrossAxisAlignment.start,
        //                       //         children: <Widget>[
        //                       //           Text("Video Reply Price:",
        //                       //               style: TextStyles.editHeadingName,
        //                       //               textAlign: TextAlign.left),
        //                       //                SizedBox(height:5),
        //                       //           // Text("\$${loggedUseranswerPrice2*0.65} (post-charges)",
        //                       //           //     style: TextStyles.postCommissionsPrice,
        //                       //           //     textAlign: TextAlign.left),
        //                       //         ],
        //                       //       ),
        //                       //     ),
        //                       //     Expanded(
        //                       //       flex: 5,
        //                       //       child: TextField(
        //                       //           cursorColor: UniversalVariables.gold2,
        //                       //           decoration: InputDecoration(
        //                       //             contentPadding:
        //                       //                 EdgeInsets.only(bottom: 10),
        //                       //             hintText: '\$$loggedUseranswerPrice2',
        //                       //             hintStyle: TextStyles.hintTextStyle,
        //                       //           ),
        //                       //           keyboardType: TextInputType.number,
        //                       //           style: TextStyles.whileEditing,
        //                       //           inputFormatters: <TextInputFormatter>[
        //                       //             WhitelistingTextInputFormatter
        //                       //                 .digitsOnly
        //                       //           ],
        //                       //           maxLength: 9,
        //                       //           onChanged: (input) => {
        //                       //                 loggedUseranswerPrice2 =
        //                       //                     num.tryParse(input)
        //                       //               }),
        //                       //     )
        //                       //   ],
        //                       // ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                         children: <Widget>[
        //                           Expanded(
        //                             flex: 3,
        //                             child: Text("Hashtags:",
        //                                 style: TextStyles.editHeadingName,
        //                                 textAlign: TextAlign.left),
        //                           ),
        //                           Expanded(
        //                             flex: 5,
        //                             child: TextField(
        //                               cursorColor: uniColors.lcRed,
        //                               decoration: InputDecoration(
        //                                 contentPadding:
        //                                     EdgeInsets.only(bottom: 10),
        //                                 hintText: loggedUserHashtags,
        //                                 hintStyle: TextStyles.hintTextStyle,
        //                               ),
        //                               maxLength: 120,
        //                               style: TextStyles.whileEditing,
        //                               // validator: (String value) {
        //                               //   if (value.isEmpty) {
        //                               //     return 'Enter bio';
        //                               //   }

        //                               //   return null;
        //                               // },
        //                               onChanged: (String value) {
        //                                 setState(() {
        //                                   loggedUserHashtags = value;
        //                                 });
        //                               },
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
