import 'package:flutter/material.dart';

import 'routes/root.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BCXPR API'),
        ),
        body: Root(),
      ),
    );
  }
}
