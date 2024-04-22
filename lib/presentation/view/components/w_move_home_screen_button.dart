import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import '../screens/home_screen.dart';

class MoveToHomeScreenButton extends ConsumerStatefulWidget {
  const MoveToHomeScreenButton({super.key});

  @override
  ConsumerState<MoveToHomeScreenButton> createState() =>
      _MoveToHomeScreenButtonState();
}

class _MoveToHomeScreenButtonState
    extends ConsumerState<MoveToHomeScreenButton> {
  @override
  Widget build(BuildContext context) {
    DormitoryType userDormitoryType = ref.watch(dormitoryProvider);
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(2),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              dormitoryType: userDormitoryType,
            ),
          ),
        );
      },
      child: Text(
        "밥 먹으러 가기",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
