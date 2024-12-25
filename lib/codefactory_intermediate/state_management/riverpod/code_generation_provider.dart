// riverpod도 part파일을 생성해줘야 한다.
// '파일이름.g.dart'

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 두 가지 요소로 인해 코드 생성 기능을 추가함
// 1) 어떤 Provider를 사용할지 결정할 고민 할 필요가 없도록
// Provider, FutureProvider, StreamProvider ... 중에 어떤 걸 쓸것인지.. (강의 기준 StreamProvider는 아직 안됐었음 지금은 될지도)
// StateNotifierProvider도 명시적으로 코드를 명시할 수 있음.
// 2) Parameter -> Family
// 파라미터를 일반 함수처럼 사용할 수 있도록
// 기존에는 한 가지의 파라미터만 전할 수 있었기에 여러 개를 전달하려면 Collection을 사용하거나 클래스를 생성해서 넘겨줬어야 했다.

// [1]
// final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

// _testProvider와 같이 프로바이더를 어떻게 코드 생성기로 만들냐?

// 1. riverpod 애노테이션 작성 (애노테이션도 임포트해야 에러가 안남)
// 2. 일반 함수 작성
// 3. 파라미터로 무조건 ref값 받기 (현재함수의이름+Ref 파라미터명) + 첫 번째 글자를 대문자로 변경
// 4. return에 반환값 작성
// 5. flutter pub run build_runner build 터미널 입력
// 6. 생성된 파일을 보면 함수 이름에 Provider가 붙여서 나오는 것을 확인할 수 있다.
// 7. 현재 파일에 있는 코드말고 생성된 파일 중 AutoDisposeProvider를 사용하면 된다.

// 따라서 위의 코드와 아래 코드는 동일하다.
// 다만 함수형태로 작성하였기 때문에 훨씬 더 직관적이다.
// 코드 제너레이션들을 통해서 추가 기능들을 제공받을 수 있다.

// 애노테이션을 이용해 riverpod 상태를 생성하면
// AutoDispose가 자동으로 걸리는 것을 확인할 수 있다.
@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

// FutureProvider 생성법
@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

// 대문자 Riverpod 애노테이션은 반드시 ()를 넣어줘야 한다.
// 파라미터를 하나 받는데 KeepAlive가 있다.
// 기본값은 false이고, 살려둬라라는 뜻.
// AutoDispose를 설정할 수 있음.
@Riverpod(
  // 살려둬라
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

// [2]
// 기존 family는 값을 하나밖에 못 받기 때문에 아래와 같이 작성해야됨.
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

// final _testFamilyProvider = Provider.family<int, Parameter>(
//   (ref, Parameter) => Parameter.number1 + Parameter.number2,
// );

// 비동기가 아닌 동기로 제어할거니까 (우선은)
// 파라미터를 전달받기위해 일반 함수를 작성하듯이 똑같이 해주면 된다.
@riverpod
int gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

// StateNotifier 생성법
// 1. class 이름 extends _$이름 과 같이 작성하면 끝
// 2. build()를 override로 지정하기 (초기상태 지정) return에 있는 값이 초깃값
// 주의) 코드 생성전에는 아무런 반응도 없을 수 있음 (에러가 있을 수 있음)
// 생긴다고 생각하고 만드는 것
// 코드 생성 후에는 오류가 없어짐.
@riverpod
class GStateNotifier extends _$GStateNotifier {
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}
