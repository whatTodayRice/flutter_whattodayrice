import 'package:flutter/material.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/app_text_field.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/w_custom_close_button.dart';

class RegisterNameScreen extends StatefulWidget {
  const RegisterNameScreen({super.key});

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  late final TextEditingController _nameTextController;

  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameTextController = TextEditingController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "이름을 입력해주세요.",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 26),
            ),
            const SizedBox(height: 100),
            AppTextField(
              controller: _nameTextController,
              focusNode: _nameFocusNode,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.black),
              hintText: '이름',
              hintTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.grey),
              suffixIcon: CustomCloseButton(
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
