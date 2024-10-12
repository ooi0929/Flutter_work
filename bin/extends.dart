// extends 키워드
// 특정 클래스의 기능을 상속

class Scanner {
  void scanning() => print('scanning...');
}

class Printer {
  void printing() => print('printing...');
}

class Machine extends Printer {}
// class Machine extends Printer, Scanner {} // 다음과 같이 다중 상속은 불가
// class Printer extends Scanner {} // Printer가 Scanner를 상속받아 구현...

void main() {
  final machine = Machine();
  machine.printing();
  // machine.scanning();
}
