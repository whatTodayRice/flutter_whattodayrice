import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/data/models/dormitory.dart';
import 'package:flutter_whattodayrice/presentation/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';

class PushAlarmContainer extends ConsumerWidget {
  const PushAlarmContainer(
      {super.key,
      required this.isSwitched,
      required this.title,
      required this.subtitle});

  final bool isSwitched;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDormitory = ref.watch(dormitoryProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: ColorConstants.pushAlarmContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        children: [
          Visibility(
            visible: userDormitory != DormitoryType.happiness,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Image.asset(
                'assets/images/washing-machine.png',
                width: 30.w,
                height: 30.h,
              ),
            ),
          ),
          Expanded(
            child:
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
          ),
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
