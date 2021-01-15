import 'package:bukuHutang/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
Profile({Key key, @required this.username,@required this.email,@required this.photo}) : super(key: key);
  final String username;
  final String email;
  final String photo;
  @override
ProfileState createState() => ProfileState();
}


class ProfileState extends State<Profile> {

Color dark = Color(0xff006a4e);
Color darklight = Color(0xff2e856e);
Color medium = Color(0xff5ca08e);
Color light = Color(0xff8abaae);
Color lightest = Color(0xffb8d6cd);

  double sumdebt=0;
  double sumowe=0;
  double total=0;

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
      double tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + doc.data()['amount']);
      setState(() {sumdebt = tempTotal;});
      debugPrint(sumdebt.toString());
    });
  }

  void queryValues2() {
    FirebaseFirestore.instance
        .collection('owe')
        .snapshots()
        .listen((snapshot) {
      double tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + doc.data()['amount']);
      setState(() {sumowe = tempTotal;});
      debugPrint(sumowe.toString());
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(

           title: Text("Profile"),
          backgroundColor:dark,
        
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dark, darklight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 82.0,
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage(
                              widget.photo),
                        ),
                      ),
                     
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  
                ],
              ),
            ),

            Container(
              height: 350,
             
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                   Text(
                    ('Your balance :  '+ (sumowe-sumdebt).toStringAsFixed(2)),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),

                 FlatButton(
                  color: dark,
                   textColor: Colors.white,
                   disabledColor: Colors.grey,
                   disabledTextColor: Colors.black,
                   padding: EdgeInsets.all(10.0),
                   splashColor: Colors.blueAccent,
                  onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false);
              },
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 20.0),
                                ),
                            )
            
                  
                ],
              ),
            ),
          ],
        )
      );
  }
}