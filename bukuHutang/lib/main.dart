import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Buku Hutang';

    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Mainpage(),
          '/second': (context) => Debtpage(),
          '/third': (context) => Owepage(),
        });
  }
}

class Mainpage extends StatefulWidget {
  Mainpage({Key key}) : super(key: key);
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
          title: Text('Buku Hutangmu'),
          leading: Icon(Icons.person),
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
