void main() {
  final parent = Parent(id: 1);

  // 출력: 1
  print(parent.id);

  final child = Child(id: 3);

  // 출력: 2
  print(child.id);

  // 팩토리 생성자의 인스턴스화도 일반 생성자의 인스턴스화와 같다.
  final parent2 = Parent.fromInt(5);

  // 출력: 5
  print(parent2.id);

  // 출력: Instance Of Child
  print(parent2);
}

class Parent {
  final int id;

  Parent({
    required this.id,
  });

  // factory constructor
  // 일반 메서드처럼 바디가 존재
  // 무조건 현재 클래스의 인스턴스를 반환해줘야 한다.

  // 팩토리 생성자라 하더라도 생성자이기 때문에 똑같은 이름의 생성자는 생성이 불가능하다.
  // 메서드처럼 이름 생성이 가능
  // factory Parent.fromInt(int id) {
  //   return Parent(id: id);
  // }

  // 팩토리 생성자에서는
  // 자식 클래스의 인스턴스를 반환해줘도 된다.
  factory Parent.fromInt(int id) {
    return Child(id: id);
  }
}

class Child extends Parent {
  Child({
    required super.id,
  });
}
