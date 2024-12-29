import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';
import '../../user/provider/basket_provider.dart';
import '../model/order_model.dart';
import '../model/post_order_body.dart';
import '../repository/order_repository.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>(
  (ref) {
    final repo = ref.watch(orderRepositoryProvider);

    return OrderStateNotifier(ref: ref, repository: repo);
  },
);

class OrderStateNotifier
    extends PaginationProvider<OrderModel, OrderRepository> {
  // reference를 바로 주입
  final Ref ref;

  OrderStateNotifier({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {
    try {
      // uuid는 생성되는 스탠다드 알고리즘이 존재한다.
      // uuid 패키지를 통해 구현이 가능하다.
      // 대부분의 언어에서도 제공하고 있다.
      final uuid = Uuid();

      // v4를 자주 사용할 것이고
      // 랜덤으로 String 타입의 id가 랜덤으로 생성이 된다.
      // ####-####-####-#### (uuid 형태)
      // 한 번 생성이 될 때마다 언제 어느순간에 생성을 해도 절대 겹치지 않는 id값이 생성이 된다.
      final id = uuid.v4();

      final state = ref.read(basketProvider);

      // ignore: unused_local_variable
      final resp = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                    productId: e.product.id, count: e.count),
              )
              .toList(),
          totalPrice: state.fold<int>(
            0,
            (p, n) => p + (n.count * n.product.price),
          ),
          createdAt: DateTime.now().toString(),
        ),
      );

      // 다음 화면으로 이동
      return true;
    } catch (e) {
      // 에러 메시지 보여주기
      return false;
    }
  }
}
