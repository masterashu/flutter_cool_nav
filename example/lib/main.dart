import 'package:cool_nav/cool_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;

  _updateIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  List<Text> texts = [
    Text("Page 1"),
    Text("Page 2"),
    Text("Page 3"),
    Text("Page 4")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Center(
        child: texts[currentIndex],
      ),
      bottomNavigationBar: SpotlightBottomNavigationBar(
        items: [
          SpotlightBottomNavigationBarItem(icon: Icons.smartphone),
          SpotlightBottomNavigationBarItem(icon: Icons.web),
          SpotlightBottomNavigationBarItem(icon: Icons.laptop_mac),
          SpotlightBottomNavigationBarItem(icon: Icons.desktop_mac),
        ],
        currentIndex: currentIndex,
        onTap: _updateIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        spotlightGradient: RadialGradient(
          colors: [
            Colors.indigo,
            Colors.blue.withAlpha(200),
            Colors.green.withAlpha(150),
            Colors.yellow.withAlpha(100),
            Colors.orange.withAlpha(50),
            Colors.red.withAlpha(0),
          ],
          center: Alignment.topCenter
        ),
      ),
    );
  }
}
