import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';
import '../model/shopping_item_model.dart';
import '../riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // notifier를 List타입으로 선언을 하였고
    // super에 List 형식으로 값을 초기화 하였기 때문에 toList()를 사용한다면 해당 super에 있는 값들을 그대로 가져올 수 있다.
    // state.toList();

    // watch를 했을 때 state가 바로 주입되는 것을 알 수 있다.
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);

    return DefaultLayout(
      title: 'StateNotifierProvider',
      body: ListView(
        children: state
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: e.hasBought,
                onChanged: (value) {
                  // read(프로바이더.notifier)
                  // 프로바이더.notifier를 하면 해당 클래스를 그대로 가져온다.

                  // 여기에서는 shoppingListProvide의 shoppingListNotifier클래스를 그대로 가져와서
                  // 해당 클래스의 메서드를 사용하게 되는 것.
                  ref
                      .read(shoppingListProvider.notifier)
                      .toggleHasBought(name: e.name);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
