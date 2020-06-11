import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/utils/utilities.dart';


class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  //user class
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
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
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

    Future<DocumentSnapshot> fetchLoggedUser(FirebaseUser currentUser) async {
    user = User(
      uid: currentUser.uid,
    );
    DocumentSnapshot documentSnapshot =
        await firestore.collection("users").document(currentUser.uid).get();

    return documentSnapshot;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoUrl,
        username: username);

    firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

    Future<void> updateDatatoDb(
      FirebaseUser currentUser,
      String name,
      String username,
      String bio,
      bool isVegan,
      bool isVegetarian,
      bool isNVegetarian,
      String position,
      List languages,
      String profilePhoto) async {
        user = User(
        uid: currentUser.uid,
        name: name,
        username: username,
        bio: bio,
        isVegan:isVegan,
        isVegetarian:isVegetarian,
         isNVegetarian:isNVegetarian,
        position:position,
        languages: languages,
        profilePhoto: profilePhoto);

    firestore
        .collection("users")
        .document(currentUser.uid)
        .updateData(user.toMap(user));
  }

    Future<void> signOut() async {
    print("signed out start");
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }







}