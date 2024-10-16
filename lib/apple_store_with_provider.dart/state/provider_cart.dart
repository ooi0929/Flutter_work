import 'package:flutter/material.dart';

import '../common/product.dart';

class ProviderCart extends ChangeNotifier {
  // 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  // 상품 클릭
  void onProductPressed(Product product) {
    if (cartProductList.contains(product)) {
      // cartProductList.remove(product);
      cartProductList = cartProductList.where((e) => e != product).toList();
    } else {
      // cartProductList.add(product);
      cartProductList = [...cartProductList, product];
    }

    notifyListeners(); // 변경 사항 알림
  }
}
