import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';
import '../riverpod/family_modifier_provider.dart';

class FamilyModifierScreen extends ConsumerWidget {
  const FamilyModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // familyModifer를 사용하게 되면은 ()를 만들고 안에 생성을 하나 해줘야 한다. (데이터 값에 해당되는 파라미터를 넣어줘야 하낟.)
    final state = ref.watch(familyModifierProvider(3));

    return DefaultLayout(
      title: 'FamilyModifierScreen',
      body: Center(
        child: state.when(
          data: (data) => Text(
            data.toString(),
          ),
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
