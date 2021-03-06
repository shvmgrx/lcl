
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcl/enum/userState.dart';

class Utils {
  static String getUsername(String email) {

    return "lc:${email.split('@')[0]}";

  }


   static Future<File> pickImage({@required ImageSource source}) async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 700.0, maxHeight: 700.0);

    _image = File(pickedFile.path);

    return _image;
  }

    static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

   static String randomString() {
        var rand = new Random();
        var codeUnits = new List.generate(9, (index) {
          return rand.nextInt(33) + 89;
        });

        return new String.fromCharCodes(codeUnits);
      }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
     switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
}