import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle display = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle heading01 = TextStyle(
    // 우선 UI 화면에 맞추기 위해 임의로 변경
    // fontSize: 20.0, 원래의 폰트 사이즈
    //변경한 폰트 사이즈
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle heading02 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle title01 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle title02 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title03 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body01 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body02 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body03 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body04 = TextStyle(
    //fontSize: 12.0,
    //임의 변경함
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
  );
}
