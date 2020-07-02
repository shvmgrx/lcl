import 'dart:io';
import 'package:lcl/models/message.dart';
import 'package:lcl/models/recipe.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/resources/firebase_methods.dart';
import 'package:geolocator/geolocator.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();
  Future<void> signOut() => _firebaseMethods.signOut();

  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseMethods.authenticateUser(user);

  Future<User> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<void> fetchLoggedUser(FirebaseUser user) =>
      _firebaseMethods.fetchLoggedUser(user);

  Future<List<User>> fetchBatch(FirebaseUser user) =>
      _firebaseMethods.fetchBatch(user);

   Future<List<Recipe>> fetchRecipeBatch() =>
      _firebaseMethods.fetchRecipeBatch();

  void uploadImage(
          {@required File image,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadImage(
          image, receiverId, senderId, imageUploadProvider);



  void changeProfilePhoto(
          {@required File image,
          @required ImageUploadProvider imageUploadProvider,
          @required FirebaseUser currentUser}) =>
      _firebaseMethods.changeProfilePhoto(
          image, imageUploadProvider, currentUser);

  // Future<void> updateDatatoDb(
  //         FirebaseUser user,
  //         String name,
  //         String username,
  //         String bio,
  //         bool isVegan,
  //         bool isVegetarian,
  //         bool isNVegetarian,
  //         String position,
  //         List languages,
  //         String profilePhoto) =>
  //     _firebaseMethods.updateDatatoDb(user, name, username, bio, isVegan,
  //         isVegetarian, isNVegetarian, position, languages, profilePhoto);

  Future<void> addMessageToDb(Message message, User sender, User receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  Future<void> addDataToDb(FirebaseUser user) =>
      _firebaseMethods.addDataToDb(user);



    Future<void> updateProfiletoDb(
    FirebaseUser currentUser,
    String name,
    String email,
    String username,
    String status,
    int state,
    String profilePhoto,
    String gender,
    String bio,
    String position,
    int age,
    int abusiveFlag,
    int usageFlag,
    List cuisines,
  ) =>
      _firebaseMethods.updateProfiletoDb(
          currentUser,
          name,
          email,
          username,
          status,
          state,
          profilePhoto,
          gender,
          bio,
          position,
          age,
          abusiveFlag,
          usageFlag,
          cuisines,
);
}
