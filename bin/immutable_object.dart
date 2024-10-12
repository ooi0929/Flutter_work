// 불변 객체(Immutable Object)

// 사용 이유
// 1. 개발자의 지식 수준과 관련없이 상황에 적절한 코드를 작성하도록 강제하며 얇은 복사와 깊은 복사의 장점을 모두 누릴 수 있다.
// 2. 값 비교 구현시 hashCode 변경을 방지할 수 있다.

// 특징
// 1. 동일한 메모리에서 값 수정이 불가하다.
// * 데이터의 예기치 않은 변경으로부터 안전
// * 얇은 복사 활용 가능(메모리 절약)
// * 멀티 스레드 프로그래밍에 유용

// 2. 수정 대신 새 인스턴스 생성
// * 수정 코드 실행 시 에러 발생
// * const로 생성된 객체들은 값이 동일한 경우 얇은 복사 활용(메모리 절약)
// * 가변 객체에 비해 코드가 길고, 연산량이 많음

// 상황에 따라 가변 객체를 사용하는 경우가 더 나을 때가 있다.
// 그렇기에 많은 프로그래밍 언어에서 둘 중 하나를 선택하여 사용할 수 있도록 구현되어 있다.

// 불변 객체 - 배열
void main() {
  // 추가
  // spread operator
  List<int> a1 = const [1];
  a1 = [...a1, 2];
  print(a1); // [1, 2]

  // 수정
  // map
  List<int> b1 = const [1];
  b1 = b1.map((v) => v == 1 ? 2 : v).toList();
  print(b1); // [2]

  // 삭제
  // where
  List<int> c1 = const [1];
  c1 = c1.where((v) => v != 1).toList();
  print(c1); // []

  // List.unmodifiable()을 이용하면 런타임 배열의 수정을 막을 수 있다. (불변 객체를 다룰 때 선택사항)
  a1 = List.unmodifiable([...a1, 2, 3]);

  A a = A(value1: 1, value2: 1);
  A b = a; // 얇은 복사

  // a.value1 = 2; // 에러 발생
  a = A(value1: 2, value2: a.value2); // 깊은 복사
  print(a);
  print(b);

  a = a.copyWith(value1: 2); // 깊은 복사
  print(a);
  print(b);
}

class A {
  final int value1;
  final int value2;

  const A({
    required this.value1,
    required this.value2,
  });

  @override
  String toString() {
    return 'A(value1:$value1, value2:$value2)';
  }

  // 불변 객체에 값을 수정하고 싶을 때, 값이 변경된 객체를 생성하는데 copyWith() 함수를 만들어 사용하면 편리하다.
  A copyWith({
    int? value1,
    int? value2,
  }) {
    return A(
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
    );
  }
}
