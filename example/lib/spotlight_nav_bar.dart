import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';

class SpotlightNavBarHome extends StatefulWidget {
  SpotlightNavBarHome({Key? key}) : super(key: key);

  @override
  _SpotlightNavBarHomeState createState() => _SpotlightNavBarHomeState();
}

class _SpotlightNavBarHomeState extends State<SpotlightNavBarHome> {
  late int selectedIndex;

  _updateSelectedIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
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
        title: Text("Spotlight"),
      ),
      body: Center(
        child: texts[selectedIndex],
      ),
      bottomNavigationBar: SpotlightNavigationBar(
        items: [
          SpotlightNavigationBarItem(icon: Icons.smartphone),
          SpotlightNavigationBarItem(icon: Icons.laptop_mac),
          SpotlightNavigationBarItem(icon: Icons.desktop_mac),
        ],
        selectedIndex: selectedIndex,
        selectedItemColor: Colors.cyan,
        onDestinationSelected: _updateSelectedIndex,
      ),
    );
  }
}
