import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/assets/assets.gen.dart';
import 'package:flutter_whattodayrice/common/widget/app_loading_indicator.dart';
import 'package:flutter_whattodayrice/common/widget/app_snack_bar.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/content_text_field.dart';
import 'package:flutter_whattodayrice/modules/second-hand/report/bloc/report_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/button_01.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<ReportBloc>();

    bloc.add(const ReportLoadRequested());

    textEditingController.addListener(
      () => bloc.add(ReportReasonContentChangeRequested(content: textEditingController.text)),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportBloc, ReportState>(
      listener: (context, state) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        if (state is ReportSubmitSucceed) {
          context.pop(true);
        } else if (state is ReportError) {
          if (state.message == null) {
            return;
          }

          scaffoldMessenger.showSnackBar(AppSnackBar.text(state.message!));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Assets.images.svg.iconRightArrowGray.svg(fit: BoxFit.scaleDown),
          ),
          title: Text('신고하기', style: AppTextStyle.bold16.copyWith(color: AppColor.black000000)),
          centerTitle: true,
        ),
        body: BlocBuilder<ReportBloc, ReportState>(
          buildWhen: (previous, current) => current is ReportLoaded,
          builder: (context, state) {
            if (state is! ReportLoaded) {
              return const Center(child: AppLoadingIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.regular14
                                  .copyWith(fontWeight: FontWeight.w600, color: AppColor.black121212),
                              children: [
                                const TextSpan(text: '게시글을 신고하는 이유를 선택해주세요. '),
                                TextSpan(
                                  text: '*필수',
                                  style: AppTextStyle.regular14
                                      .copyWith(fontWeight: FontWeight.w600, color: AppColor.orangeFF6060),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColor.grayDCDCDC),
                            ),
                            child: Column(
                              children: List.generate(
                                state.reportReasonList.length,
                                (index) => ReportReasonItem(
                                  onTap: () {
                                    context.read<ReportBloc>().add(ReportReasonSelectRequested(index: index));

                                    focusNode.unfocus();
                                  },
                                  reason: state.reportReasonList[index],
                                  isSelected: index == state.selectedIndex,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            '구체적인 신고내용을 작성해주세요.',
                            style: AppTextStyle.regular14
                                .copyWith(fontWeight: FontWeight.w600, color: AppColor.black121212),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 200,
                            child: ContentTextField(
                              contentController: textEditingController,
                              focusNode: focusNode,
                              hintText: '선택사유에 대한 내용을 작성해 주세요. 자세하게 적어주시면 신고처리에 큰 도움이 됩니다.',
                              maxLength: 300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ReportBloc, ReportState>(
                  buildWhen: (previous, current) => current is ReportSubmitValidationChecked,
                  builder: (context, state) {
                    bool isValid = false;

                    if (state is ReportSubmitValidationChecked) {
                      isValid = state.isValid;
                    }

                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Button01(
                          isButtonEnabled: isValid,
                          onTap: isValid ? () => context.read<ReportBloc>().add(const ReportSubmitRequested()) : null,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ReportReasonItem extends StatelessWidget {
  const ReportReasonItem({super.key, this.onTap, required this.reason, required this.isSelected});

  final VoidCallback? onTap;
  final String reason;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            if (isSelected != true)
              Assets.images.svg.iconCheckBoxOff.svg(width: 20, height: 20)
            else
              Assets.images.svg.iconCheckBoxOn.svg(width: 20, height: 20),
            const SizedBox(width: 10),
            Text(reason, style: AppTextStyle.regular14.copyWith(color: AppColor.black000000)),
          ],
        ),
      ),
    );
  }
}
