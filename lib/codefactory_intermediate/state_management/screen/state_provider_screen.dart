import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';
import '../riverpod/state_provider.dart';

// riverpod을 사용하려면 StatelessWidget 위치를 ConsumerWidget으로 변경
// StatelessWidget과 99퍼센트 비슷하지만, build()쪽에 WidgetRef ref 파라미터를 추가해주어야 한다.
// 이 ref를 통해 상태관리의 provider에 접근이 가능하다.
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read, listen, watch 세가지가 제일 중요.
    // watch: 특정 프로바이더를 바라보고 있다가 해당 프로바이더가 변경이 된다면 build()를 다시 실행한다.
    // watch vs read
    // read: 이벤트가 발생하여 함수를 실행할 때에는 read
    // watch: build() 안에서 직접적으로 UI에 반영을 할 때에는 watch

    // UI는 상태를 계속 바라보고 있어야 하니까! -> 상태에 따라 UI가 유동적으로 변경되어야 하기 때문에!
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            // 1번. update 이용
            CustomElevatedButton(
              onPressed: () {
                // state - 현재 상태
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('UP'),
            ),
            // 2번. state를 통해 직접적으로 값을 변경
            CustomElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).state =
                    ref.read(numberProvider.notifier).state - 1;
              },
              child: Text('Down'),
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _NextScreen(),
                  ),
                );
              },
              child: Text('Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

// 여기서만 사용할 클래스이니까 _ 붙여서 사용
class _NextScreen extends ConsumerWidget {
  const _NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            CustomElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('UP'),
            ),
          ],
        ),
      ),
    );
  }
}
