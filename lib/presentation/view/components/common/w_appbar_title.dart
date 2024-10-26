import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({
    super.key,
    required this.currentBottomNavigationIndex,
  });

  final int currentBottomNavigationIndex;

  @override
  Widget build(BuildContext context) {
    if (currentBottomNavigationIndex == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text("오늘의 메뉴", style: Theme.of(context).textTheme.titleMedium!),
      );
    }
    return const SizedBox.shrink();
  }
}
