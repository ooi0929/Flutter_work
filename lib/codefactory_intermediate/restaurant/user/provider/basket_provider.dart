// user_me_provider에서는 유저에 대한 정보만 담기 위해 새롭게 생성

import 'package:collection/collection.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/model/product_model.dart';
import '../model/basket_item_model.dart';
import '../model/patch_basket_body.dart';
import '../repository/user_me_repository.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);

    return BasketProvider(repository: repository);
  },
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  final updateBasketDebounce = Debouncer(
    Duration(seconds: 1),
    // 로직을 살펴보면
    // 업데이트를 할때에 파라미터가 필요가 없기에 null로 지정
    // 상태를 기반으로 업데이트가 진행되기에
    initialValue: null,
    checkEquality: false,
  );

  BasketProvider({required this.repository}) : super([]) {
    updateBasketDebounce.values.listen(
      (event) {
        patchBasket();
      },
    );
  }

  Future<void> addToBasket({
    // id만 받아도 되는데
    // 귀찮으니까 전부 받음.
    required ProductModel product,
  }) async {
    // 지금까지의 로직
    // 요청을 먼저 보내고
    // 응답이 오면
    // 캐시를 업데이트 했다.
    // -> 앱이 느린 것처럼 느껴짐..

    // 만약 에러가 난다 하더라도
    // 에러가 난 것을 인지를 못하면 엄청나네 크리티컬한 상황일까?
    // 에러가 났을 때 업데이트를 해주면?
    // 맨 아래로 내리기 다음 로직을
    // await Future.delayed(Duration(milliseconds: 500));

    // 1) 아직 장바구니에 해당되는 상품이 없다면
    //    장바구니에 상품을 추가한다.
    // 2) 만약에 이미 들어있다면
    //    장바구니에 있는 값에 +1을 한다.

    // null체크를 하기 위해 collection 패키지 불러오기
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    // 1)
    if (exists) {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count + 1,
                  )
                : e,
          )
          .toList();
    } else {
      // 2)
      state = [
        ...state,
        BasketItemModel(product: product, count: 1),
      ];
    }

    // 요청이 성공할 것이란 가정으로 캐시를 먼저 업데이트를 하고 요청을 보내는 것.
    // await Future.delayed(Duration(milliseconds: 500));

    // 같은 코드였지만 속도가 엄청 차이나는 것을 알 수 있음.
    // 그럼 여기서 에러가 발생할까?
    // 에러가 발생할 가능성이 매우 낮고
    // 결제하는 창에서 한번 더 확인을 할 것이기 때문에
    // UI/UX적으로 매우 큰 문제가 아니다.
    // 결과적으로 사용자에게 좋은 UX를 남겨주게 된다.
    // -> Optimistic Response (긍정적 응답)라고 부른다.
    // -> 응답이 성공할 것이라고 가정을 하고 상태를 먼저 업데이트한다.

    // await patchBasket();

    updateBasketDebounce.setValue(null);
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    // true이면
    // count와 관계없이 아예 삭제한다. (강제 삭제)
    bool isDelete = false,
  }) async {
    // 1) 장바구니에 상품이 존재할때
    //    1-1) 상품의 카운트가 1보다 크면 -1한다.
    //    1-2) 상품의 카운트가 1이면 삭제한다.
    //
    // 2) 상품이 존재하지 않을때
    //    즉시 함수를 반환하고 아무것도 하지 않는다.

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (e) => e.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count - 1,
                  )
                : e,
          )
          .toList();
    }

    // await patchBasket();
    updateBasketDebounce.setValue(null);
  }

  Future<void> patchBasket() async {
    await repository.patchBasket(
      body: PatchBasketBody(
        basket: state
            .map(
              (e) => PatchBasketBodyBasket(
                productId: e.product.id,
                count: e.count,
              ),
            )
            .toList(),
      ),
    );
  }
}
