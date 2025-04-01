import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';

class AppDefaultDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? cancelButtonText;
  final String? confirmButtonText;
  final Color? confirmButtonTextColor;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const AppDefaultDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelButtonText,
    this.confirmButtonText,
    this.confirmButtonTextColor,
    this.onCancel,
    this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String? cancelButtonText,
    String? confirmButtonText,
    Color? confirmButtonTextColor,
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
        confirmButtonTextColor: confirmButtonTextColor,
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
            if (title.isNotEmpty == true) ...[
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp, color: AppColor.gray727272),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26.h),
            const Divider(height: 1, color: AppColor.grayE2E2E2, thickness: 1),
            if (confirmButtonText?.isNotEmpty == true)
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    if (cancelButtonText?.isNotEmpty == true)
                      Expanded(
                        child: TextButton(
                          onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColor.grayA4A4A4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14)),
                            ),
                          ),
                          child: Text(cancelButtonText!),
                        ),
                      ),
                    const VerticalDivider(width: 1, color: AppColor.grayE2E2E2, thickness: 1),
                    Expanded(
                      child: TextButton(
                        onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: confirmButtonTextColor ?? AppColor.orangeFF823B,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
                          ),
                        ),
                        child: Text(confirmButtonText!),
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
