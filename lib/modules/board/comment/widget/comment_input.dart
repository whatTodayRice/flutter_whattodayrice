import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/modules/board/comment/bloc/comment_bloc.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final FocusNode commentFocusNode = FocusNode();
  final TextEditingController commentTextController = TextEditingController();
  late final CommentBloc commentBloc;

  @override
  void initState() {
    commentBloc = context.read<CommentBloc>();

    commentTextController.addListener(
      () => commentBloc.add(
        CommentContentChanged(content: commentTextController.text),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColor.borderGray))),
      child: TextField(
        controller: commentTextController,
        focusNode: commentFocusNode,
        maxLines: 3,
        minLines: 1,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
              height: 22 / 14,
              decorationThickness: 0,
            ),
        cursorColor: AppColor.orangeFF823B,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
          filled: true,
          fillColor: AppColor.grayF6F6F6,
          hintText: "댓글을 입력해주세요.",
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.grayADADAD, height: 22 / 14),
          contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          isDense: true,
          suffixIcon: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is! CommentListLoaded) {
                return const SizedBox.shrink();
              }
              bool isButtonEnabled = false;

              if (state.isContentEmpty == false) {
                isButtonEnabled = true;
              }

              return GestureDetector(
                onTap: isButtonEnabled
                    ? () {
                        commentBloc.add(const CommentCreateRequested());
                        commentTextController.clear();
                      }
                    : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: isButtonEnabled
                      ? SvgPicture.asset("assets/images/icon_send_enable.svg")
                      : SvgPicture.asset("assets/images/icon_send_disable.svg"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
