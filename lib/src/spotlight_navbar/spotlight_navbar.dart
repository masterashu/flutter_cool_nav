import 'dart:math';

import 'package:flutter/material.dart';

/// A Custom Navigation Bar that is displayed at the bottom of the
/// screen. The [SpotlightNavigationBar] shows a spotlight over the
/// selected item. This navigation bar is usually can be used in a [Scaffold],
/// by providing it as the [Scaffold.bottomNavigationBar] argument.
class SpotlightNavigationBar extends StatefulWidget {
  /// Creates a spotlight navigation bar which can be used with
  /// [Scaffold]'s [Scaffold.bottomNavigationBar] argument.
  ///
  /// The length of [items] should be at least 2 and each item's icon property
  /// must not be null.
  ///
  /// The [selectedItemColor], [unselectedItemColor] and
  /// [backgroundColor] must not be null.
  ///
  /// The [iconSize] must be non-null and non-negative.
  ///
  /// If custom [IconThemeData] are used then it will override the
  /// [selectedItemColor] and [unselectedItemColor], and the custom
  /// [IconThemeData] must have a non-null [IconThemeData.color] and
  /// [IconThemeData.size].
  ///
  /// The [selectedItemColor] will be used for the Top Bar highlighting the
  /// active item regardless of [selectedIconTheme.color].
  ///
  /// The [spotlightGradient] parameter can be used to give a custom [Gradient]
  /// for the spotlight.
  SpotlightNavigationBar({
    Key? key,
    required this.items,
    this.onDestinationSelected,
    required this.selectedIndex,
    this.darkTheme = true,
    this.unselectedItemColor = const Color(0xff666666),
    this.selectedItemColor = const Color(0xffffffff),
    this.backgroundColor = const Color(0xff101010),
    this.iconSize = 24.0,
    this.unselectedIconTheme,
    this.selectedIconTheme,
    this.spotlightGradient,
  })  : assert(items.length >= 2),
        assert(0 <= selectedIndex && selectedIndex < items.length),
        assert(iconSize >= 0.0),
        assert(unselectedIconTheme == null ||
            (unselectedIconTheme.color != null &&
                unselectedIconTheme.size != null)),
        assert(selectedIconTheme == null ||
            (selectedIconTheme.color != null &&
                selectedIconTheme.size != null)),
        super(key: key);

  /// Defines the list of items which will be shown in the navigation bar.
  final List<SpotlightNavigationBarItem> items;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the navigation bar needs to keep
  /// track of the index of the selected [SpotlightNavigationBar] and call
  /// `setState` to rebuild the navigation bar with the new [selectedIndex].
  final ValueChanged<int>? onDestinationSelected;

  /// The index of the selected [SpotlightNavigationBarItem] in [items].
  final int selectedIndex;

  // TODO Implement Dark/Light Themes
  final bool darkTheme;

  /// The color of unselected [NavigationDestination.icon]s.
  final Color unselectedItemColor;

  /// The color of selected [NavigationDestination.icon], current item
  /// header and the color of the spotlight if [spotlightGradient] is not provided.
  final Color selectedItemColor;

  /// The color of the [SpotlightNavigationBar] itself.
  final Color backgroundColor;

  /// The size of the [SpotlightNavigationBarItem] icons.
  final double iconSize;

