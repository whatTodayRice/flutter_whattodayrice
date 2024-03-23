import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/dto_user_info.dart';
import '../components/w_move_home_screen_button.dart';
import '../components/w_pig_animation.dart';

class CompletedScreen extends ConsumerStatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends ConsumerState<CompletedScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final defaultTextStyle = Theme.of(context).textTheme.titleMedium!;
    final userNickName = ref.watch(userNickNameProvider);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * 0.25,
              ),
              const PigAnimationWidget(),
              SizedBox(
                height: media.height * 0.05,
              ),
              SizedBox(
                width: double.infinity,
                child: RichText(
                    text:
                        TextSpan(style: defaultTextStyle, children: <TextSpan>[
                  const TextSpan(text: "환영해요!"),
                  TextSpan(
                      text: '\n$userNickName',
                      style: defaultTextStyle.copyWith(
                          color: const Color(0xFFFF833D))),
                  const TextSpan(text: ' 님\n맛있는 식사를 하러 가볼까요?'),
                ])),
              ),
              SizedBox(
                height: media.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFFF833D),
                ),
                width: double.infinity,
                height: media.height * 0.1,
                child: const MoveToHomeScreenButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
