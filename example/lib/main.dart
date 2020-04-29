import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'flipbox_nav_bar.dart';
import 'spotlight_nav_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SpotlightNavigationBarHome(),
      home: FlipBoxNavigationBarHome(),
    );
  }
}
