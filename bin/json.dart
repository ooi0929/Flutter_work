import 'dart:convert';

// 직렬화 & 역직렬화 구현
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  // factory - 생성자 메서드
  // * 클래스 인스턴스를 반환해야 한다.
  // * 클래스명.메서드명() 형태로 메서드명을 작성해야 한다.

  // 일반적으로 Map<String, dynamic>으로부터 클래스 인스턴스를 반환하는 코드는
  // 클래스에 fromJson()이라는 메서드를 생성하여 구현한다.
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
    );
  }

  // 일반적으로 클래스 인스턴스를 Map<String, dynamic>으로 변경하는 함수는
  // 클래스에 toJson()이라는 메서드를 생성하여 구현한다.
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
    };
  }
}

void main() {
  // 네트워크 응답 문자열
  String jsonString = '{"name":"철수", "age":10}';

  // 역직렬화 진행 순서 (JSON 포맷 문자열 -> Person)
  // 1. JSON 포맷 String -> Map<String, dynamic>
  // 2. Map<String, dynamic> -> Person

  // 1번
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  print(jsonMap);

  // 2번
  Person person1 = Person(
    name: jsonMap["name"],
    age: jsonMap["age"],
  );
  print(person1.name);
  print(person1.age);

  // factory 생성자를 사용한 역직렬화 구현
  Person person2 = Person.fromJson(jsonMap);
  print(person2.name);
  print(person2.age);

  // 직렬화 진행 순서 (Person -> JSON 포맷 문자열)
  // 1. Person 클래스 -> Map<String, dynamic>
  // 2. Map<String, dynamic> -> JSON 포맷 String

  // 1번
  Map<String, dynamic> personMap = person1.toJson();
  print(personMap);

  // 2번
  String personString = jsonEncode(personMap);
  print(personString);
}
