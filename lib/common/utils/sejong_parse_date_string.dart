DateTime parseDateString(String formattedDate) {
  // 정규 표현식을 사용하여 월과 일 추출
  final RegExp regex = RegExp(r'(\d{1,2})/(\d{1,2})');
  final Match match = regex.firstMatch(formattedDate)!;

  // 정규 표현식에서 그룹 1은 월, 그룹 2는 일을 나타냅니다.
  final int month = int.parse(match.group(1)!);
  final int day = int.parse(match.group(2)!);

  // 현재 연도 가져오기
  int currentYear = DateTime.now().year;

  // DateTime 객체 생성
  DateTime dateTime = DateTime(currentYear, month, day);
  return dateTime;
}
