import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/presentation/view/components/button_template.dart';

// test 주석

class DormitoryBottomSheet {
  static void show(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _DormitoryBottomSheetContent(context);
      },
    );
  }
}

class _DormitoryBottomSheetContent extends StatelessWidget {
  final BuildContext context;

  const _DormitoryBottomSheetContent(this.context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectButton(
          buttonText: '행복기숙사',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 10),
        SelectButton(
          buttonText: '세종기숙사',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
