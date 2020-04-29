import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';

class FlipBoxNavigationBarHome extends StatefulWidget {
  FlipBoxNavigationBarHome({Key key}) : super(key: key);

  @override
  _FlipBoxNavigationBarHomeState createState() => _FlipBoxNavigationBarHomeState();
}

class _FlipBoxNavigationBarHomeState extends State<FlipBoxNavigationBarHome> {
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
    Text('Page 1'),
    Text('Page 2'),
    Text('Page 3'),
    Text('Page 4'),
    Text('Page 5')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Center(
          child: texts[currentIndex],
        ),
        bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: currentIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Tasks',
              selectedIcon: Icons.done_all,
              unselectedIcon: Icons.done_outline,
              selectedBackgroundColor: Colors.deepPurpleAccent[200],
              unselectedBackgroundColor: Colors.deepPurpleAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'People',
              selectedIcon: Icons.person,
              unselectedIcon: Icons.person_outline,
              selectedBackgroundColor: Colors.indigoAccent[200],
              unselectedBackgroundColor: Colors.indigoAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Mail',
              selectedIcon: Icons.mail,
              unselectedIcon: Icons.mail_outline,
              selectedBackgroundColor: Colors.blueAccent[200],
              unselectedBackgroundColor: Colors.blueAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Flagged',
              selectedIcon: Icons.flag,
              unselectedIcon: Icons.outlined_flag,
              selectedBackgroundColor: Colors.greenAccent[200],
              unselectedBackgroundColor: Colors.greenAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Accounts',
              selectedIcon: Icons.people,
              unselectedIcon: Icons.people_outline,
              selectedBackgroundColor: Colors.orangeAccent[200],
              unselectedBackgroundColor: Colors.orangeAccent[100],
            ),
          ],
          onTap: _updateIndex,
        ));
  }
}
