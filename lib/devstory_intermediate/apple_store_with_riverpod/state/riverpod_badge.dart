import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/product.dart';
import 'riverpod_cart.dart';

// () => RiverpodBadge()를 Riverpod.new로 단축
final badgeProvider = NotifierProvider<RiverpodBadge, int>(RiverpodBadge.new);

class RiverpodBadge extends Notifier<int> {
  @override
  int build() {
    List<Product> cartProductList = ref.watch(cartProvider);
    return cartProductList.length;
  }
}
