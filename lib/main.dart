import 'dart:convert';

import 'package:flutter/material.dart';
import 'routes/root.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  SocketIO socketIO;
  // List<String> messages;
  double height, width;
  String switchWidget = 'true';

  @override
  void initState() {
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      'https://chat-xpr.herokuapp.com',
      '/',
    );
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map
          // <String, dynamic>
          data = json.decode(jsonData);
      var message = data['message'];
      print(message);
      setState(() {
        switchWidget = message;
      });
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
  }

  Widget build(BuildContext context) {
    if (switchWidget == 'true') {
      return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.amber,
          accentColor: Colors.cyan[600],

          // Define the default font family.
          fontFamily: 'Ubuntu',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home:
            // Scaffold(
            //   appBar: AppBar(
            //     title: Text('BCXPR API Admin'),
            //   ),
            //   body:
            Root(),
        // ),
      );
    }
    if (switchWidget == 'false') {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox();
  }
}
