import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/image_preview.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/button_01.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/sell_type_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/content_text_field.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/title_text_field.dart';
import 'package:flutter_whattodayrice/utils/number_input_formatter.dart';
import 'package:go_router/go_router.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final imageUrlController = TextEditingController();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final productDetailController = TextEditingController();
  final tradingLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<CreatePostBloc>();

    imageUrlController.addListener(
      () => bloc.add(CreatePostImageUrlChangeRequested(imageUrl: imageUrlController.text)),
    );

    titleController.addListener(
      () => bloc.add(CreatePostTitleChangeRequested(title: titleController.text)),
    );

    priceController.addListener(
      () => bloc.add(CreatePostPriceChangeRequested(price: priceController.text)),
    );

    productDetailController.addListener(
      () => bloc.add(CreatePostContentChangeRequested(content: productDetailController.text)),
    );

    tradingLocationController.addListener(
      () => bloc.add(CreatePostTradeLocationChangeRequested(location: tradingLocationController.text)),
    );
  }

  @override
  void dispose() {
    tradingLocationController.dispose();
    productDetailController.dispose();
    priceController.dispose();
    titleController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostSucceed) {
          context.pop(true);
        } else if (state is CreatePostError) {
          if (state.errorMessage == null) {
            return;
          }

          AppDefaultDialog.show(
            context,
            title: '',
            content: state.errorMessage!,
            confirmButtonText: '확인',
            onConfirm: () => Navigator.pop(context),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '게시글 작성',
            style: AppTextStyle.bold16.copyWith(color: AppColor.black000000),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              final result = await AppDefaultDialog.show(
                context,
                title: '작성을 중단하시겠어요?',
                content: '지금까지 작성한 게시글은 삭제됩니다.',
                cancelButtonText: '네',
                onCancel: () => Navigator.of(context).pop(true),
                confirmButtonText: '아니오',
                onConfirm: () => Navigator.of(context).pop(false),
              );

              if (result != true) {
                return;
              }

              context.pop();
            },
            icon: Text(
              '취소',
              style: AppTextStyle.regular16.copyWith(color: AppColor.grayA0A0A0),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSpan.imageUrl(),
                      const SizedBox(height: 4),
                      Text(
                        '이미지 URL을 입력하면, 이미지 미리보기가 제공돼요.',
                        style: AppTextStyle.regular11.copyWith(color: AppColor.grayB2B2B2),
                      ),
                      const SizedBox(height: 8),
                      TitleTextField(titleController: imageUrlController, hintText: '이미지의 URL을 입력해주세요.'),
                      const SizedBox(height: 16),
                      BlocBuilder<CreatePostBloc, CreatePostState>(
                        buildWhen: (previous, current) => current is CreatePostImageUploadChecked,
                        builder: (context, state) {
                          String imageUrl = "";

                          if (state is CreatePostImageUploadChecked) {
                            imageUrl = state.imageUrl;
                          }

                          return ImagePreview(imageUrl: imageUrl);
                        },
                      ),
                      const SizedBox(height: 24),

                      /// 제목
                      TitleSpan.title(),
                      const SizedBox(height: 8),
                      TitleTextField(titleController: titleController, hintText: '제목을 입력해주세요.', maxLength: 50),
                      const SizedBox(height: 24),

                      /// 가격
                      TitleSpan.price(),
                      const SizedBox(height: 8),
                      BlocBuilder<CreatePostBloc, CreatePostState>(
                        buildWhen: (previous, current) => current is CreatePostSelectedSellTypeChecked,
                        builder: (context, state) {
                          int selectedIndex = 0;

                          if (state is CreatePostSelectedSellTypeChecked) {
                            selectedIndex = state.index;
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  SellTypeButton.sell(
                                    onTap: () => context.read<CreatePostBloc>().add(CreatePostPriceTypeChangeRequested(
                                        typeIndex: ProductSellStatus.isOngoing.index)),
                                    selectedIndex: selectedIndex,
                                  ),
                                  const SizedBox(width: 6),
                                  SellTypeButton.share(
                                    onTap: () => context.read<CreatePostBloc>().add(
                                        CreatePostPriceTypeChangeRequested(typeIndex: ProductSellStatus.shared.index)),
                                    selectedIndex: selectedIndex,
                                  ),
                                ],
                              ),
                              if (selectedIndex == ProductSellStatus.isOngoing.index) ...[
                                const SizedBox(height: 12),
                                TitleTextField(
                                  titleController: priceController,
                                  hintText: '₩ 가격을 입력해주세요.',
                                  inputType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, NumberInputFormatter()],
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      /// 상품 설명
                      TitleSpan.content(),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: ContentTextField(
                          contentController: productDetailController,
                          maxLength: 2000,
                          hintText:
                              '판매와 관련 없는 글은 게시가 제한될 수 있어요.\n\n신뢰할 수 있는 거래를 위해 브랜드, 모델명, 구매시기,\n하자 유무 등 상품 설명을 최대한 자세히 적어주세요.',
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// 거래 희망 장소
                      TitleSpan.location(),
                      const SizedBox(height: 8),
                      TitleTextField(
                        titleController: tradingLocationController,
                        hintText: '거래를 희망하는 장소를 구체적으로 입력해주세요.',
                        maxLength: 50,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<CreatePostBloc, CreatePostState>(
                buildWhen: (previous, current) => current is CreatePostSubmitValidationChecked,
                builder: (context, state) {
                  bool isValid = false;

                  if (state is CreatePostSubmitValidationChecked) {
                    isValid = state.isValid;
                  }

                  return Button01(
                    isButtonEnabled: isValid,
                    onTap: () => context.read<CreatePostBloc>().add(const CreatePostSubmitRequested()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleSpan extends StatelessWidget {
  const TitleSpan({super.key, required this.title, required this.isRequired});

  final String title;
  final bool isRequired;

  factory TitleSpan.imageUrl() => const TitleSpan(title: '이미지 URL', isRequired: false);
  factory TitleSpan.title() => const TitleSpan(title: '제목', isRequired: true);
  factory TitleSpan.price() => const TitleSpan(title: '가격', isRequired: true);
  factory TitleSpan.content() => const TitleSpan(title: '상품 설명', isRequired: true);
  factory TitleSpan.location() => const TitleSpan(title: '거래 희망 장소', isRequired: true);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
        children: [
          TextSpan(text: title),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTextStyle.bold14.copyWith(color: AppColor.orangeFF6060),
            )
        ],
      ),
    );
  }
}
