// mixin
// 자유롭게 여러 클래스의 속성과 메서드를 섞을 수 있다.

// mixin 클래스 생성
mixin class Scanner {
  void scanning() => print('scanning...');
}

mixin class Printer {
  void printing() => print('printing...');
}

// with 키워드를 통해 mixin 키워드를 포함하고 있는 것들의 속성과 메서드를 사용 가능
class Machine with Printer, Scanner {}

void main() {
  final machine = Machine();
  machine.printing();
  machine.scanning();
}

// 두 클래스에 동일한 이름의 메서드나 속성이 존재하는 경우,
// 더 뒤에 선언된 클래스의 것이 사용된다.

// extends와 with를 함께 사용하는 것도 가능하다.
class Machine2 extends Printer with Scanner {}

// Dart 3.0.0 이전
// mixin / with -> abstract와 유사
class Scanner2 {} // mixin 가능 & 인스턴스 생성 가능

mixin Scanner3 {} // mixin 가능 & 인스턴스 생성 불가능

// Dart 3.0.0 이후
// mixin / with -> interface와 유사
class Printer2 {} // mixin 불가능 & 인스턴스 생성 가능

mixin Printer3 {} // mixin 가능 & 인스턴스 생성 불가능

mixin class Printer4 {} // mixin 가능 & 인스턴스 생성 가능

// Dart 버전 확인 
// flutter --version

// Dart 버전 업데이트
// 1. flutter upgrade
// 2. VSCode 재실행
// 3. pubspec.yaml 파일에서 Dart 버전 확인 (만약, sdk의 버전이 3.0.0 미만으로 설정되어 있다면 변경해주기)