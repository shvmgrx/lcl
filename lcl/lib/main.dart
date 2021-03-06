import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/provider/user_provider.dart';
import 'package:lcl/screens/aboutScreen.dart';
import 'package:lcl/screens/availableUserDetail.dart';
import 'package:lcl/screens/chatScreens/chatScreen.dart';
import 'package:lcl/screens/communityGuidelines.dart';
import 'package:lcl/screens/dashboard_screen.dart';
import 'package:lcl/screens/editProfile.dart';
import 'package:lcl/screens/editSettings.dart';
import 'package:lcl/screens/initialSettings.dart';
import 'package:lcl/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/login_screen.dart';
import 'package:lcl/screens/onboardingScreens.dart/onboardingScreen.dart';
import 'package:lcl/screens/pageviews/chat_list_screen.dart';
import 'package:lcl/screens/splashScreen.dart';
import 'package:lcl/screens/termsScreen.dart';
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
    
  //   _repository.signOut();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
          child: MaterialApp(
        title: "Lunchalize",
        debugShowCheckedModeBanner: false,
                initialRoute: "/",
        routes: {
          '/landing_screen': (context) => LandingScreen(),
          '/dashboard_screen': (context) => DashboardScreen(),
          '/available_userDetail_screen': (context) => AvailableUserDetail(),
          '/login_screen': (context) => LoginScreen(),
          '/edit_profile_screen': (context) => EditProfile(),
          '/edit_settings_screen': (context) => EditSettings(),
           '/chatList_screen': (context) => ChatListScreen(),
           '/initial_screen': (context) => InitialSettings(),
           '/splash_screen': (context) => SplashScreen(),
           '/about_screen': (context) => AboutScreen(),
           '/terms_screen': (context) => TermsScreen(),
           '/community_guidelines_screen': (context) => CommunityGuidelines(),
           '/onboarding_screen': (context) => OnBoardingScreen(),
           
        },
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

