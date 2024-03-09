import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/meal_data_provider.dart';
import '../screens/home_screen.dart';

class MoveToHomeScreenButton extends ConsumerStatefulWidget {
  const MoveToHomeScreenButton({Key? key}) : super(key: key);

  @override
  ConsumerState<MoveToHomeScreenButton> createState() =>
      _MoveToHomeScreenButtonState();
}

class _MoveToHomeScreenButtonState
    extends ConsumerState<MoveToHomeScreenButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(2),
      ),
      onPressed: () {
        ref.watch(mealDataProvider);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
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
