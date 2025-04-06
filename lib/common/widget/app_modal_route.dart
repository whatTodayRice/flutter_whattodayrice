import 'package:flutter/material.dart';

class AppModalRoutePage<T> extends Page<T> {
  final Widget child;

  const AppModalRoutePage({required this.child});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
        settings: this,
        isScrollControlled: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => child,
      );
}
