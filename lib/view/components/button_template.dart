import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/theme/colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final double height;

  const ReusableButton({
    super.key,
    required this.buttonText,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
// Navigator.pushNamed(context, '/main');
////노티화면에서 클릭한 경우 오밥뭐 알림창 수신 동의 뜨도록 함수 지정해주기
      // },
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: width * 0.0694, right: width * 0.0694),
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: width * 0.28, right: width * 0.28),
              decoration: BoxDecoration(
                color: gray01,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child:
                      Text(buttonText, style: const TextStyle(color: white))),
            ),
          )
        ],
      ),
    );
  }
}

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }
}

// textbutton 템플릿
class SelectThemeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final AdaptiveThemeMode adaptiveThemeMode;

  const SelectThemeButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.adaptiveThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    // final ThemeMode themeMode = convertToThemeMode(adaptiveThemeMode);
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: GoogleFonts.notoSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const SelectButton({
    required this.buttonText,
    required this.onPressed(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: GoogleFonts.notoSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MainScreenBackIconButton extends StatelessWidget {
  final IconData iconShape;
  final VoidCallback onPressed;

  const MainScreenBackIconButton(
      {super.key, required this.iconShape, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconShape),
      onPressed: onPressed,
    );
  }
}

class MainScreenForwardIconButton extends StatelessWidget {
  final IconData iconShape;
  final VoidCallback onPressed;

  const MainScreenForwardIconButton(
      {super.key, required this.iconShape, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconShape),
      onPressed: onPressed,
    );
  }
}
