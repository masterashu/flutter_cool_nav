import 'package:example/spotlight_nav_bar.dart';
import 'package:flutter/material.dart';
import 'flipbox_nav_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        children: [
          Expanded(
            child: SpotlightNavBarHome(),
          ),
          Expanded(
            child: FlipBoxNavigationBarHome(),
          ),
        ],
      ),
    );
  }
}
