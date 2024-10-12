// JSON (JavaScript Object Notation)
// 데이터를 표현하는 규칙(포맷)이다.

// 네트워크를 통해 다른 컴퓨터로 데이터 전송할 때 일련의 바이트(문자열)로 전달하는데
// 이때, JSON 포맷을 따르는 문자열로 보내면 수신측에서 데이터를 다루기 편리하다.

// 직렬화(Serialization) / 역직렬화(Deserialization)

// 사용 이유
// 네트워크 전송시, 직렬화해야 데이터를 보낼 수 있다.
// 네트워크 수신시, 역직렬화를 하지 않으면 다음과 같은 불편함이 있다.
//
// 1. 원하는 값을 추출하기 어렵다.
// 2. 데이터 자료형이 모두 String이므로 다른 타입의 내장 메서드를 사용할 수 없다.

// 일련의 문자열이 JSON 포맷을 따른다면 쉽게 직렬화&역직렬화를 구현할 수 있다.

import 'dart:convert';

void main() {
  // JSON 포맷의 문자열
  String json = '{"name":"철수", "age":10}';
  print(json.substring(9, 11)); // "철수"

  // 역직렬화(Deserialization): String -> Map
  Map<String, dynamic> jsonMap = jsonDecode(json);
  print(jsonMap["name"]); // "철수"

  // 직렬화(Serialization): Map -> String
  String jsonString = jsonEncode(jsonMap);
  print(jsonString.substring(9, 11)); // "철수"
}
