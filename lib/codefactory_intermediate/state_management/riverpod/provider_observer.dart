import 'package:flutter_riverpod/flutter_riverpod.dart';

// [10]
// Provider Observer를 사용하려면 해당 클래스를 상속받은 클래스를 작성해야 사용이 가능하다.
class Logger extends ProviderObserver {
  // 세 가지 정도 오바라이드 가능한 기능이 있다.

  // did - do의 과거형 했다.
  // 프로바이더를 업데이트 했다.

  // ProviderScope 하위에 있는 모든 Provider들이 업데이트가 됐을 때,
  // observers에 등록된 Oberser 클래스의 didUpdateProvider가 불러온다.

  // provider: 어떤 프로바이더가 업데이트 됐는지
  // priviousValue: 이전 값
  // newValue: 새로운 값
  // container: 플러터를 사용할 때에는 신경 안써도됨
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // super기능은 불러도 상관없지만 아무런 기능도 없기 때문에 안불러도 상관없다.
    // super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  // 프로바이더를 추가하면 불리는 함수
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    // super.didAddProvider(provider, value, container);
  }

  // 프로바이더가 삭제되면 불리는 함수
  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    // super.didDisposeProvider(provider, container);
  }
}
