import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_whattodayrice/common/utils/event_bus.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/common/widget/app_text_button.dart';
import 'package:flutter_whattodayrice/config/di/di.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/modules/board/post_creation/bloc/post_creation_bloc.dart';
import 'package:go_router/go_router.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({
    super.key,
    required this.postType,
  });

  final PostType postType;

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late final EventBus eventBus;

  late final String title;
  late final String contentHintText;

  @override
  void initState() {
    super.initState();

    eventBus = getIt<EventBus>();

    final bloc = context.read<PostCreationBloc>();

    _titleController.addListener(
      () => bloc.add(PostCreationTitleChanged(title: _titleController.text)),
    );
    _contentController.addListener(
      () => bloc.add(PostCreationContentChanged(content: _contentController.text)),
    );

    title = widget.postType == PostType.free ? "제목" : PostType.question.title;
    contentHintText = widget.postType == PostType.free ? "내용을 입력해주세요." : "내용을 구체적으로 입력할 수록 답변 받을 확률이 높아져요.";
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColor.orange5.withOpacity(0.6),
          cursorColor: AppColor.orange5,
          selectionHandleColor: AppColor.orange5,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      child: BlocListener<PostCreationBloc, PostCreationState>(
        listener: (context, state) {
          if (state is! PostCreationLoaded) return;

          if (state.createdPost != null) {
            eventBus.fire(PostCreatedEvent(state.createdPost!));
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("게시글 작성", style: Theme.of(context).textTheme.titleSmall),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: AppElevatedButton.orange5Long(
              onPressed: () {
                AppDefaultDialog.show(
                  context,
                  title: "작성을 중단하시겠어요?",
                  content: "지금까지 작성한 게시글은 삭제됩니다.",
                  cancelButtonText: "네",
                  confirmButtonText: "아니오",
                  onCancel: () => context.pop(),
                );
              },
              title: "취소",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14.w)),
                      SizedBox(height: 10.h),
                      TitleTextField(textEditingController: _titleController, hintText: title),
                      const SizedBox(height: 20),
                      Text('내용', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14.w)),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: ContentTextField(textEditingController: _contentController, hintText: contentHintText),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SafeArea(child: BlocBuilder<PostCreationBloc, PostCreationState>(
                  builder: (context, state) {
                    if (state is! PostCreationLoaded) {}

                    bool isButtonEnabled = false;

                    if (state.isTitleEmpty == false && state.isContentEmpty == false) {
                      isButtonEnabled = true;
                    }

                    return PostCreationCompletionButton(isButtonEnabled: isButtonEnabled);
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required TextEditingController textEditingController,
    required this.hintText,
  }) : _titleController = textEditingController;

  final TextEditingController _titleController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.w, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(13.w),
        hintText: '$hintText을 입력해주세요.',
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.w, color: AppColor.gray11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.gray12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.black2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.gray12),
        ),
      ),
    );
  }
}

class ContentTextField extends StatelessWidget {
  const ContentTextField({
    super.key,
    required TextEditingController textEditingController,
    required this.hintText,
  }) : _contentController = textEditingController;

  final TextEditingController _contentController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _contentController,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.w, color: Colors.black),
      expands: true,
      maxLines: null,
      maxLength: 2000,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.w, color: AppColor.gray11),
        contentPadding: EdgeInsets.all(14.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.gray12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.black2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.gray12),
        ),
      ),
    );
  }
}

class PostCreationCompletionButton extends StatelessWidget {
  const PostCreationCompletionButton({super.key, required this.isButtonEnabled});

  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isButtonEnabled ? () => context.read<PostCreationBloc>().add(const PostCreationRegisterRequested()) : null,
      child: Container(
        width: double.infinity,
        height: 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isButtonEnabled ? AppColor.orange5 : AppColor.gray12,
        ),
        child: Center(
          child: Text(
            "작성완료",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 15.w, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
