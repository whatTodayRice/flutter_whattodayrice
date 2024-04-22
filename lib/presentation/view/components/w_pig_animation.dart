import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PigAnimationWidget extends StatelessWidget {
  const PigAnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/pig.png',
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .custom(
          curve: Curves.easeInOut,
          duration: 2500.ms,
          builder: (context, animate, child) {
            // Scale 애니메이션을 사용하여 크기를 조절합니다.
            final scale = 1.0 + 0.2 * animate;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
        );
  }
}
