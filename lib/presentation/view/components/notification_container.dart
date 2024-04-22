import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/common/theme/text_template.dart';

class NotiContainer extends StatelessWidget {
  final double width;
  final double height;
  final TextSpan notiTitle;

  const NotiContainer({
    super.key,
    required this.width,
    required this.height,
    required this.notiTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.0722, right: width * 0.0583),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: gray03,
      ),
      width: width * 0.9527,
      height: height * 0.1039, //글자크기 비율 계산 후 반응형으로 변경
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [notiTitle, checkTextSpan],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
