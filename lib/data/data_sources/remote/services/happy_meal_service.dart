import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton()
class HappyMealService {
  const HappyMealService();

  Future<Document?> fetchHappyMeals() async {
    try {
      final response = await http.get(
        Uri.parse('https://happydorm.or.kr/busan/ko/0605/cafeteria/menu/'),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'
        },
      );

      if (response.statusCode == 200) {
        var document = parse(response.body);

        debugPrint(document.toString());

        return document;
      } else if (response.statusCode == 404) {
        throw Exception('페이지를 찾을 수 없습니다.');
      } else if (response.statusCode == 500) {
        throw Exception('서버 오류가 발생했습니다.');
      } else {
        throw Exception('알 수 없는 오류가 발생했습니다.');
      }
    } catch (error) {
      debugPrint(error.toString());

      return null;
    }
  }
}
