# cool_nav

A collection of really awesome, easy to use BottomNavigationBars

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
---
dependencies:
  cool_nav: ^0.0.1
```

Now in your Dart code, you can use:

```dart
import 'package:cool_nav/cool_nav.dart';
```

## List of Bottom Navigation Bars:

#### Spotlight Bottom Navigation Bar

![Spotlight Bottom Navigation Bar](https://github.com/masterashu/flutter_cool_nav/blob/master/demo/spotlight_bottom_navigation_bar.gif?raw=true)  
A easy to use and customizable Bottom Navigation Bar. You can customize the
colors as well provide a custom [Gradient](https://api.flutter.dev/flutter/dart-ui/Gradient-class.html) for the spotlight.  
  
**Code**
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

More Awesome Navigation Bars will be added in the future.


## Examples
View the [example](https://github.com/masterashu/flutter_cool_nav/tree/master/example) folder to see more examples.
