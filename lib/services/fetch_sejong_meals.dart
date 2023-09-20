import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List<String>> fetchSejongMeal(int menuIndex) async {
  // 인증서 검증 무시
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  final HttpClientRequest request = await httpClient.getUrl(
      Uri.parse('https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));
  final HttpClientResponse response = await request.close();

  if (response.statusCode == 200) {
    var document = parse(await response.transform(Utf8Decoder()).join());
    var targetElement = document.getElementsByClassName('board_box').first;
    String data = targetElement.text.replaceAll('\t', '');

    String data2 = data.replaceAll('\n', ',');
    print(data2);

    List<String> mealTime = data2.split(',,').sublist(menuIndex, menuIndex + 8);

    return mealTime;
  } else {
    throw Exception('식단을 기다리고 있어요 조금만 기다려주세요😀 ');
  }
}
