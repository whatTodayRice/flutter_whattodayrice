import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class AppDefaultDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelButtonText;
  final String confirmButtonText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const AppDefaultDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelButtonText = '취소',
    this.confirmButtonText = '삭제',
    this.onCancel,
    this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String cancelButtonText = '취소',
    String confirmButtonText = '삭제',
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AppDefaultDialog(
        title: title,
        content: content,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        onCancel: onCancel,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: 276,
        height: 162,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 37.h),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13.sp,
                    color: AppColor.gray727272,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26.h),
            const Divider(height: 1, color: AppColor.grayE2E2E2, thickness: 1),
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        onCancel?.call();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.grayA4A4A4,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                      ),
                      child: Text(cancelButtonText),
                    ),
                  ),
                  const VerticalDivider(width: 1, color: AppColor.grayE2E2E2, thickness: 1),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onConfirm?.call();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.orange5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                      ),
                      child: Text(confirmButtonText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
