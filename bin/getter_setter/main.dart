import 'document.dart';

void main() {
  final doc = Document('1');

  // 조회
  String content = doc.content;
  print(content); // 경고 보기 싫어서 그냥 넣음
  // doc.readCount += 1;
  print(doc.statistic);

  // 수정
  doc.content = '2';
  // doc.updateCount += 1;
  print(doc.statistic);

  // Debug Console에서 같은 통계가 두 번이나 출력된다.
  // late 키워드로 인해 통계 변수에 처음 접근할 때에 값이 할당되고(늦은 초기화),
  // 이후 통계 변수에 접근할 때에 이미 할당된 값을 반환하기 때문이다.
  // 따라서 통계 변수 속성에 접근할 때마다 매번 값을 가져오도록 해야한다.
}
