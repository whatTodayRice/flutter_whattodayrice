import 'package:flutter/material.dart';

class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          // 애니메이션 시작 및 종료 값 설정
          const double begin = 0.0; // 시작 위치 (예: 위에서 아래로)
          const double end = 100.0; // 종료 위치 (예: 아래에서 위로)

          // 애니메이션 값을 설정 (위에서 아래로 튀도록)
          final double animatedValue =
              (1.0 - animation.value) * (end - begin) + begin;

          return Transform.translate(
            offset: Offset(0, -animatedValue),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
