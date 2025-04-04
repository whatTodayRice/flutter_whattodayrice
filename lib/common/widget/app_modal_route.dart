import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class AppModalRoutePage<T> extends Page<T> {
  final Widget child;

  const AppModalRoutePage({required this.child});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
        settings: this,
        backgroundColor: AppColor.orangeFF823B,
        isScrollControlled: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => child,
      );
}
