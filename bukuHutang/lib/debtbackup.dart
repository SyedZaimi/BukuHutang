import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('debts');

class Debtpage extends StatefulWidget {
  Debtpage({Key key}) : super(key: key);
  @override
  DebtpageState createState() {
    return DebtpageState();
  }
}

class DebtpageState extends State<Debtpage> {
  Future<void> addUser(String name, double amount) {
    return users
        .add({
          'name': name,
          'amount': amount,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteUser(docID) {
    users.doc(docID).delete().catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'People who you owe: ';
    String _name = "";
    double _amount = 0;

    void _setName(String name) {
      setState(() {
        _name = name;
      });
    }

    void _setAmount(String amount) {
      setState(() {
        _amount = double.tryParse(amount) ?? 0.0;
      });
    }

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Add debt", textAlign: TextAlign.center),
            content: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text('Input name and amount: '),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    onChanged: (text) {
                      _setName(text);
                    },
                  ),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount',
                    ),
                    onChanged: (text) {
                      _setAmount(text);
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Add"),
                onPressed: () {
                  addUser(_name, _amount);
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Text('PLease Wait')
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(snapshot.data.docs[index].toString()),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        deleteUser(snapshot.data.docs[index].id);
                        // Then show a snackbar.
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Debt with " +
                                snapshot.data.docs[index]
                                    .data()['name']
                                    .toString() +
                                ' deleted!')));
                      },
                      background: Container(
                        child: Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      child: new ListTile(
                          title: new Text(snapshot.data.docs[index]
                              .data()['name']
                              .toString()),
                          subtitle: new Text('RM' +
                              snapshot.data.docs[index]
                                  .data()['amount']
                                  .toStringAsFixed(2))),
                    );
                  });
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog();
        },
      ),
    );
  }
}
