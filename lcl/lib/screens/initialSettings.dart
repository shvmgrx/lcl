import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lcl/common/customAppBar.dart';
import 'package:lcl/models/settings.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/resources/settingsMethods.dart';
import 'package:lcl/ui_elements/settingsContainer.dart';
// import 'package:lcl/common/subscription_container.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:provider/provider.dart';
import 'dashboard_screen.dart';

class InitialSettings extends StatefulWidget {
  @override
  _InitialSettingsState createState() => _InitialSettingsState();
}

class _InitialSettingsState extends State<InitialSettings> {
  final GlobalKey<FormBuilderState> _settingsFormKey =
      GlobalKey<FormBuilderState>();

  FirebaseRepository _repository = FirebaseRepository();

  final SettingsMethods _settingsMethods = SettingsMethods();

  String loggedUserGender;
  int loggedUserAge1;
  double tempAge1;
  double tempAge2;
  String tempInterestedIn;
  int loggedUserAge2;
  int loggedUserDistance;
  int tempDistance;
  String loggedUserInterestedIn;
  String loggedUserMode;
  Position position;
  String loggedUserLat;
  String loggedUserLon;
  List loggedUserLang;

  int preSaveAge1;
  int preSaveAge2;
  int preSaveDist;
  List preSaveLang;
  String preSaveMode;

  void ageRangeMaker(value) {
    var a = value.toString();
    String b = a[12] + a[13];
    String c = a[18] + a[19];
    setState(() {
      preSaveAge1 = int.parse(b);
      preSaveAge2 = int.parse(c);
    });
  }

