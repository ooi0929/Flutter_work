import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';
import '../riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 우리가 watch할 프로바이더는 gState가 아님 -> gState는 함수를 정의한 것뿐.
    // 생성된 파일에서 gState+Provider를 가져다 쓰면됨.

    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('State1: $state1'),
          state2.when(
            data: (data) => Text(
              'State2: $data',
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
          state3.when(
            data: (data) => Text(
              'State2: $data',
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
          Text('State4: $state4'),
          // [4]
          // Consumer는 부분적으로만 build를 다시하고 싶을 때, 사용 (최적화)
          Consumer(
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);

              return Row(
                children: [
                  Text('State5: $state5'),
                  if (child != null) child,
                ],
              );
            },
            // child는 consumer위젯에 추가적으로 제공할 수 있는 위젯이다.
            // child속성에 작성된 내용은 builder 속성내에 있는 child 파라미터에 그대로 제공이 된다.
            child: Text('hello'),
          ),
          Row(
            children: [
              CustomElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: Text('Increment'),
              ),
              CustomElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: Text('Decrement'),
              ),
            ],
          ),
          // [3]
          // invalidate()
          // 유효하지 않게 하다.
          // state를 더이상 유효하지 않게 하여 초기상태로 되돌리는 역할
          CustomElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('Invalidate'),
          ),
        ],
      ),
    );
  }
}
