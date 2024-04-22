import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class HappyMealService {
  Future<Document> fetchHappyMeals() async {
    final response = await http.get(
        Uri.parse('https://happydorm.or.kr/busan/ko/0606/cafeteria/menu/'));

    if (response.statusCode == 200) {
      var document = parse(response.body);
      return document;
    } else if (response.statusCode == 404) {
      throw Exception('페이지를 찾을 수 없습니다.');
    } else if (response.statusCode == 500) {
      throw Exception('서버 오류가 발생했습니다.');
    } else {
      throw Exception('알 수 없는 오류가 발생했습니다.');
    }
  }
}
