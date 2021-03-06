//Authentication screen

//import 'package:bukuHutang/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bukuHutang/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

String name;
String email;
String photo;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isVisible = false;

  Future<User> _signIn() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    // final AuthResult authResult = await auth.signInWithCredential(credential);
    // final User user = authResult.user;
    //Create a new document for user with the uid
    //final FirebaseUser _user;
    User user;
    //await _auth.signInWithCredential(credential);
    //_user = await _auth.currentUser();
    //await DatabaseService(uid: user.uid).updateUserData('0', 100);

    user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      name = user.displayName;
      email = user.email;
      photo = user.photoURL;
      /*firestore
          .collection("users")
          .document(user.uid)
          .setData(user.toMap(user));*/
    }
    return user;
  }

  /*Future<bool> isNewUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    return docs.length == 0 ? true : false;
  }*/

  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(color: Colors.greenAccent),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Buku Hutang',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFAFAFA)),
                        ),
                        visible: isVisible,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 50.0,
                    ),
                    child: Align(
                      alignment: Alignment(0, 0.5),
                      child: SizedBox(
                        height: 54.0,
                        width: swidth / 1.45,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              this.isVisible = true;
                            });

                            _signIn().whenComplete(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Mainpage(
                                          username:
                                              _auth.currentUser.displayName,
                                          email: _auth.currentUser.email,
                                          photo: _auth.currentUser.photoURL)),
                                  (Route<dynamic> route) => false);
                            }).catchError((onError) {
                              Navigator.pushReplacementNamed(context, "/auth");
                            });
                          },
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          elevation: 5,
                          color: Color(0xFFFAFAFA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])
    ]));
  }
}
