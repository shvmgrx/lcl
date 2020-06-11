import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lcl/resources/firebase_methods.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();
  Future<void> signOut() => _firebaseMethods.signOut();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> fetchLoggedUser(FirebaseUser user) =>
      _firebaseMethods.fetchLoggedUser(user);
  Future<void> updateDatatoDb(
          FirebaseUser user,
          String name,
          String username,
          String bio,
          bool isVegan,
          bool isVegetarian,
          bool isNVegetarian,
          String position,
          List languages,
          String profilePhoto) =>
      _firebaseMethods.updateDatatoDb(user, name, username, bio, isVegan,
          isVegetarian, isNVegetarian, position,languages, profilePhoto);

  Future<void> addDataToDb(FirebaseUser user) =>
      _firebaseMethods.addDataToDb(user);
}
