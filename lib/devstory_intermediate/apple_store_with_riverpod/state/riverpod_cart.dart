import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/product.dart';

final cartProvider = NotifierProvider<RiverpodCart, List<Product>>(
  () => RiverpodCart(),
);

class RiverpodCart extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [];
  }

  // 상품 출력
  void onProductPressed(Product product) {
    if (state.contains(product)) {
      // state.remove(product);
      state = state.where((e) => e != product).toList();
    } else {
      // state.add(product);
      state = [...state, product];
    }
  }
}
