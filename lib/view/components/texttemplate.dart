import 'package:flutter/material.dart';

Widget buildBoldText(String text) {
  return Row(
    children: [
      const SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    ],
  );
}

Widget buildText(String text) {
  return Row(
    children: [
      const SizedBox(
        width: 20,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    ),
  );
}

Widget buildSectionSubtitle(String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Text(
      subtitle,
      style: TextStyle(color: Colors.grey[700], fontSize: 10),
    ),
  );
}

final TextSpan notificationTextSpan = TextSpan(
  text: '내일 식단이 업로드 되었어요! 🍚\n',
  style: TextStyle(color: Colors.grey[700]),
);

final TextSpan linkTextSpan = TextSpan(
  text: '지금 눌러서 확인하기',
  style: TextStyle(color: Colors.grey[500], fontSize: 12),
);

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