  void distanceMaker(value) {
    tempDistance = value.round();

    setState(() {
      preSaveDist = tempDistance;
    });
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

  void getLocation() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      position = currentPosition;
      loggedUserLat = position.latitude.toString();
      loggedUserLon = position.longitude.toString();
    });

    print(loggedUserLat);
    print(loggedUserLon);
  }

  @override
  Widget build(BuildContext context) {
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
          sInterestedIn: loggedUserInterestedIn,
          sMode: loggedUserMode,
          sLat: loggedUserLat,
          sLon: loggedUserLon,
          sLang: loggedUserLang);

      _settingsMethods.addSettingsToDb(_settings);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomAppBar(),

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  //this right here
                                  child: FormBuilder(
                                    key: _settingsFormKey,
                                    child: Expanded(
                                      child: Container(
                                        height: screenHeight * 0.542,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Image.asset(
                                                    "assets/ageGroup.jpg")),
                                            Center(
                                                child: Container(
                                              child: Text(
                                                  "${Strings.PREFERENCEDETAIL}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyles
                                                      .subHeadingDetail),
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: screenWidth * 0.13,
                                                    child: Text(
                                                        "${Strings.AGE}",
                                                        style: TextStyles
                                                            .settingHeading),
                                                  ),
                                                  Container(
                                                    width: screenWidth * 0.42,
                                                    child:
                                                        FormBuilderRangeSlider(
                                                      activeColor:
                                                          uniColors.lcRed,
                                                      attribute: "age",
                                                      // validators: [FormBuilderValidators.min(6)],
                                                      min: 18.0,
                                                      max: 99.0,
                                                      initialValue:
                                                          RangeValues(18, 25),
                                                      divisions: 81,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "",
                                                        focusColor:
                                                            Colors.yellow,
                                                      ),
                                                      displayValues:
                                                          DisplayValues.none,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          //recipeCalories = value.toString();
                                                          ageRangeMaker(value);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  (preSaveAge1 == null ||
                                                          preSaveAge2 == null)
                                                      ? Text(" 18-25",
                                                          style: TextStyles
                                                              .settingValue)
                                                      : Text(
                                                          " $preSaveAge1-$preSaveAge2",
                                                          style: TextStyles
                                                              .settingValue),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: screenWidth * 0.34,
                                                    child: Text(
                                                        "${Strings.INTERESTED_IN}",
                                                        style: TextStyles
                                                            .settingHeading),
                                                  ),
                                                  Container(
                                                    width: screenWidth * 0.42,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child:
                                                          FormBuilderDropdown(
                                                        attribute:
                                                            "loggedUserGender",
                                                        decoration:
                                                            InputDecoration(
                                                                labelText: ""),
                                                        items: [
                                                          'Men',
                                                          'Woman',
                                                          'Everyone'
                                                        ]
                                                            .map((interestedIn) =>
                                                                DropdownMenuItem(
                                                                    value:
                                                                        interestedIn,
                                                                    child: Text(
                                                                        "$interestedIn",
                                                                        style: TextStyles
                                                                            .settingValue)))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            loggedUserInterestedIn =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: screenWidth,
                                              height: 50,
                                              child: RaisedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      tempInterestedIn =
                                                          loggedUserInterestedIn;
                                                      tempInterestedIn =
                                                          loggedUserInterestedIn;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "${Strings.SAVE}",
                                                    style:
                                                        TextStyles.submitButton,
                                                  ),
                                                  color: uniColors.lcRed),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: SettingsContainer(
                      text: Strings.PARTNER_PREFERENCE,
                      imagePath: "assets/ageGroup.jpg",
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                //this right here
                                child: FormBuilder(
                                  key: _settingsFormKey,
                                  child: Expanded(
                                    child: Container(
                                      height: screenHeight * 0.4,
                                      width: screenWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Image.asset(
                                                  "assets/loc.jpg")),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Center(
                                                child: Container(
                                              child: Text(
                                                  "${Strings.DISTANCEDETAIL}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyles
                                                      .subHeadingDetail),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: screenWidth * 0.20,
                                                  child: Text(
                                                      "${Strings.DISTANCE}",
                                                      style: TextStyles
                                                          .settingHeading),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.42,
                                                  child: FormBuilderSlider(
                                                    activeColor:
                                                        uniColors.lcRed,
                                                    attribute: "distance",
                                                    // validators: [FormBuilderValidators.min(6)],
                                                    min: 1.0,
                                                    max: 200.0,
                                                    initialValue: 5,
                                                    divisions: 200,

                                                    decoration: InputDecoration(
                                                      labelText: "",
                                                    ),
                                                    displayValues:
                                                        DisplayValues.none,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        distanceMaker(value);

                                                        //  print(loggedUserDistance.runtimeType);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                preSaveDist == null
                                                    ? Text(" 5 km",
                                                        style: TextStyles
                                                            .settingValue)
                                                    : preSaveDist < 200
                                                        ? Text(
                                                            " $preSaveDist km",
                                                            style: TextStyles
                                                                .settingValue)
                                                        : Text(" Global",
                                                            style: TextStyles
                                                                .settingValue),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: screenWidth,
                                            height: 50,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    loggedUserDistance =
                                                        preSaveDist;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "${Strings.SAVE}",
                                                  style:
                                                      TextStyles.submitButton,
                                                ),
                                                color: uniColors.lcRed),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: SettingsContainer(
                    text: Strings.DISTANCE_PREFERENCE,
                    imagePath: "assets/loc.jpg",
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                //this right here
                                child: FormBuilder(
                                  key: _settingsFormKey,
                                  child: Expanded(
                                    child: Container(
                                      height: screenHeight * 0.492,
                                      width: screenWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Image.asset(
                                                  "assets/lang.jpg")),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Center(
                                                child: Container(
                                              child: Text(
                                                  "${Strings.LANGDETAIL}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyles
                                                      .subHeadingDetail),
                                            )),
                                          ),
                                          Center(
                                            child: Container(
                                              width: screenWidth * 0.72,
                                              child: FormBuilderFilterChip(
                                                attribute: 'languages',
                                                options: [
                                                  FormBuilderFieldOption(
                                                      value: 'English',
                                                      child: Text('English')),
                                                  FormBuilderFieldOption(
                                                      value: 'German',
                                                      child: Text('German')),
                                                  FormBuilderFieldOption(
                                                      value: 'Spanish',
                                                      child: Text('Spanish')),
                                                  FormBuilderFieldOption(
                                                      value: 'Chinese',
                                                      child: Text('Chinese')),
                                                  FormBuilderFieldOption(
                                                      value: 'French',
                                                      child: Text('French')),
                                                  FormBuilderFieldOption(
                                                      value: 'Russian',
                                                      child: Text('Russian')),
                                                  FormBuilderFieldOption(
                                                      value: 'Arabic',
                                                      child: Text('Arabic')),
                                                  FormBuilderFieldOption(
                                                      value: 'Portuguese',
                                                      child:
                                                          Text('Portuguese')),
                                                  FormBuilderFieldOption(
                                                      value: 'Japanese',
                                                      child: Text('Japanese')),
                                                  FormBuilderFieldOption(
                                                      value: 'Hindi',
                                                      child: Text('Hindi')),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    print(value);
                                                    preSaveLang = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: screenWidth,
                                            height: 50,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    loggedUserLang =
                                                        preSaveLang;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "${Strings.SAVE}",
                                                  style:
                                                      TextStyles.submitButton,
                                                ),
                                                color: uniColors.lcRed),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: SettingsContainer(
                    text: Strings.LANGUAGES,
                    imagePath: "assets/lang.jpg",
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                //this right here
                                child: FormBuilder(
                                  key: _settingsFormKey,
                                  child: Expanded(
                                    child: Container(
                                      height: screenHeight * 0.392,
                                      width: screenWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Image.asset(
                                                  "assets/conv.jpg")),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8, right: 8),
                                            child: Center(
                                                child: Container(
                                              child: Text(
                                                  "${Strings.MODEDETAIL}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyles
                                                      .subHeadingDetail),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: screenWidth * 0.30,
                                                  child: Text("${Strings.MODE}",
                                                      style: TextStyles
                                                          .settingHeading),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.42,
                                                  child: FormBuilderDropdown(
                                                    attribute:
                                                        "loggedUserGender",
                                                    decoration: InputDecoration(
                                                        labelText: ""),
                                                    items: [
                                                      'Friend Mode',
                                                      'Flirt Mode'
                                                    ]
                                                        .map((mode) => DropdownMenuItem(
                                                            value: mode,
                                                            child: Text("$mode",
                                                                style: TextStyles
                                                                    .settingValue)))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        preSaveMode = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: screenWidth,
                                            height: 50,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    loggedUserMode =
                                                        preSaveMode;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "${Strings.SAVE}",
                                                  style:
                                                      TextStyles.submitButton,
                                                ),
                                                color: uniColors.lcRed),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: SettingsContainer(
                    text: Strings.MODE_PREFERENCE,
                    imagePath: "assets/conv.jpg",
                  ),
                ),

                //   Padding(
                //     padding: const EdgeInsets.only(left:18.0,top:30),
                //     child: FlatButton(
                //     color: uniColors.backgroundGrey,

                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           children: <Widget>[
                //             SvgPicture.asset("assets/donateNew.svg",
                //               height: 30,
                //               width: 30,
                //               color: uniColors.online),
                //             Padding(
                //               padding: const EdgeInsets.only(left:15.0),
                //               child: Text(Strings.DONATE,style: TextStyles.donationTextStyle,),
                //             ),
                //           ],
                //         ),
                //       ),

                //     onPressed: () => {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => DashboardScreen(),
                //     //   ),
                //     // ),
                //     }
                // ),
                //   ),
              ],
            ),
            Positioned(
              bottom: 48,
              left: 16,
              child: Text(Strings.LAST_STEP_TO_ENJOY,
                  style: TextStyles.buttonTextStyle),
            ),
            Positioned(
              bottom: -30,
              right: -30,
              child: InkWell(
                onTap: () {
                  sendSettings();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: uniColors.lcRedLight),
                  child: Align(
                    alignment: Alignment(-0.4, -0.4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
