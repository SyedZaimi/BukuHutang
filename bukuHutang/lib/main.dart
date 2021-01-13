import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bukuHutang/home.dart';
import 'package:bukuHutang/SplashScreen.dart';
import 'package:bukuHutang/owepage.dart';
import 'package:bukuHutang/debtpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Buku Hutang';

    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/SplashScreen',
        routes: {
          '/SplashScreen': (context) => SplashScreen(),
          '/home': (context) => Mainpage(
                username: null,
              ),
          '/second': (context) => Debtpage(),
          '/third': (context) => Owepage(),
        });
  }
}
