//Hompage of the apps

import 'package:bukuHutang/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mainpage extends StatefulWidget {
  Mainpage({Key key, @required this.username}) : super(key: key);
  final String username;
  @override
  MainpageState createState() => MainpageState();
}

class MainpageState extends State<Mainpage> {
  double debt =
      50000; //sinila kene link ngan database ye uolls nak dpt kan total
  double owe = 110000000000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text('Buku Hutangmu'),
          title: Text("Hi " + widget.username),
          leading: Icon(Icons.person),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Your total debt: RM' + debt.toString())),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Total money people owe you: RM' + owe.toString())),
            Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    child: Text('People you owe'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/second');
                    })),
            Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    child: Text('People who owe you'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/third');
                    }))
          ],
        )));
  }
}


