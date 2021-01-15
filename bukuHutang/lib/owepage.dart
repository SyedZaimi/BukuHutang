import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_form_field/date_form_field.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users =
    FirebaseFirestore.instance.collection('owe');

class Owepage extends StatefulWidget {
  Owepage({Key key}) : super(key: key);
  @override
  OwepageState createState() {
    return OwepageState();
  }
}

class OwepageState extends State<Owepage> {
  Future<void> addUser(String name, double amount, String date) {
    return users
        .add({'name': name, 'amount': amount, 'date': date})
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
    String _date = "";
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(2100);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final _formKey = GlobalKey<FormState>();
    final amountFocusNode = FocusNode();
    final nameFocusNode = FocusNode();

    void _setName(String name) {
      setState(() {
        _name = name;
      });
    }

    void _setDate(String date) {
      setState(() {
        _date = date;
      });
    }

    void _setAmount(String amount) {
      setState(() {
        _amount = double.tryParse(amount) ?? 0.0;
      });
    }

    Future<DateTime> showPicker() async {
      DateTime date = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );

      return date;
    }

    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Add Data", textAlign: TextAlign.center),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text('Input name and amount: '),
                    ),
                    Container(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  _setName(text);
                                },
                                focusNode: nameFocusNode,
                                keyboardType: TextInputType.text,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(nameFocusNode);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Amount',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  _setAmount(text);
                                },
                                focusNode: amountFocusNode,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(amountFocusNode);
                                },
                              ),
                              SizedBox(height: 20.0),
                              DateFormField(
                                format: 'EEEE, MMM, d yyyy',
                                showPicker: showPicker,
                                onDateChanged: (DateTime date) {
                                  String newdate = formatter.format(date);
                                  _setDate(newdate);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Date',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                    ),
                    Column(children: <Widget>[
                      new FlatButton(
                        child: new Text("Add"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            addUser(_name, _amount, _date);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]),
                  ],
                ),
              ));
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
                            content: Text("Data with " +
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
                                  .toStringAsFixed(2) +
                              '\n Date: ' +
                              snapshot.data.docs[index].data()['date'])),
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
