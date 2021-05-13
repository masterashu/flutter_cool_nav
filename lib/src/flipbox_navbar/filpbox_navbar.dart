import 'dart:math' show pi, max;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A Custom Bottom Navigation Bar that is displayed at the bottom of the
/// screen. The [FlipBoxNavigationBar] animated between the selected and
/// the unselected state it similar to a the rotation of a rectangle box.
/// This navigation bar is usually can be used in a [Scaffold], by providing
/// it as the [Scaffold.bottomNavigationBar] argument.
class FlipBoxNavigationBar extends StatefulWidget {
  /// Creates a flip box bottom navigation bar which can be used with
  /// [Scaffold]'s [Scaffold.bottomNavigationBar] argument.
  ///
  /// The length of [items] should be at least three.
  ///
  /// The [selectedItemTheme], [unselectedItemTheme] and
  /// [backgroundColor] must not be null.
  ///
  /// The [verticalPadding] must be greater than 4.0.
  ///
  /// The [duration] can be used to have custom [Duration] of animation.
  /// [duration] must be greater than 100ms.
  FlipBoxNavigationBar({
    required this.items,
    this.currentIndex = 0,
    this.selectedItemTheme = const IconThemeData(size: 24.0, color: Colors.black),
    this.unselectedItemTheme = const IconThemeData(size: 24.0, color: Colors.black),
    this.verticalPadding = 16,
    this.backgroundColor,
    this.textStyle,
    this.duration = const Duration(milliseconds: 800),
    this.onTap,
    Key? key,
  })  : assert(items.length >= 3),
        assert(duration > const Duration(milliseconds: 100)),
        assert(verticalPadding >= 4.0),
        super(key: key);

  /// Defines the list of items to show on the bottom navigation bar.
  final List<FlipBoxNavigationBarItem> items;

  /// The index of the selected [FlipBoxNavigationBar] in [items].
  final int currentIndex;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the bottom navigation bar needs to keep
  /// track of the index of the selected [FlipBoxNavigationBar] and call
  /// `setState` to rebuild the bottom navigation bar with the new [currentIndex].
  final ValueChanged<int>? onTap;

  /// Defines the size and color of the item's icon when it is selected.
  final IconThemeData selectedItemTheme;

  /// Defines the size and color of the item's icon when it is unselected.
  final IconThemeData unselectedItemTheme;

  /// Defines the style of the item's name when it is selected.
  final TextStyle? textStyle;

  /// The background color of [FlipBoxNavigationBar] itself.
  final backgroundColor;

  /// The duration of animation.
  final Duration duration;

  /// The amount of padding to provide for each [FlipBoxNavigationBarTile].
  ///
  /// The height of tile is calculated by adding [verticalPadding] twice to the
  /// maximum icon size (selected / unselected).
  final double verticalPadding;

  /// Calculates the maximum size of selected/unselected icon size of [FlipBoxNavigationBarItem].
  double get maxIconSize {
    var iconSize = 24.0;
    iconSize = max(iconSize, selectedItemTheme.size ?? 24.0);
    iconSize = max(iconSize, unselectedItemTheme.size ?? 24.0);
    return iconSize;
  }

  @override
  _FlipBoxNavigationBarState createState() => _FlipBoxNavigationBarState();
}

/// An item that is used with [FlipBoxNavigationBar] containing the
/// information about the items to display.
class FlipBoxNavigationBarItem {
  /// Creates an item which is used with [FlipBoxNavigationBar.items].
  ///
  /// The [name], [selectedIcon] are required and must be non-null.
  ///
  /// The [selectedIcon] will be used if [unselectedIcon] is null.
  FlipBoxNavigationBarItem({
    required this.name,
    required this.selectedIcon,
    this.selectedBackgroundColor = Colors.blue,
    this.unselectedBackgroundColor = Colors.lightBlue,
    unselectedIcon,
  }) : unselectedIcon = unselectedIcon ?? selectedIcon;

  /// The text to be displayed for the selected item.
  final String name;

  /// The Icon which will be shown on the [FlipBoxNavigationBar] when the current
  /// item is selected.
  final IconData selectedIcon;

  /// The Icon which will be shown on the [FlipBoxNavigationBar] when the current
  /// item is unselected.
  final IconData unselectedIcon;

  /// The color of the [FlipBoxNavigationBarTile] when the current
  /// item is selected.
  final Color selectedBackgroundColor;

  /// The color of the [FlipBoxNavigationBarTile] when the current
  /// item is unselected.
  final Color unselectedBackgroundColor;
}

/// The Navigation Bar tile displayed within the [FlipBoxNavigationBar].
class FlipBoxNavigationBarTile extends StatefulWidget {
  /// Creates a new [FlipBoxNavigationBarTile] for displaying a single entry of an item
  /// from [FlipBoxNavigationBar.items].
  ///
  /// The [item] and [animation] is required.
  FlipBoxNavigationBarTile({
    required this.item,
    required Animation animation,
    this.height = 56.0,
    this.textStyle = const TextStyle(fontSize: 12.0),
    this.selectedIconTheme,
    this.unselectedIconTheme,
    Key? key,
  })  : assert(height >= 0.0),
        animation = _generateTween(animation),
        super(key: key);

