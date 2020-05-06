import 'package:flutter/material.dart';
import 'package:websocket_app/pages/server_page.dart';

import 'pages/client_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter websockets',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/server': (context) => MyMaterial(child: ServerPage()),
        '/client': (context) => MyMaterial(child: ClientPage())
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  Widget MyMaterial({Widget child}) => Material(
        color: Colors.black,
        child: child,
      );
}
