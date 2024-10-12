// equatable을 통해 손쉽게 값 비교를 구현할 수 있다.
// hashCode 변경 문제를 고려하여 불변 객체를 전제로 설계된 패키지.

import 'package:equatable/equatable.dart';

// Equatable 클래스를 상속받고 props에 값을 명시하면 된다.
class A extends Equatable {
  final int value;

  const A(this.value);

  // 필수로 구현
  @override
  List<Object?> get props => [
        value // 값을 비교하려는 속성 명시
      ];
}

void main() {
  print(A(1) == A(1));
  print(A(1));
}
