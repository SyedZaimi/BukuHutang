import 'package:bukuHutang/authscreen.dart';
import 'package:bukuHutang/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mainpage extends StatefulWidget {
  Mainpage(
      {Key key,
      @required this.username,
      @required this.email,
      @required this.photo})
      : super(key: key);
  final String username;
  final String email;
  final String photo;
  @override
  MainpageState createState() => MainpageState();
}

class MainpageState extends State<Mainpage> {
  double sumdebt = 0;
  double sumowe = 0;

  Color dark = Color(0xff006a4e);
  Color darklight = Color(0xff2e856e);
  Color medium = Color(0xff5ca08e);
  Color light = Color(0xff8abaae);
  Color lightest = Color(0xffb8d6cd);

  @override
  initState() {
    super.initState();
    queryValues();
    queryValues2();
  }

  void queryValues() {
    FirebaseFirestore.instance
        .collection('debts')
        .snapshots()
        .listen((snapshot) {
      double tempTotal =
          snapshot.docs.fold(0, (tot, doc) => tot + doc.data()['amount']);
      setState(() {
        sumdebt = tempTotal;
      });
      debugPrint(sumdebt.toString());
    });
  }

  void queryValues2() {
    FirebaseFirestore.instance.collection('owe').snapshots().listen((snapshot) {
      double tempTotal =
          snapshot.docs.fold(0, (tot, doc) => tot + doc.data()['amount']);
      setState(() {
        sumowe = tempTotal;
      });
      debugPrint(sumowe.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //title: Text('Buku Hutangmu'),

          title: Text("Hi " + widget.username),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            username: widget.username,
                            email: widget.email,
                            photo: widget.photo)));
              },
            ),
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
            Container(height: 150),
            Container(
                margin: EdgeInsets.all(20),
                child:
                    Text('Your total debt: RM' + sumdebt.toStringAsFixed(2))),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Total money people owe you: RM' +
                    sumowe.toStringAsFixed(2))),
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
                    })),
          ],
        )));
  }
}
