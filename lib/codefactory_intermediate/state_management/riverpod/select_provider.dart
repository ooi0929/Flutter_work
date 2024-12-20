import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/shopping_item_model.dart';

// [8]
final selectProvider = StateNotifierProvider<SelectNotifier, ShoppingItemModel>(
    (ref) => SelectNotifier());

class SelectNotifier extends StateNotifier<ShoppingItemModel> {
  SelectNotifier()
      : super(
          ShoppingItemModel(
            name: '김치',
            quantity: 3,
            hasBought: false,
            isSpicy: true,
          ),
        );

  // 기존 방식은 너무 반복적인 작업..
  // 일일이 item을 계속 생성하고 값을 수동적으로 넣어줬어야 함..
  toggleHasBought() {
    state = state.copyWith(hasBought: !state.hasBought);
  }

  toggleIsSpicy() {
    state = state.copyWith(isSpicy: !state.isSpicy);
  }
}
