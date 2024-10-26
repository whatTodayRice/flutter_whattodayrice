import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;
  final bool? isCenterTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? backGroundColor;
  final Widget? floatingActionButton;

  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.body,
    this.isCenterTitle = false,
    this.backGroundColor = Colors.white,
    this.actions,
    this.bottom,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: isCenterTitle,
        actions: actions,
        bottom: bottom,
      ),
      backgroundColor: backGroundColor,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
