import 'package:flutter/material.dart';

class CustomTextFieldSuffixIcon extends StatelessWidget {
  const CustomTextFieldSuffixIcon({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: icon,
    );
  }
}
