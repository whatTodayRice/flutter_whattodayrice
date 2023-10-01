import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.animatedValue});

  final double animatedValue;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splash/android12splash.png",
      width: animatedValue * 192, // animatedValue를 크기에 곱하여 크기 조절
      height: animatedValue * 192, // animatedValue를 크기에 곱하여 크기 조절
      color: const Color(0xffFF833D),
    );
  }
}
