// extension
// 특정 클래스의 기능을 추가

class Machine {}

// extension을 이용해 기능 추가
extension MyMachineExt on Machine {
  void scanning() => print('scanning...');
  void printing() => print('printing...');
}

void main() {
  final machine = Machine();
  print(machine); // 에러 보기 싫어서 넣음.
  // machine.scanning();
  // machine.printing();

  // extension function 호출
  print('HELLO'.equalsIgnoreCase('hello'));
}

// extension 키워드를 이용하면 클래스 수정없이 기능을 확장할 수 있다.
// String 클래스를 확장
extension MyStringExt on String {
  // function, getter, setter... 등 추가 기능

  // 대소문자 무시 비교
  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }
}