  /// The size, opacity, and color of the icon in the currently selected
  /// [SpotlightNavigationBarItem.icon].
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [unselectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties.
  final IconThemeData? unselectedIconTheme;

  /// The size, opacity, and color of the icon in the currently selected
  /// [SpotlightNavigationBarItem.icon].
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [selectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties.
  final IconThemeData? selectedIconTheme;

  /// The custom [Gradient] to use for the spotlight of the selected
  /// [NavigationDestination].
  final Gradient? spotlightGradient;

  @override
  _SpotlightNavigationBarState createState() => _SpotlightNavigationBarState();
}

class _SpotlightNavigationBarState extends State<SpotlightNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController animation;

  // The previous selectedIndex of the widget. Used to animate the top bar.
  late int oldIndex;

  _resetState() {
    animation = AnimationController(
      duration: const Duration(milliseconds: 400),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
  }

  @override
  void initState() {
    super.initState();
    _resetState();
    oldIndex = widget.selectedIndex;
    // only show spotlight FadeIn Animation
    animation.forward(from: 0.5);
  }

  @override
  void didUpdateWidget(SpotlightNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _resetState();
      oldIndex = oldWidget.selectedIndex;
    }
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      oldIndex = widget.selectedIndex;
    }
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  IconThemeData _getThemeData(bool active) {
    if (active) {
      return widget.selectedIconTheme ??
          IconThemeData(color: widget.selectedItemColor, size: widget.iconSize);
    } else {
      return widget.unselectedIconTheme ??
          IconThemeData(
              color: widget.unselectedItemColor, size: widget.iconSize);
    }
  }

  _buildItems() {
    List<Widget> tiles = [];
    for (var i = 0; i < widget.items.length; i++) {
      tiles.add(Expanded(
        child: GestureDetector(
          child: _SpotlightNavigationBarTile(
            key: UniqueKey(),
            icon: widget.items[i].icon,
            iconTheme: _getThemeData(
                (widget.selectedIndex == i) && animation.value >= 0.7),
          ),
          onTap: () {
            if (widget.onDestinationSelected != null) {
              widget.onDestinationSelected!(i);
            }
          },
          behavior: HitTestBehavior.translucent,
        ),
      ));
    }
    return tiles;
  }

  _spotlightOffset(BuildContext context) {
    var freeSpace = (MediaQuery.of(context).size.width / widget.items.length) -
        widget.iconSize;
    var pos = (animation.value >= 0.5) ? widget.selectedIndex : oldIndex;
    return Offset(freeSpace / 2 + (freeSpace + widget.iconSize) * pos, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(56.0, (widget.iconSize + 24)),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: widget.backgroundColor),
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, child) {
          Animation opacityTween = (animation.value >= 0.5)
              ? Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Interval(0.8, 1.0)))
              : Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                  parent: animation, curve: Interval(0.0, 0.2)));
          return Stack(
            children: <Widget>[
              Opacity(
                opacity: opacityTween.value,
                child: CustomPaint(
                  painter: _SpotlightPainter(
                    offset: _spotlightOffset(context),
                    iconSize: widget.iconSize,
                    gradient: widget.spotlightGradient,
                    color: widget.selectedIconTheme?.color ??
                        widget.selectedItemColor,
                  ),
                ),
              ),
              Row(
                children: _buildItems(),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              CustomPaint(
                painter: _SelectedItemHeaderPainter(
                  iconSize: widget.iconSize,
                  count: widget.items.length,
                  color: widget.selectedIconTheme?.color ??
                      widget.selectedItemColor,
                  oldPosition: oldIndex,
                  newPosition: widget.selectedIndex,
                  animation: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animation, curve: Interval(0.1, 0.6))),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

/// An item that is used with [SpotlightNavigationBar] containing the
/// information about the items to display.
class SpotlightNavigationBarItem {
  /// Creates an item that is used with [SpotlightNavigationBar.items].
  ///
  /// The argument [icon] should not be null when used in a Material Design's [NavigationBar].
  SpotlightNavigationBarItem({required this.icon});

  /// The Icon which will be shown on the [SpotlightNavigationBar]
  final IconData icon;
}

class _SelectedItemHeaderPainter extends CustomPainter {
  _SelectedItemHeaderPainter({
    required this.oldPosition,
    required this.newPosition,
    required this.animation,
    required this.count,
    this.iconSize = 24,
    this.color = Colors.white,
  });
  final int oldPosition, newPosition, count;
  final double iconSize;
  final Color color;
  final Animation animation;

  double get progress => animation.value;

  Offset startOffset(Size size) {
    var freeSpace = (size.width / count) - iconSize;
    assert(freeSpace >= 0);
    return Offset(
        freeSpace / 2 +
            (freeSpace + iconSize) *
                (oldPosition * (1 - progress) + newPosition * progress),
        1);
  }

  Offset endOffset(Size size) {
    var freeSpace = (size.width / count) - iconSize;
    assert(freeSpace >= 0);
    return Offset(
        freeSpace / 2 +
            (freeSpace + iconSize) *
                (oldPosition * (1 - progress) + newPosition * progress) +
            iconSize,
        1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint()
      ..color = this.color
      ..strokeWidth = 2;
    canvas.drawLine(startOffset(size), endOffset(size), p);
  }

  @override
  bool shouldRepaint(_SelectedItemHeaderPainter oldDelegate) => true;
}

class _SpotlightPainter extends CustomPainter {
  final Offset offset;
  final double iconSize;
  final Gradient? gradient;
  final Color? color;

  _SpotlightPainter({
    this.iconSize = 24,
    this.offset = Offset.zero,
    this.gradient,
    this.color,
  });

  double get spotlightSize => max(60, iconSize + 36);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromLTWH(0, 0, spotlightSize, spotlightSize);
    var p = Paint()
      ..shader = (gradient != null)
          ? gradient!.createShader(rect)
          : LinearGradient(colors: <Color>[
              color!.withAlpha(64),
              color!.withAlpha(36),
              color!.withAlpha(0)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              .createShader(rect);
    var path = Path()..addPolygon(getPath(size), true);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_SpotlightPainter oldDelegate) => true;

  List<Offset> getPath(Size size) {
    var points = <Offset>[];
    points.add(offset + Offset(2, 0));
    points
        .add(offset + Offset(iconSize / 2 - spotlightSize / 2, spotlightSize));
    points
        .add(offset + Offset(iconSize / 2 + spotlightSize / 2, spotlightSize));
    points.add(offset + Offset(iconSize - 2, 0));
    return points;
  }
}

class _SpotlightNavigationBarTile extends StatelessWidget {
  final IconData? icon;
  final IconThemeData? iconTheme;

  const _SpotlightNavigationBarTile({Key? key, this.icon, this.iconTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(56, iconTheme!.size! + 24),
      width: max(56, iconTheme!.size! + 24),
      child: Center(
        child: IconTheme(
          child: Icon(icon),
          data: iconTheme!,
        ),
      ),
    );
  }
}
