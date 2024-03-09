import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/view/components/text_template.dart';

class NotificationSwitch extends StatelessWidget {
  final bool isSwitched;
  final ValueChanged<bool> onChanged;

  const NotificationSwitch({
    super.key,
    required this.isSwitched,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
      ),
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  notificationTomorrowTxtSpan,
                  checkTextSpan,
                ],
              ),
            ),
          ),
          Switch(
            value: isSwitched,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
