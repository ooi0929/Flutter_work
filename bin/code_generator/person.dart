// 커스텀 클래스를 만들 때 매번 반복하여 구현해야 하는 코드가 존재한다.
//
// 객체 로깅: toString()
// 값 비교: == & hashCode
// 객체 복사: copyWith()
// JSON 변환: fromJson() & toJson()
//
// 다음 패키지들을 이용하면 반복되는 코드들을 자동으로 생성한다.
//
// build_runner: 코드 생성
// freezed & freezed_annotation: toString(), ==, hashCode, copyWith()
// json_serializable & json_annotation: fromJson(), toJson()
//
// 배포 전 개발 환경에서만 필요한 dev_dependency에 추가될 패키지
// freezed & build_runner & json_serializable
//
// 배포 환경에서도 사용될 dependency에 추가될 패키지
// freezed_annotation & json_annotation

// VSCode Extension
//
// 1. Flutter freezed Helpers - freezed 코드를 쉽게 작성하도록 도와주는 확장 프로그램
// 2. Build Runner - 코드가 변경된 경우 자동으로 코드를 생성하도록 도와주는 확장 프로그램

// Flutter freezed Helpers 패키지를 이용해 freezed 자동완성
// 1. frf라고 작성한 뒤 자동완성
// 2. 동일한 이름에 Person이라고 클래스 이름을 입력한 뒤, ESC를 누르면 커서가 1개로 되돌아온다.
// 3. factory Person() 생성자 사이에 String name과 같이 이름 지정 매개변수를 작성하면 코드 생성 시 String name; 속성을 갖도록 만들어준다.
// 4. 아직 코드를 다 작성하지 않았기에 오류 발생
// 5. dart -> dart run build_runner build, flutter -> flutter run build_runner build
//    를 통해 코드를 생성해준다.
// 6. 다음과 같은 파일이 생성된다.
//    person.freezed.dart: ==, hashCode, copyWith(), toString() 코드 생성
//    person.g.dart: fromJson(), toJson() 코드 생성
// 7. int age 속성 추가해보기
// 8. VSCode 좌측 하단에 Watch 버튼 클릭 -> Remove watch로 변경되고, build가 실행된 것을 확인
//    Watch 중인 경우에는 터미널에 직접 코드 생성 명령어를 내리지 않아도, 수정시 자동으로 코드 생성
//    Remove watch를 클릭하였을 때, 아래와 같이 에러가 뜬다면 VSCode를 재시작하여 Watch를 중지할 수 있다.

// 주의 사항) 코드 생성기로 생성된 파일은 수정하지 않고, person.dart 파일을 수정한 뒤 다시 코드 생성 명령어를
//          실행하여 파일을 재생성하는 방식으로 진행한다.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  factory Person({required String name, required int age}) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
