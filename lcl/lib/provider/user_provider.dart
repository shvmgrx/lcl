
import 'package:flutter/widgets.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/resources/authMethods.dart';



class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();


  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}