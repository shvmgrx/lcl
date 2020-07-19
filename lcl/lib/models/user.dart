import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;
  String gender;
  String bio;
  String position;
  int age;
  int abusiveFlag;
  int usageFlag;
  List languages;
  List cuisines;

  User({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
    this.gender,
    this.bio,
    this.position,
    this.age,
    this.abusiveFlag,
    this.usageFlag,
    this.languages,
    this.cuisines,
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["status"] = user.status;
    data["state"] = user.state;
    data["profile_photo"] = user.profilePhoto;
    data["gender"] = user.gender;
    data["bio"] = user.bio;
    data["position"] = user.position;
    data["age"] = user.age;
    data["abusiveFlag"] = user.abusiveFlag;
    data["usageFlag"] = user.usageFlag;
    data["languages"] = user.languages;
    data["cuisines"] = user.cuisines;

    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profile_photo'];
    this.gender = mapData['gender'];
    this.bio = mapData['bio'];
    this.position = mapData['position'];
    this.age = mapData['age'];
    this.abusiveFlag= mapData['abusiveFlag'];
    this.usageFlag= mapData['usageFlag'];
    this.languages= mapData['languages'];
    this.cuisines= mapData['cuisines'];
  }
}