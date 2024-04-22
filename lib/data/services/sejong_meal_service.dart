import 'dart:convert';
import 'dart:io';
import 'package:html/parser.dart';

class SejongDormMealService {
  Future<List<String>> fetchSejongMeal(int menuIndex) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final HttpClientRequest request = await httpClient.getUrl(Uri.parse(
        'https://dormitory.pknu.ac.kr/03_notice/req_getSchedule.php'));
    final HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      var document =
          parse(await response.transform(const Utf8Decoder()).join());
      var targetElement = document.getElementsByClassName('board_box').first;
      String data = targetElement.text.replaceAll('\t', '');

      String data2 = data.replaceAll('\n', ',');
      List<String> sejongMealPageData =
          data2.split(',,').sublist(menuIndex, menuIndex + 8);
      print("sejongMealPageData: $sejongMealPageData");
      return sejongMealPageData;
    } else {
      throw Exception('식단을 기다리고 있어요 \n조금만 기다려주세요:grinning: ');
    }
  }
}
