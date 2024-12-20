import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/shopping_item_model.dart';

// StateNotifier와 StateNotifierProvider의 상관관계
// 이름을 확인하면 StateNotifier에 Provider만 추가됨.
// StateNotifier는 StateNotifierProvider에 제공이 될 클래스가 상속되는 것이고,
// StateNotifierProvider는 StateNotifier를 상속하는 클래스를 Provider로 만들 수 있는 클래스이다. (Provider로 만들어야 위젯에서 상태관리가 가능하니까)
// <>: 두가지 값 입력
// 1. 어떤 notifier인지
// 2. 해당 notifier가 관리하는 상태 타입
// 반환값: 초기화한 생성자를 반환해주면 된다. (클래스 생성하라고)
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
  (ref) => ShoppingListNotifier(),
);

// [2]
// StateNotifier Provider를 사용하려면
// 1. StateNotifier 상속 (상속을 받기에 StateNotifier의 기능을 가져와 사용 가능)
// 2. <>에 사용할 타입 지정
// 3. 생성자 선언 - 무조건 super에 처음 우리가 상태를 어떻게 정의할 지(관리할 지) 넣어주기. (타입은 반드시 <>에서 정의한 대로 넣어주게 되어있음.)
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  // ShoppingListProvider를 초기화하는 값들 (타입: List<ShoppingItemModel>)
  ShoppingListNotifier()
      : super(
          [
            ShoppingItemModel(
              name: '김치',
              quantity: 3,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '라면',
              quantity: 5,
              hasBought: false,
              isSpicy: true,
            ),
            ShoppingItemModel(
              name: '삼겹살',
              quantity: 10,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '수박',
              quantity: 2,
              hasBought: false,
              isSpicy: false,
            ),
            ShoppingItemModel(
              name: '카스테라',
              quantity: 5,
              hasBought: false,
              isSpicy: false,
            ),
          ],
        );

  void toggleHasBought({required String name}) {
    // StateNotifier<List<ShoppingItemModel>> 에서 자동으로 제공되는 state를 통해 상태를 변경할 수 있다.
    // state를 통해
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy,
              )
            : e)
        .toList();
  }
}
