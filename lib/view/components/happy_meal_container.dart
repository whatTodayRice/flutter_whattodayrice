import 'package:flutter/material.dart';

// happt_meal_container.dart 를 붙여주었습니다 !

class happyMealContainer extends StatelessWidget {
  const happyMealContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