  /// Defines the [FlipBoxNavigationBarItem] used to modify the UI of the tile.
  final FlipBoxNavigationBarItem item;

  /// An [Animation] object used to animate the transitions between selected
  /// and unselected state of Tile.
  final Animation animation;

  /// Defines the height of the [FlipBoxNavigationBarTile].
  final double height;

  /// Defines the [TextStyle] of the text shown with the selected Tile.
  final TextStyle textStyle;

  /// Defines the [IconThemeData] for the selected item.
  final IconThemeData? selectedIconTheme;

  /// Defines the [IconThemeData] for the unselected item.
  final IconThemeData? unselectedIconTheme;

  /// Interpolates an existing animation to a Bounce back [Curve] animation.
  static _generateTween(Animation animation) {
    return TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.1), weight: 10.0),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 25.0),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20.0),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 30.0),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 20.0),
    ]).animate(animation as Animation<double>);
  }

  @override
  _FlipBoxNavigationBarTileState createState() => _FlipBoxNavigationBarTileState();
}

class _FlipBoxNavigationBarState extends State<FlipBoxNavigationBar>
    with TickerProviderStateMixin {
  List<AnimationController>? _controllers;
  int? oldIndex;

  // Resets the controllers
  resetState() {
    // dispose any old controllers
    if (_controllers != null) {
      _controllers!.forEach((e) => e.dispose());
    }
    // Create new controllers
    _controllers = List<AnimationController>.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );
  }

  // Starts the flip animation
  switchIndex() {
    if (oldIndex != widget.currentIndex) {
      _controllers![oldIndex!].reverse(from: 1.0);
      _controllers![widget.currentIndex].forward(from: 0.0);
    } else {
      // partially animate the selected tile
      _controllers![widget.currentIndex].forward(from: 0.8);
    }
  }

  @override
  void initState() {
    super.initState();
    resetState();
    oldIndex = widget.currentIndex;
    switchIndex();
  }

  @override
  void didUpdateWidget(FlipBoxNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset controllers when length of items is changed
    if (oldWidget.items.length != widget.items.length) {
      resetState();
      oldIndex = widget.currentIndex;
    } else {
      oldIndex = oldWidget.currentIndex;
    }
    switchIndex();
  }

  // build FlipBoxNavigationBarTile for all the items.
  _buildTiles() {
    var tiles = List<Widget>.generate(widget.items.length, (index) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(index);
            }
          },
          child: FlipBoxNavigationBarTile(
            item: widget.items[index],
            animation: _controllers![index],
            height: widget.verticalPadding * 2 + widget.maxIconSize,
            selectedIconTheme: widget.selectedItemTheme,
            unselectedIconTheme: widget.unselectedItemTheme,
            key: UniqueKey(),
          ),
        ),
      );
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.verticalPadding * 2 + widget.maxIconSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildTiles(),
      ),
    );
  }

  @override
  void dispose() {
    _controllers!.forEach((e) => e.dispose());
    super.dispose();
  }
}

class _FlipBoxNavigationBarTileState extends State<FlipBoxNavigationBarTile> {
  // build selected size of the box
  get _selectedSide => Container(
        height: widget.height,
        color: widget.item.selectedBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              widget.item.selectedIcon,
              size: widget.selectedIconTheme?.size ?? 24.0,
              color: widget.selectedIconTheme?.color,
            ),
            Text(
              widget.item.name,
              textAlign: TextAlign.center,
              style: widget.textStyle,
            )
          ],
        ),
      );

  // build selected size of the box
  get _unselectedSide => Container(
        height: widget.height,
        color: widget.item.unselectedBackgroundColor,
        child: Center(
          child: Icon(
            widget.item.unselectedIcon,
            size: widget.unselectedIconTheme?.size,
            color: widget.unselectedIconTheme?.color,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (_, child) {
          var selectedSide = Positioned(
            child: Transform.translate(
              offset: Offset(0.0, (1 - widget.animation.value) * widget.height),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.005)
                  ..rotateX((1 - widget.animation.value) * pi / 2)
                  ..scale(1 + (0.5 - _abs(widget.animation.value - 0.5)) / 5),
                alignment: Alignment.topCenter,
                child: _selectedSide,
              ),
            ),
          );
          var unselectedSide = Positioned(
            child: Transform.translate(
              offset: Offset(0.0, -widget.animation.value * widget.height),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.005)
                  ..rotateX(-widget.animation.value * pi / 2)
                  ..scale(1 + (0.5 - _abs(widget.animation.value - 0.5)) / 5),
                alignment: Alignment.bottomCenter,
                child: _unselectedSide,
              ),
            ),
          );
          return Stack(
            // Prevent selected size from painting over the unselected side
            // during the extra bounce animation.
            children: (widget.animation.value > 1.0)
                ? <Widget>[unselectedSide, selectedSide]
                : <Widget>[selectedSide, unselectedSide],
          );
        },
      ),
    );
  }
}

// Absolute value of a num
_abs(x) => x >= 0.0 ? x : -x;
