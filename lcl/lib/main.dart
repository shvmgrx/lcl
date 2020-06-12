import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/screens/landing_screen.dart';
import 'package:flutter/material.dart';
  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
          child: MaterialApp(
        title: "Lunchalize",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _repository.getCurrentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return DashboardScreen();
            } else {
              return LandingScreen();
            }
          },
        ),
      ),
    );
  }
}

