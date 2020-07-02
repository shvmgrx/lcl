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
  bool isOnline;
  String city;
  int age;
  int abusiveFlag;
  int usageFlag;
  String pic1;
  String pic2;
  String pic3;
  List languages;
  List cuisines;
  bool isVegan;
  bool isVegetarian;
  bool isNVegetarian;


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
    this.isOnline,
    this.city,
    this.age,
    this.abusiveFlag,
    this.usageFlag,
    this.pic1,
    this.pic2,
    this.pic3,
    this.languages,
    this.cuisines,
    this.isVegan,
    this.isVegetarian,
    this.isNVegetarian
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
    data["isOnline"] = user.isOnline;
    data["city"] = user.city;
    data["age"] = user.age;
    data["abusiveFlag"] = user.abusiveFlag;
    data["usageFlag"] = user.usageFlag;
    data["pic1"] = user.pic1;
    data["pic2"] = user.pic2;
    data["pic3"] = user.pic3;
    data["languages"] = user.languages;
    data["cuisines"] = user.cuisines;
    data["isVegan"] = user.isVegan;
    data["isVegetarian"] = user.isVegetarian;
    data["isNVegetarian"] = user.isNVegetarian;
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
    this.isOnline = mapData['isOnline'];
    this.city = mapData['city'];
    this.age = mapData['age'];
    this.abusiveFlag= mapData['abusiveFlag'];
    this.usageFlag= mapData['usageFlag'];
    this.pic1= mapData['pic1'];
    this.pic2= mapData['pic2'];
    this.pic3= mapData['pic3'];
    this.languages= mapData['languages'];
    this.cuisines= mapData['cuisines'];
    this.isVegan= mapData['isVegan'];
    this.isVegetarian= mapData['isVegetarian'];
    this.isNVegetarian= mapData['isNVegetarian'];
  }
}