import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';
import '../riverpod/auto_dispose_modifier_provider.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 자동으로 값을 삭제하기 때문에 (이름 그대로)
    // 캐싱 기능이 없다.
    // 늘 새로운 값을 반환받아서 가져온다.

    // 필요없을 때 메모리에서 삭제하고 
    // 필요할 때에만 메모리에 저장한다.
    final state = ref.watch(autoDisposeModifierProvider);

    return DefaultLayout(
      title: 'AutoDisposeModifierScreen',
      body: Center(
        child: state.when(
          data: (data) => Text(data.toString()),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
