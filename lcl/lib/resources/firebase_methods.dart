import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/models/message.dart';
import 'package:lcl/models/recipe.dart';
import 'package:lcl/models/settings.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/utils/utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  StorageReference _storageReference;

  static final Firestore _firestore = Firestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  final CollectionReference _settingsCollection = _firestore.collection(SETTINGS_COLLECTION);


  //user class
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();

    return User.fromMap(documentSnapshot.data);
  }

  

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = result.user;
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<DocumentSnapshot> fetchLoggedUser(FirebaseUser currentUser) async {
    user = User(
      uid: currentUser.uid,
    );
    DocumentSnapshot documentSnapshot = await firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .get();

    return documentSnapshot;
  }

    Future<DocumentSnapshot> fetchLoggedUserSettings(FirebaseUser currentUser) async {
    user = User(
      uid: currentUser.uid,
    );
    DocumentSnapshot documentSnapshot = await firestore
        .collection(SETTINGS_COLLECTION)
        .document(currentUser.uid)
        .get();


    return documentSnapshot;
  }

  Future<List<User>> fetchBatch(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

    Future<User> fetchUserById(String userId) async {
    User wantedUser = User();

  DocumentSnapshot documentSnapshot =
        await _userCollection.document(userId).get();

    return User.fromMap(documentSnapshot.data);
   
  }


  Future<List<Recipe>> fetchRecipeBatch() async {
    List<Recipe> recipeList = List<Recipe>();

    QuerySnapshot querySnapshot =
        await firestore.collection(RECIPE_COLLECTION).getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      recipeList.add(Recipe.fromMap(querySnapshot.documents[i].data));
    }
    return recipeList;
  }

    Future<List<Recipe>> fetchRecipeBatchById(String userId) async {
    List<Recipe> recipeIdList = List<Recipe>();

    QuerySnapshot querySnapshot =
        await firestore
        .collection(RECIPE_COLLECTION)
        .where(USER_ID, isEqualTo: userId)
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      recipeIdList.add(Recipe.fromMap(querySnapshot.documents[i].data));
    }
    return recipeIdList;
  }

      Future<String> fetchUserNameById(String userId) async {
   String personName;
  final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);
   DocumentSnapshot documentSnapshot =
        await _userCollection.document(userId).get();

       personName = documentSnapshot.data['name'];

        print("yayaya: $personName");


    return personName;
  }




   Future<List<Recipe>> fetchSelfRecipeBatch(String currentUserId) async {
    List<Recipe> userRecipeList = List<Recipe>();

    QuerySnapshot querySnapshot =
        await 
        firestore
        .collection(RECIPE_COLLECTION)
        .where(USER_ID, isEqualTo: user.uid)
        .getDocuments();

    for (var i = 0; i < querySnapshot.documents.length; i++) {
      userRecipeList.add(Recipe.fromMap(querySnapshot.documents[i].data));
    }
    return userRecipeList;
  }

    

    Future<void> addSettingsToDb(Settings setting) async {
    var map = setting.toMap(setting);
    _firestore.collection(SETTINGS_COLLECTION).document(setting.sId).setData(map);
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

      return url;
    } catch (e) {
      return null;
    }
  }

  void setProfilePhoto(String url, FirebaseUser currentUser) async {
    print("Url received for setting:");

    user = User(uid: currentUser.uid, profilePhoto: url);
    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .updateData(user.toMap(user));
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: MESSAGE_TYPE_IMAGE,
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  void uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    setImageMsg(url, receiverId, senderId);
  }

  void changeProfilePhoto(File image, ImageUploadProvider imageUploadProvider,
      FirebaseUser currentUser) async {
    // Set some loading value to db and show it to user
    //imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    // imageUploadProvider.setToIdle();
    print("Url sending for setting:");

    setProfilePhoto(url, currentUser);
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoUrl,
        username: username,
        age: 18,
        );

    firestore
        .collection(USERS_COLLECTION)
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection(MESSAGES_COLLECTION)
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<void> signOut() async {
    print("signed out start");
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<void> updateProfiletoDb(
    FirebaseUser loggedUser,
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
  ) async {
    user = User(
      uid: user.uid,
      name: loggedUserName,
      email: loggedUserEmail,
      username: loggedUserUsername,
      status: loggedUserStatus,
      state: loggedUserState,
      profilePhoto: loggedUserProfilePhoto,
      gender: loggedUserGender,
      bio: loggedUserBio,
      position: loggedUserPosition,
      age: loggedUserAge,
      abusiveFlag: loggedUserAbusiveFlag,
      usageFlag: loggedUserUsageFlag,
      cuisines: loggedUserCategory,
    );

    firestore
        .collection(USERS_COLLECTION)
        .document(loggedUser.uid)
        .updateData(user.toMap(user));
  }
}
