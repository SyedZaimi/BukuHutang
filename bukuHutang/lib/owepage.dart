import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('owe');

class Owepage extends StatefulWidget {
  Owepage({Key key}) : super(key: key);
  @override
  OwepageState createState() {
    return OwepageState();
  }
}

class OwepageState extends State<Owepage> {
  Future<void> addUser(String name, double amount) {
    return users
        .add({
          'name': name,
          'amount': amount,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
                Text('Input name and amount: '),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  onChanged: (text) {
                    _setName(text);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                  onChanged: (text) {
                    _setAmount(text);
                  },
                  keyboardType: TextInputType.number,
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
              ? Text('Loading')
              : ListView(
                  children: snapshot.data.docs.map((documents) {
                    return new ListTile(
                      title: new Text(documents.data()['name'].toString()),
                      subtitle: new Text(documents.data()['amount'].toString()),
                    );
                  }).toList(),
                );
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
