import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/widget/app_default_dialog.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/config/themes/app_text_style.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/bloc/create_post_bloc.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/image_selection_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/widget/create_post_submit_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/price_type_filtering_button.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/product_detail_text_filed.dart';
import 'package:flutter_whattodayrice/modules/second-hand/create_post/widget/title_text_field.dart';
import 'package:flutter_whattodayrice/utils/number_input_formatter.dart';
import 'package:go_router/go_router.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final productDetailController = TextEditingController();
  final tradingLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<CreatePostBloc>();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ImageSelectionButton(),
                    const SizedBox(height: 16),
                    Text(
                      '제목',
                      style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
                    ),
                    const SizedBox(height: 8),
                    TitleTextField(titleController: titleController, hintText: '제목을 입력해주세요.', maxLength: 50),
                    const SizedBox(height: 24),

                    /// 가격
                    Text(
                      '가격',
                      style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        PriceTypeButton.sell(isSelected: true),
                        const SizedBox(width: 6),
                        PriceTypeButton.share(isSelected: false),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TitleTextField(
                      titleController: priceController,
                      hintText: '₩ 가격을 입력해주세요.',
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, NumberInputFormatter()],
                    ),
                    const SizedBox(height: 24),

                    /// 상품 설명
                    Text(
                      '상품 설명',
                      style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ProductDetailTextField(
                        contentController: productDetailController,
                        hintText:
                            '판매와 관련 없는 글은 게시가 제한될 수 있어요.\n\n신뢰할 수 있는 거래를 위해 브랜드, 모델명, 구매시기,\n하자 유무 등 상품 설명을 최대한 자세히 적어주세요.',
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// 거래 희망 장소
                    Text(
                      '거래 희망 장소',
                      style: AppTextStyle.bold14.copyWith(color: AppColor.black000000),
                    ),
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
            CreatePostSubmitButton(isButtonEnabled: true),
          ],
        ),
      ),
    );
  }
}
