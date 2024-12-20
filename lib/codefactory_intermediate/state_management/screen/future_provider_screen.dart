import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';
import '../riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureProvider의 상태는 AsyncValue 상태로 읽어오게 된다.
    // AsyncValue는 항상 when()와 함께 쓰인다.
    final state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'FutureProviderScreen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 여태까지는 Provider가 모두 동기형태였다.
          // 하지만 이제는 Provider를 비동기로 처리한다.

          // map과 when을 중점
          // data: 로딩이 끝난 후 데이터가 존재할 때
          // error: 에러가 발생할 때
          // loading: 로딩 중일 때

          // FutureProvider는 FutureBuilder처럼 뒤로갔다가 다시 돌아올 때 데이터를 기억하고 있다. (캐싱)
          state.when(
            data: (data) => Text(
              data.toString(),
              textAlign: TextAlign.center,
            ),
            error: (error, stackTrace) => Text(
              error.toString(),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
