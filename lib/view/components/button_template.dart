import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String buttonText;
  final double height;

  const ReusableButton({
    super.key,
    required this.buttonText,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, '/main');
      // },
      child: Column(
        children: [
          Container(
            height: height,
            width: 440.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(buttonText)),
          ),
          const SizedBox(
            height: 10,
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
          //뒤로 가기 기능 추가
        },
        icon: const Icon(Icons.arrow_back_ios));
  }
}

// textbutton 템플릿
class SelectButton extends StatelessWidget {
  final String buttonText;

  const SelectButton({
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      // 현재 저장되어 있는 값이 선택된 값으로 수정되도록 하는 함수 추가
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MainScreenIconButton extends StatelessWidget {
  final IconData iconShape;

  const MainScreenIconButton({super.key, required this.iconShape});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconShape),
      onPressed: () {},
    );
  }
}