import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/view/components/text_template.dart';

class SelectDormitory extends StatelessWidget {
  const SelectDormitory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기숙사 선택화면'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackIconButton(),
            const SizedBox(
              height: 80,
            ),
            buildBoldText('안녕하세요!'),
            buildBoldText('현재 거주 중인'),
            buildBoldText('기숙사를 선택해주세요'),
            const Spacer(),
            Center(
              child: Column(
                children: const [
                  ReusableButton(height: 50.0, buttonText: '세종기숙사'),
                  SizedBox(
                    height: 15,
                  ),
                  ReusableButton(height: 50.0, buttonText: '행복기숙사'),
                  SizedBox(
                    height: 50,
                  ),
                  ReusableButton(height: 40.0, buttonText: '다음'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
