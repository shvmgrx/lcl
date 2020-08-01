import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/enum/cropState.dart';
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

class CommunityGuidelines extends StatefulWidget {
  @override
  _CommunityGuidelinesState createState() => _CommunityGuidelinesState();
}

class _CommunityGuidelinesState extends State<CommunityGuidelines> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return PickupLayout(
      scaffold: Scaffold(
          key: _scaffoldKey,
          backgroundColor: uniColors.backgroundGrey,
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
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
                            Strings.COMMUNITY_GUIDELINES,
                            style: TextStyles.editProfile,
                          )
                        ],
                      ),
                    ),
                  ),

                Center(child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(Strings.CG0, style: TextStyles.cgText),
                  )),
                  Center(child: Padding(
                     padding: const EdgeInsets.only(left:12,top:15.0,right:12),
                    child: Text(Strings.CG1, style: TextStyles.aboutSubText),
                  )),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(Strings.CG2, style: TextStyles.cgText),
                  )),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(left:12,top:15.0,right:12),
                    child: Text(Strings.CG3, style: TextStyles.aboutSubText),
                  )),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text(Strings.CG4, style: TextStyles.cgText),
                  )),
                  Center(child: Padding(
                     padding: const EdgeInsets.only(left:12,top:15.0,right:12),
                    child: Text(Strings.CG5, style: TextStyles.aboutSubText),
                  )),
                  
          
 
                  
                ],
                
              ),
            ),
          ),),
    );
  }
}
