import 'package:flutter/material.dart';

class MealContainer extends StatelessWidget {
  final double height;
  final double width;
  final String content;

  const MealContainer({
    super.key,
    required this.content,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: height * 0.1433,
      width: width * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
