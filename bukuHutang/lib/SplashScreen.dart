//Screen to check if user already loggedIn or not

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bukuHutang/home.dart';
import 'package:flutter/material.dart';
import 'package:bukuHutang/authscreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

@override
class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //User _user;
  @override
  void initState() {
    super.initState();
    //initializeUser();
    navigateUser();
  }

  //Future initializeUser() async {
  //final User firebaseUser = FirebaseAuth.instance.currentUser;
  //await firebaseUser.reload();
  //User _user = _auth.currentUser;
  // get User authentication status here
  //}

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      //FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Mainpage(
                    username: _auth.currentUser.displayName,
                    email: _auth.currentUser.email,
                    photo: _auth.currentUser.photoURL)),
            (Route<dynamic> route) => false),
      );
    } else {
      Timer(
          Duration(seconds: 4),
          () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AuthScreen()),
              (Route<dynamic> route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.greenAccent,
              size: 50.0,
            )),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.greenAccent,
        nextScreen: AuthScreen(),
      ),
    );
  }
}
