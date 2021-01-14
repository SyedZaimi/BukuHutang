//Screen to check if user already loggedIn or not

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bukuHutang/home.dart';
import 'package:bukuHutang/profile.dart';
import 'package:flutter/material.dart';
import 'package:bukuHutang/authscreen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

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
                builder: (context) =>
                    Mainpage(username: _auth.currentUser.displayName)),
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
    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.black),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.greenAccent,
                        size: 50.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "BukuHutang",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
