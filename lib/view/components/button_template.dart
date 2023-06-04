import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/theme/colors.dart';

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

class MainScreenIconButton extends StatefulWidget {
  final IconData iconShape;

  const MainScreenIconButton({super.key, required this.iconShape});

  @override
  State<MainScreenIconButton> createState() => _MainScreenIconButtonState();
}

class _MainScreenIconButtonState extends State<MainScreenIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.iconShape),
      onPressed: () {
        setState(() {});
      },
    );
  }
}
