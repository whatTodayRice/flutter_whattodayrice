import 'dart:math';

String randomFoodNickname = '';

String generateRandomNickname() {
  final Random random = Random();
  final String adjective = adjectives[random.nextInt(adjectives.length)];
  final String food = foods[random.nextInt(foods.length)];
  final String randomFoodNickname = '$adjective $food';
  return randomFoodNickname;
}

final List<String> adjectives = [
  '혁신적인',
  '매력적인',
  '신선한',
  '감동적인',
  '화려한',
  '유쾌한',
  '풍요로운',
  '훌륭한',
  '따뜻한',
  '아름다운',
  '신비로운',
  '특별한',
  '즐거운',
  '자연스러운',
  '아늑한',
  '창의적인',
  '신나는',
  '신선한',
  '향기로운',
  '환상적인',
  '독특한',
  '활기찬',
  '매혹적인',
  '신속한',
  '생동감 있는',
  '기분 좋은',
  '건강한',
  '기발한',
  '활발한',
  '유익한',
];

final List<String> foods = [
  '덮밥',
  '스파게티',
  '피자',
  '김밥',
  '샐러드',
  '햄버거',
  '국수',
  '타코',
  '떡볶이',
  '간장게장',
  '곱창',
  '샌드위치',
  '갈비',
  '돈까스',
  '감바스',
  '귤',
  '초밥',
  '치킨',
  '라면',
  '탕수육',
  '파스타',
  '케이크',
  '카레',
  '스시',
  '갈비찜',
  '간장불고기',
  '부대찌개',
  '호두과자',
  '새우튀김',
  '딸기',
];
