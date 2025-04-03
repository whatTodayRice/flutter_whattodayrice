import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.textStyle,
    required this.buttonBorderColor,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderRadiusValue,
    required this.elevation,
    required this.disabledForegroundColor,
    required this.disabledBackgroundColor,
  });

  final void Function()? onPressed;
  final String title;
  final TextStyle textStyle;
  final Color buttonBorderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadiusValue;
  final double elevation;
  final Color disabledForegroundColor;
  final Color disabledBackgroundColor;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadiusValue),
            ),
            side: BorderSide(color: buttonBorderColor, width: 1.2),
          ),
          elevation: elevation,
          padding: EdgeInsets.zero,
          overlayColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: disabledForegroundColor,
          disabledForegroundColor: disabledBackgroundColor,
        ),
        child: Text(title),
      );
}
