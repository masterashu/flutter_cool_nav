import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';

class SpotlightNavBarHome extends StatefulWidget {
  SpotlightNavBarHome({Key? key}) : super(key: key);

  @override
  _SpotlightNavBarHomeState createState() => _SpotlightNavBarHomeState();
}

class _SpotlightNavBarHomeState extends State<SpotlightNavBarHome> {
  late int currentIndex;

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
        spotlightGradient: RadialGradient(colors: [
          Colors.indigo,
          Colors.blue.withAlpha(200),
          Colors.green.withAlpha(150),
          Colors.yellow.withAlpha(100),
          Colors.orange.withAlpha(50),
          Colors.red.withAlpha(0),
        ], center: Alignment.topCenter),
      ),
    );
  }
}
