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

  Future<List<Recipe>> fetchSelfRecipeBatch(String currentUserId) =>
      _firebaseMethods.fetchSelfRecipeBatch(currentUserId);

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
    FirebaseUser user,
    String loggedUserName,
    String loggedUserEmail,
    String loggedUserUsername,
    String loggedUserStatus,
    int loggedUserState,
    String loggedUserProfilePhoto,
    String loggedUserGender,
    String loggedUserBio,
    String loggedUserPosition,
    int loggedUserAge,
    int loggedUserAbusiveFlag,
    int loggedUserUsageFlag,
    List loggedUserCategory,
  ) =>
      _firebaseMethods.updateProfiletoDb(
        user,
        loggedUserName,
        loggedUserEmail,
        loggedUserUsername,
        loggedUserStatus,
        loggedUserState,
        loggedUserProfilePhoto,
        loggedUserGender,
        loggedUserBio,
        loggedUserPosition,
        loggedUserAge,
        loggedUserAbusiveFlag,
        loggedUserUsageFlag,
        loggedUserCategory,
      );
}
