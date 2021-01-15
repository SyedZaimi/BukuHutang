import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bukuHutang/home.dart';
import 'package:bukuHutang/SplashScreen.dart';
import 'package:bukuHutang/owepage.dart';
import 'package:bukuHutang/debtpage.dart';
import 'package:bukuHutang/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color dark = Color(0xff006a4e);
  Color darklight = Color(0xff2e856e);
  Color medium = Color(0xff5ca08e);
  Color light = Color(0xff8abaae);
  Color lightest = Color(0xffb8d6cd);
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Buku Hutang';

    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => Mainpage(
                username: null,
                email: null,
                photo: null,
              ),
          '/second': (context) => Debtpage(),
          '/third': (context) => Owepage(),
          '/profile': (context) => Profile(
                username: null,
                email: null,
                photo: null,
              ),
        });
  }
}
