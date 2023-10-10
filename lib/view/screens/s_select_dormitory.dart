import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/view/components/w_selected_dorms_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/w_save_user_info_button.dart';
import 'package:image/image.dart' as img;

class SelectDormitoryScreen extends ConsumerStatefulWidget {
  const SelectDormitoryScreen({super.key});

  @override
  ConsumerState<SelectDormitoryScreen> createState() =>
      _SelectDormitoryScreenState();
}

class _SelectDormitoryScreenState extends ConsumerState<SelectDormitoryScreen>
    with
        SingleTickerProviderStateMixin,
        AfterLayoutMixin<SelectDormitoryScreen> {
  bool sejong1Selected = false;
  bool sejong2Selected = false;
  bool happySelected = false;

  void handleDormitorySelection(DormitoryType dormitoryType) {
    setState(() {
      // 선택한 버튼의 상태를 토글합니다.
      if (dormitoryType == DormitoryType.sejong1) {
        sejong1Selected = !sejong1Selected;
        // 나머지 버튼 선택 해제
        sejong2Selected = false;
        happySelected = false;
      } else if (dormitoryType == DormitoryType.sejong2) {
        sejong2Selected = !sejong2Selected;
        sejong1Selected = false;
        happySelected = false;
      } else if (dormitoryType == DormitoryType.happiness) {
        happySelected = !happySelected;
        sejong1Selected = false;
        sejong2Selected = false;
      }
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(flex: 20, child: Container()),
              Flexible(
                flex: 13,
                child: Row(children: [
                  Text("안녕하세요!\n현재 거주중인\n기숙사를 선택해주세요",
                      style: Theme.of(context).textTheme.headlineMedium!),
                ]),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Flexible(
                flex: 12,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SelectedDormitoryButton(
                      onPressed: () {
                        setState(() {
                          ref.watch(dormitoryProvider.notifier).state =
                              DormitoryType.sejong1;
                          handleDormitorySelection(DormitoryType.sejong1);
                        });
                      },
                      selected: sejong1Selected,
                      buttonText: "세종 1관"),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(),
              ),
              Flexible(
                flex: 12,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SelectedDormitoryButton(
                      onPressed: () {
                        setState(() {
                          ref.watch(dormitoryProvider.notifier).state =
                              DormitoryType.sejong2;
                          handleDormitorySelection(DormitoryType.sejong2);
                        });
                      },
                      selected: sejong2Selected,
                      buttonText: "세종 2관"),
                ),
              ),
              Flexible(flex: 5, child: Container()),
              Flexible(
                flex: 12,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SelectedDormitoryButton(
                    onPressed: () {
                      setState(() {
                        ref.watch(dormitoryProvider.notifier).state =
                            DormitoryType.happiness;
                        handleDormitorySelection(DormitoryType.happiness);
                      });
                    },
                    selected: happySelected,
                    buttonText: "행복기숙사",
                  ),
                ),
              ),
              Flexible(
                flex: 11,
                child: Container(),
              ),
              Flexible(
                flex: 8,
                child: SaveUserInfoButton(),
              ),
              Flexible(
                flex: 12,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
