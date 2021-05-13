# cool_nav

[![Pub Version (including pre-releases)](https://img.shields.io/pub/v/cool_nav?include_prereleases)](https://pub.dev/packages/cool_nav)
[![Github Action Status](https://github.com/masterashu/flutter_cool_nav/workflows/Dart%20CI/badge.svg)](https://github.com/masterashu/flutter_cool_nav/actions)

A collection of really awesome, easy to use BottomNavigationBars

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
---
dependencies:
  cool_nav: ^0.1.0
```

Now in your Dart code, you can use:

```dart
import 'package:cool_nav/cool_nav.dart';
```

## List of Bottom Navigation Bars:

#### Spotlight Bottom Navigation Bar

![Spotlight Bottom Navigation Bar](https://github.com/masterashu/flutter_cool_nav/blob/master/demo/spotlight_bottom_navigation_bar.gif?raw=true)  

> Based on [design](https://www.behance.net/gallery/94842819/Animated-Tab-Bar) made by [Sanchita Agarwal](https://www.linkedin.com/in/sanchita-agrawal-829a5612b).

An easy to use and customizable Bottom Navigation Bar. You can customize the
colors as well provide a custom [Gradient](https://api.flutter.dev/flutter/dart-ui/Gradient-class.html) for the spotlight.

**Usage**

```dart
Scaffold(
    // ...
    bottomNavigationBar: SpotlightBottomNavigationBar(
        items: [
          SpotlightBottomNavigationBarItem(icon: Icons.smartphone),
          SpotlightBottomNavigationBarItem(icon: Icons.laptop_mac),
          SpotlightBottomNavigationBarItem(icon: Icons.desktop_mac),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onTap,
    ),
)
```

#### Flip Box Bottom Navigation Bar

![Flip Box Bottom Navigation Bar](https://github.com/masterashu/flutter_cool_nav/blob/master/demo/flipbox_nav_bar.gif?raw=true)  

> Based on [design](https://dribbble.com/shots/4811135-Tab-Bar-Cube-Interaction) made by [dannniel](https://dribbble.com/dannniel).

An easy to use and customizable Bottom Navigation Bar. You can customize the selected and unselected `Icons` and background `Colors` for the tiles.

**Usage**

```dart
Scaffold(
    // ...
    bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: currentIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Tasks',
              selectedIcon: Icons.done_all,
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
          ]
    ),
)
```

Refer [here](https://github.com/masterashu/flutter_cool_nav/blob/master/example/lib/flipbox_nav_bar.dart) for an example.

More Awesome Navigation Bars will be added in the future.

## Examples

View the [example](https://github.com/masterashu/flutter_cool_nav/tree/master/example) folder to see more examples.
