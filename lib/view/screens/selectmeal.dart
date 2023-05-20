import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/button_template.dart';
import 'package:flutter_whattodayrice/view/components/text_template.dart';

class SelectMeal extends StatelessWidget {
  const SelectMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const BackIconButton(),
        const SizedBox(
          height: 40,
        ),
        buildBoldText('알림시간을 설정해주세요'),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            RichText(
              text: const TextSpan(text: '', children: [
                TextSpan(
                  text: '조식 30분 전, 중식 15분 전',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '과 같이'),
              ]),
            ),
          ],
        ),
        buildText('이전단계에서 선택한 식사에 대한 알림을 받을 수 있어요!'),
        const SizedBox(
          height: 100,
        ),
        Container(
          padding: const EdgeInsets.only(),
          child: Row(children: [
            buildBoldText('식사'),
            Expanded(child: Container()),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  builder: (BuildContext context) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    return Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: screenHeight * 0.4,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '식사 몇 분 전 알려드릴까요?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('팝업 알림을 받을 시간을 선택해주세요.'),
                            SizedBox(
                              height: 50,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                '15분 전',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                '30분 전',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                '60분 전',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                '30분 전',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Divider(
            thickness: 1,
            height: 1,
            color: Color(0xFFBDBDBD),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(50, 250, 50, 10),
          child: ReusableButton(height: 40.0, buttonText: '알림 설정 완료'),
        ),
      ]),
    );
  }
}
