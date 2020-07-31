import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/models/settings.dart';
import 'package:lcl/models/user.dart';

import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/resources/settingsMethods.dart';
import 'package:lcl/screens/callScreens/pickup/pickup_layout.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:url_launcher/url_launcher.dart';


class EditSettings extends StatefulWidget {
  @override
  _EditSettingsState createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FirebaseRepository _repository = FirebaseRepository();

   final SettingsMethods _settingsMethods = SettingsMethods();

  final GlobalKey<FormBuilderState> _settingsFormKey = GlobalKey<FormBuilderState>();

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

  int loggedUserAge1;
  double tempAge1;
  double tempAge2;
  int loggedUserAge2;
  int loggedUserDistance;
  int tempDistance;
  String loggedUserInterestedIn;
  String loggedUserMode;
  Position position;
  String loggedUserLat;
  String loggedUserLon;

  void ageRangeMaker(value) {
    var a = value.toString();
    String b = a[12] + a[13];
    String c = a[18] + a[19];
    setState(() {
      loggedUserAge1 = int.parse(b);
      loggedUserAge2 = int.parse(c);
    });
  }

  void distanceMaker(value) {
    
  
  tempDistance=value.round();


    setState(() {
     loggedUserDistance = tempDistance;
    });
  }

    void getLocation() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      position = currentPosition;
      loggedUserLat=position.latitude.toString();
      loggedUserLon=position.longitude.toString();
    });

    print(loggedUserLat);
    print(loggedUserLon);


  }

   launchURL(String url) async {
 print(url);
    if (await canLaunch(url)) {
  
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
 }



  void initState() {
     getLocation();
    _repository.getCurrentUser().then((user) {
      _repository.fetchLoggedUser(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserGender = loggedUser['gender'];
        });
      });

      _repository.fetchLoggedUserSettings(user).then((dynamic loggedUser) {
        setState(() {
          loggedUserAge1 = loggedUser['sAge1'];
          loggedUserAge2 = loggedUser['sAge2'];
          loggedUserDistance = loggedUser['sDistance'];
          loggedUserInterestedIn = loggedUser['sInterestedIn'];
          loggedUserMode = loggedUser['sMode'];

          
        });
      });


    });

    super.initState();
  }

 

  User user = User();

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

      void sendSettings() async {
  
      Settings _settings = Settings(
        
        sId: userProvider.getUser.uid,
        sAge1: loggedUserAge1,
        sAge2: loggedUserAge2,
        sDistance: loggedUserDistance,
        sGender: loggedUserGender,
        sInterestedIn:loggedUserInterestedIn,
        sMode: loggedUserMode,
        sLat: loggedUserLat,
        sLon: loggedUserLon,
      );

      _settingsMethods.addSettingsToDb(_settings);
    }

    



    


    
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
 sendSettings();
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
                          style: TextStyles.pageHeading,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //AGE
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 40),
                        child: Column(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child:
                                  Row(
                                    children: <Widget>[
                                      Text("${Strings.AGE}:", style: TextStyles.settingHeading),
                                      (loggedUserAge1 == null || loggedUserAge2 == null) ? Text(" 18-25",style: TextStyles.settingValue):   Text(" $loggedUserAge1-$loggedUserAge2",style: TextStyles.settingValue),
                                    ],
                                  ),
                            ),
                          
                            Container(
                              width: screenWidth * 0.85,
                              child: FormBuilderRangeSlider(
                                activeColor: uniColors.lcRed,
                                attribute: "age",
                                // validators: [FormBuilderValidators.min(6)],
                                min: 18.0,
                                max: 99.0,
                                initialValue:RangeValues( 18,25) ,
                                divisions: 81,
                                decoration: InputDecoration(labelText: "",focusColor: Colors.yellow,),
                                displayValues:  DisplayValues.none,
                                onChanged: (value) {
                                  setState(() {
                                    //recipeCalories = value.toString();
                                    ageRangeMaker(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 40),
                        child: Column(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  //Uncomment this asap
                                  Text("${Strings.DISTANCE}:",style: TextStyles.settingHeading),
                                loggedUserDistance==null? Text(" 5 km",style: TextStyles.settingValue): loggedUserDistance<200?  Text(" $loggedUserDistance km",style: TextStyles.settingValue):Text(" Global",style: TextStyles.settingValue),
                                ],
                              ),
                            ),
                           
                            Container(
                              width: screenWidth * 0.85,
                              child: FormBuilderSlider(
                                activeColor: uniColors.lcRed,
                                attribute: "distance",
                                // validators: [FormBuilderValidators.min(6)],
                                min: 1.0,
                                max: 200.0,
                                initialValue: 2,
                                divisions: 200,
                                
                                decoration: InputDecoration(labelText: "",),
                                displayValues:  DisplayValues.none,
                                onChanged: (value) {
                                  setState(() {
                                   distanceMaker(value);
                                    //  print(loggedUserDistance.runtimeType);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 30),
                        child: Column(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text("${Strings.INTERESTED_IN}: ",
                                      style: TextStyles.settingHeading),
                                     loggedUserInterestedIn==null? Text("Everyone",style: TextStyles.settingValue):   Text("$loggedUserInterestedIn",style: TextStyles.settingValue),
                                ],
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.85,
                              child: FormBuilderDropdown(
                                
                                attribute: "loggedUserGender",
                                decoration: InputDecoration(labelText: ""),
                                items: ['Men', 'Women', 'Everyone']
                                    .map((interestedIn) => DropdownMenuItem(
                                        value: interestedIn, child: Text("$interestedIn",)))
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    loggedUserInterestedIn = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //MODE
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 30),
                        child: Column(
              
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child:
                                  Row(
                                    children: <Widget>[
                                      Text("${Strings.MODE}: ", style: TextStyles.settingHeading),
                                       loggedUserMode==null? Text("Friend Mode",style: TextStyles.settingValue):   Text("$loggedUserMode",style: TextStyles.settingValue),
                                    ],
                                  ),
                            ),
                           
                            Container(
                              width: screenWidth * 0.85,
                              child: FormBuilderDropdown(
                                attribute: "loggedUserGender",
                                decoration: InputDecoration(labelText: ""),
                                items: ['Friend Mode', 'Flirt Mode']
                                    .map((mode) => DropdownMenuItem(
                                        value: mode, child: Text("$mode")))
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    loggedUserMode = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                   
                      Align(
                        heightFactor: 1.5,
                                              child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: FractionalOffset.bottomCenter,
                              height: screenHeight / 5,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.10),
                                   BlendMode.srcATop,
                                  ),
                                  image: AssetImage("assets/donateCrop.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 1,
                              bottom: 46,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, top: 30),
                                        child: FlatButton(

                                              color: uniColors.backgroundGrey,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                        "assets/donateNew.svg",
                                                        height: 30,
                                                        width: 30,
                                                        color: uniColors.lcRed),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: Text(
                                                        Strings.DONATE,
                                                        style: TextStyles
                                                            .donationTextStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () => {
                                              
                                             
                                         launchURL("https://www.welthungerhilfe.de/spenden/'")
                                       
                                            
                                                   
                                                  }),
                                      ),
                                    ))
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
                //    
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
