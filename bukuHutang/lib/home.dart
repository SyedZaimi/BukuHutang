//import 'package:bukuHutang/HutangOrang.dart';
//import 'package:bukuHutang/OrangHutang.dart';
//import 'package:bukuHutang/signup_google.dart';
import 'package:bukuHutang/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BukuHutang',
      // MaterialApp contains our top-level Navigator
      initialRoute: '/Screens/login_screen',
      routes: {
        //'/Screens/login': (BuildContext context) => LoginPage(),
        '/Screens/login_screen': (BuildContext context) => LoginScreen(),
        //'/Screens/signup_google': (BuildContext context) => SignInDemo(),
        //'/hutangOrang': (BuildContext context) => HutangOrang(),
        //'/orangHutang': (BuildContext context) => OrangHutang(),
      },
    );
  }
}
