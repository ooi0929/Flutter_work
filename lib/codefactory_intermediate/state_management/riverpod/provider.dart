import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/shopping_item_model.dart';
import 'state_notifier_provider.dart';

// [9]
// ref를 가져다써도 기존에 썻던 모든 메서드들의 기능을 쓸 수 있다.

// ref를 통해 프로바이더 내에 메서드를 사용하게되면 read는 거의 안 쓴다.
// 프로바이더 내에 메서드를 사용하게 되면 watch()를 꼭 쓴다.

// 이유는 watch()하고 있는 프로바이더가 변경이 되면 최상위에 있는 프로바이더도 변경이 되어야하니까

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final filterState = ref.watch(filterProvider);
  final shoppingListState = ref.watch(shoppingListProvider);

  if (filterState == FilterState.all) {
    return shoppingListState;
  }

  return shoppingListState
      .where((e) => filterState == FilterState.spicy ? e.isSpicy : !e.isSpicy)
      .toList();
});

enum FilterState {
  // 안매움
  notSpicy,
  // 매움
  spicy,
  // 전부
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
