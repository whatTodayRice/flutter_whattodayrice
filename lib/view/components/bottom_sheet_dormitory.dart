import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';

class DormitoryBottomSheet {
  static void show(
    BuildContext context,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _DormitoryBottomSheetContent(context, ref);
      },
    );
  }
}

class _DormitoryBottomSheetContent extends StatelessWidget {
  final BuildContext context;
  final WidgetRef ref;

  const _DormitoryBottomSheetContent(this.context, this.ref);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectButton(
          buttonText: '행복기숙사',
          onPressed: () {
            ref.read(dormitoryProvider.notifier).state =
                DormitoryType.happiness;

            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 10),
        SelectButton(
          buttonText: '세종기숙사',
          onPressed: () {
            ref.read(dormitoryProvider.notifier).state = DormitoryType.sejong1;
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
