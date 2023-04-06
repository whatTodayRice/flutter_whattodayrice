import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/buttontemplate.dart';
import 'package:flutter_whattodayrice/view/components/texttemplate.dart';

class SelectDormitory extends StatelessWidget {
  const SelectDormitory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기숙사 선택 화면',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('기숙사 선택화면'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackIconButton(),
            const SizedBox(
              height: 100,
            ),
            buildText('안녕하세요!'),
            buildText('현재 거주 중인'),
            buildText('기숙사를 선택해주세요'),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                children: const [
                  ReusableButton(buttonText: '세종기숙사'),
                  SizedBox(
                    height: 15,
                  ),
                  ReusableButton(buttonText: '행복기숙사'),
                  SizedBox(
                    height: 50,
                  ),
                  NextButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
