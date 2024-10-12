class Document {
  // 내용
  String _content; // _ 로 시작하는 경우 다른 파일에서 접근 불가 (private)

  String get content {
    _readCount += 1;
    return _content;
  } // 오로지 읽기를 수행하는 경우에만 가능

  set content(String content) {
    // set 키워드를 사용한 함수 - Setter
    _content = content;
    _updateCount += 1;
  }

  // 미래의 나 또는 동료가 실수하지 않도록 외부에서 변경을 못하도록 만들기. _ 활용
  // 외부에서 접근하지 못하도록 데이터를 숨기는 과정 - 캡슐화(Encapsulation)
  // 읽은 횟수
  int _readCount = 0;

  // 수정 횟수
  int _updateCount = 0;

  // 통계
  // 다른 속성을 초깃값으로 사용하려면 앞에 late 키워드를 사용해야 함.
  // late String statistic = "readCount : $readCount / updateCount : $updateCount"; // 매번 값을 가져오도록 변경하자.
  String get statistic =>
      "readCount: $_readCount / updateCount : $_updateCount"; // get 키워드를 사용한 함수 - Getter

  // 의존 관계에 따른 데이터 신뢰성 해결
  // 문제 -> 누군가 실수로 count를 갱신하지 않는 가정.
  // 해결 -> Getter & Setter를 이용해 방어적인 코드를 작성하여 인적 오류를 방지하자.

  Document(this._content);
}
