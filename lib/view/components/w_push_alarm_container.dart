import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/theme/colors.dart';

class PushAlarmContainer extends StatelessWidget {
  const PushAlarmContainer(
      {super.key,
      required this.isSwitched,
      required this.title,
      required this.subtitle});

  final bool isSwitched;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: ColorConstants.pushAlarmContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorConstants.pushAlarmTitle, fontSize: 13.0)),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorConstants.pushAlarmSubTitle),
              textAlign: TextAlign.start,
            ),
          ]),
          Switch(
              value: isSwitched,
              activeColor: ColorConstants.primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: ColorConstants.primary,
              onChanged: (bool value) {}),
        ],
      ),
    );
  }
}
