import 'package:flutter/material.dart';

class Debtpage extends StatefulWidget {
  Debtpage({Key key}) : super(key: key);
  @override
  DebtpageState createState() {
    return DebtpageState();
  }
}

class DebtpageState extends State<Debtpage> {
  @override
  Map debt = <String, double>{
    "Abdul Rahman": 12,
    "Abdul d": 13,
    "Abdul Rwwahman": 14,
    "Abdul Rahaman": 15,
  };
  Widget build(BuildContext context) {
    final appTitle = 'People who you owe: ';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: ListView.builder(
        itemCount: debt.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((debt['Abdul Rahman']).toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
