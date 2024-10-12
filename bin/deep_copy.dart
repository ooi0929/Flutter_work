// Deep Copy (깊은 복사)
// 값이 동일한 객체를 새롭게 생성하는 것을 의미

// 두 변수가 다른 메모리를 바라보게 됨.
// 데이터의 의도치 않은 변경을 막을 수 있지만, 메모리 사용량이 증가한다.

void main() {
  List<int> a = [1];
  List<int> b = a.toList(); // 깊은 복사 (새로운 배열 생성)

  print(a == b); // false (a와 b가 다른 메모리 주소를 가짐)

  a.add(2);
  print(a); // [1, 2]
  print(b); // [1]

  // ver.Map
  // Map은 ...(전개 연산자, Spread Operator)를 이용해 깊은 복사가 가능하다.
  Map<int, int> c = {1: 1};
  Map<int, int> d = {...c};

  c[1] = 2;
  print(c == d); // false (메모리 주소 다름)
  print(c); // {1: 2}
  print(d); // {1: 1}

  // ver.List
  List<int> e = [1];
  print(e);

  /// 방법1) 배열.toList() 활용
  List<int> f = e.toList();
  print(f);

  /// 방법2) 전개 연산자(Spread Operator) 활용
  List<int> g = [...e];
  print(g);

  /// 방법3) 반복문 활용
  List<int> h = [for (var i in a) i];
  print(h);

  /// 방법4) JSON 직렬화 & 역직렬화 활용
  /// import 'dart:convert';
  /// List<int> i = jsonDecode(jsonEncode(a)).cast<int>();

  // ver.List중첩
  // 중첩된 내부 객체를 별도로 복사해야 함.
  List<List<int>> j = [
    [1]
  ];
  List<List<int>> k = j.toList(); // 첫 번째 배열 신규 생성

  print(j == k); // false (메모리 주소 다름)
  j.add([2]);
  print(j); // [[1], [2]]
  print(k); // [[1]]

  // 첫 번째 배열만 메모리 주소가 다름, 내부 메모리 주소는 동일하기에 변경해야함
  // 전체 객체를 깊은 복사를 하려면 내부 배열도 새로 생성해야한다.
  List<List<int>> l = [
    [1]
  ];

  /// map() & toList() & Spread Operator
  /// map()은 배열을 순환하며 값을 변경할 수 있는 함수이다.
  /// map()는 Iterable을 반환한다.
  ///
  /// List: Iterable의 하위 클래스로 배열의 모든 원소를 메모리에 올려두고 사용
  /// Iterable: 순차적으로 접근 가능한 요소의 모음으로 접근하는 요소만 메모리에 올린다.
  List<List<int>> n = l.map((i) => i.toList()).toList();
  print(n);

  List<List<int>> m = l.map((i) => [...i]).toList();
  print(m);

  List<List<int>> o = [...l.map((i) => i.toList())];
  print(o);

  List<List<int>> p = [
    ...l.map((i) => [...i])
  ];
  print(p);

  A q = A(1, 2, 3);
  print(q);
  A r = A(q.value1, q.value2, q.value3); // 깊은 복사
  print(r);
  A s = q.copyWith(); // 깊은 복사
  print(s);
}

// 커스텀 클래스의 복사도 얇은 복사와 깊은 복사로 나뉜다.
// 클래스의 신규 인스턴스를 생성하여 주기만 한다면 깊은 복사를 할 수 있다.
class A {
  int value1;
  int value2;
  int value3;

  // 신규 인스턴스를 만들 때 기존 클래스의 속성을 생성자에게 매번 전달하는 것은 번거롭다.
  A(
    this.value1,
    this.value2,
    this.value3,
  );

  // copyWith()
  // 현재 인스턴스의 속성들을 복사하여 새로운 인스턴스를 반환하는 메서드
  // 특정 값만 다르게 복사하고 싶은 경우, 해당 값을 별도로 이름 지정 매개변수로 전달하면 된다.
  A copyWith({
    int? value1,
    int? value2,
    int? value3,
  }) {
    return A(
      value1 ?? this.value1, // value1이 null이면 현재 인스턴스의 value1 전달
      value2 ?? this.value2,
      value3 ?? this.value3,
    );
  }
}
