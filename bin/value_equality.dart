// Dart의 모든 클래스들은 Object클래스를 부모로 상속받는다.
class A {
  final int value;

  const A(this.value);

  // toString() 메서드의 기본 동작을 오버라이딩
  // print()를 통해서 원하는 출력 값을 설정할 수 있다.
  @override
  String toString() {
    return "A($value)";
  }

  // Object에서는 비교연산자의 연산결과를 override가 가능하도록 제공한다.
  @override
  bool operator ==(Object other) {
    return identical(this, other) || // 메모리 주소가 같으면 true 반환 (참조 비교)
        other is A && runtimeType == other.runtimeType && value == other.value;
    // 비교 대상이 A or A의 하위 클래스인지 && 타입이 같은지 && 속성이 같은지 (int는 불변 객체이므로 참조 비교의 결과와 값 비교의 결과가 동일해야함)
  }

  // hashCode를 얻는 값도 override를 통해 기본 동작을 변경할 수 있다.
  // hashCode는 보통 Map, Set등의 해시 기반 자료형에서 값을 찾을 때 사용한다. (단, 비교 연산자를 수정하는 경우 hashCode도 같이 수정해야 한다. 그렇지 않으면 해시 기반 자료형이 의도와 다르게 동작하게 된다.)
  // hashCode 기반의 자료형은 hashCode 값이 변경되지 않는다는 전제하에 구현되므로 불변 객체로 만드는 것이 좋다. (final과 const를 이용)
  @override
  int get hashCode => value.hashCode;
}

void main() {
  print(A(1) == A(1));
  print(A(1));
}
