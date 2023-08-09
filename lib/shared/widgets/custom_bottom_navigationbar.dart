import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int pageIndex;
  final List<IconData> icons;
  final Function(int) onPressed;

  const CustomBottomNavigation({
    super.key,
    required this.onPressed,
    required this.pageIndex,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashFactory: NoSplash.splashFactory,
      indicator: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.green,
            width: 3.0,
          ),
        ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == pageIndex ? Colors.green : Colors.black45,
                    size: 30.0,
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onPressed,
    );
  }
}
