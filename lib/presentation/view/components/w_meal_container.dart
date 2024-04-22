import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealContainer extends StatelessWidget {
  final String content;

  const MealContainer({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      width: MediaQuery.of(context).size.width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
    );
  }
}
