import 'package:bukuHutang/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  Profile({Key key, @required this.username,@required this.email}) : super(key: key);
  final String username;
  final String email;
  @override
ProfileState createState() => ProfileState();
}


class ProfileState extends State<Profile> {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(

           title: Text("Profile"),
          backgroundColor: Colors.green,
        
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
                              'https://lh3.googleusercontent.com/-OLMjcwoWPHk/XLaSAjx6nWI/AAAAAAAABdo/R1KdIo5aNYgO1OI2RGo9t1yMxSTTEJxvwCEwYBhgLKtMDAL1OcqwJ5dhLvF25Swdb84dmTm0ArjHWqRQnTgunDxqxXcP-kD4AanPTAqJRfmsvv8nkXTm-L-6Dcc1qJguOfyTFpDECGTwfoX2hFhjhVYskM5FzRGDZzblED5_Gsa7uQm-7PMN5jUh_MBFyCddwX7OOuSMR2Dh-JXd9-5NUONrkaKeLitz88wlWQ8OCq1iGBWhNFTV599OPKHG81MudDVtpoaZTHUsMSsYe6vpGqxWjFbszQ5JB5jAju5jnf5Q4ahd1ZOU1IcGcdlQRZwxrgfpcPot088WL6kZVrVotDhVKcRIRe5JkOIqsDhN0TrF-KKLm4WOP_rFB3qC5E4SYazO0oAOoxC5mfD-P5EZs6Hw2yVtK3qFMtMoNVOQE6xM-GL6d584HGl8hbULxRVGVhyOp10999IKuE21Iw0alEWP2cl4YKEDUTVMzaKaFBB6k7EMHnV_vsAyAK-jx7e2frNgxJnae80yQJc6PbAn50Lt-JfroPo_QaAZp1NBMAseIS0wNLlkdBJN2bGy0qtTvAy27aQsOoCccixYZXU02x2k-cm-hA-CogSBSW0V_9HOP_wxp85C-Bo8nAgd2SJXmKaDLVMWEuWScL8P79XNDUQ7dNR4w_-T8_wU/w140-h140-p/1721823%2527.jpg'),
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
                    'Your total balance : RM 200',
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
                  color: Colors.green,
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
