//Screen to check list of debtors

import 'package:flutter/material.dart';

class Owepage extends StatefulWidget {
  Owepage({Key key}) : super(key: key);
  @override
  OwepageState createState() {
    return OwepageState();
  }
}

class OwepageState extends State<Owepage> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'People who owe you: ';

    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: ListView.builder(
        //itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
              //title: Text('${products[index]}'),
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
