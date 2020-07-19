import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/settings.dart';

class SettingsMethods {
  static final Firestore _firestore = Firestore.instance;
  static final Firestore firestore = Firestore.instance;

  final CollectionReference _settingsCollection =
      _firestore.collection(SETTINGS_COLLECTION);

  Future<void> addSettingsToDb(Settings setting) async {
    var map = setting.toMap(setting);
    _firestore
        .collection(SETTINGS_COLLECTION)
        .document(setting.sId)
        .setData(map);
  }

  Future<void> updateSettingsToDb(Settings setting) async {
    var map = setting.toMap(setting);
    _firestore
        .collection(SETTINGS_COLLECTION)
        .document(setting.sId)
        .updateData(map);
  }

//     Future<Settings> fetchUserSettingsById() async {

// Settings userSettings;
//     QuerySnapshot querySnapshot =
//         await firestore.collection(SETTINGS_COLLECTION).getDocuments();

//     for (var i = 0; i < querySnapshot.documents.length; i++) {
//     //  recipeList.add(Recipe.fromMap(querySnapshot.documents[i].data));
//     }
//     return userSettings;
//   }

}
