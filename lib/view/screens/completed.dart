import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/constants.dart';
import 'package:flutter_whattodayrice/view/components/buttontemplate.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 180.0,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: kCompleteTitleText,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: kCompletedSubTitleText,
          ),
          kCompletedCheckCircle,
          SizedBox(
            height: 140.0,
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ReusableNextButton(),
            ),
          ),
        ],
      ),
    );
  }
}
