import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';

class CommentInput extends StatefulWidget {
  const CommentInput(
      {super.key,
      required this.textEditingController,
      required this.focusNode,
      this.onCommentChangeCallback,
      this.onCommentCreateCallback,
      this.isButtonEnabled});

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final VoidCallback? onCommentChangeCallback;
  final void Function()? onCommentCreateCallback;
  final bool? isButtonEnabled;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  void initState() {
    widget.textEditingController.addListener(() => widget.onCommentChangeCallback?.call());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColor.borderGray))),
      child: TextField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        maxLines: 3,
        minLines: 1,
        style: AppTextStyle.regular14.copyWith(color: Colors.black, height: 22 / 14, decorationThickness: 0),
        cursorColor: AppColor.orangeFF823B,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
          filled: true,
          fillColor: AppColor.grayF6F6F6,
          hintText: "댓글을 입력해주세요.",
          hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.grayADADAD, height: 22 / 14),
          contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: widget.isButtonEnabled == true
                ? () {
                    widget.onCommentCreateCallback?.call();
                    widget.textEditingController.clear();
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: widget.isButtonEnabled == true
                  ? Assets.images.iconSendEnable.svg()
                  : Assets.images.iconSendDisable.svg(),
            ),
          ),
        ),
      ),
    );
  }
}
