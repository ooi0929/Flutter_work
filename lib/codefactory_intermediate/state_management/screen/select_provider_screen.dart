import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';
import '../riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch는 build()를 다시 실행하기에 필요없는 값이 바뀔때에도 다시 build()를 렌더링한다.
    // 따라서 select를 이용하여 필요한 값이 바뀔때에만 다시 build()가 렌더링될 수 있도록 할 수 있다.
    // value: 현재 selectProvider의 상태를 뜻함
    // value를 isSpicy로 둔다면 state는 이제 isSpicy만을 바라보고있다.
    // select한 값만 바뀔 때만 watch()가 적용된다.
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));

    // 이러한 select를 listen에도 적용 가능
    // hasBought값이 바뀔때에만 listen()가 적용된다.
    ref.listen(
      selectProvider.select((value) => value.hasBought),
      (previous, next) {
        print('next: $next');
      },
    );

    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 에러
            // Text(state.name),
            // Text(state.isSpicy.toString()),
            // Text(state.hasBought.toString()),
            Text(state.toString()),
            CustomElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text('Spicy Toggle'),
            ),
            CustomElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text('HasBought Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
