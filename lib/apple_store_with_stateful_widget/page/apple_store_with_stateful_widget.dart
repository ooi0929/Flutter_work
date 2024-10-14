import 'package:flutter/material.dart';

import '../common/bottom_bar.dart';
import '../common/product.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithStatefulWidget extends StatefulWidget {
  const AppleStoreWithStatefulWidget({super.key});

  @override
  State<AppleStoreWithStatefulWidget> createState() =>
      _AppleStoreWithStatefulWidgetState();
}

class _AppleStoreWithStatefulWidgetState
    extends State<AppleStoreWithStatefulWidget> {
  // 현재 선택된 index
  int currentIndex = 0;

  // 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  // 상품 클릭
  void onProductPressed(Product product) {
    setState(() {
      if (cartProductList.contains(product)) {
        // 카트에 상품에 존재한다면
        cartProductList.remove(product);
      } else {
        // 카트에 상품이 존재하지 않는다면
        cartProductList.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          // Store
          Store(
            cartProductList: cartProductList,
            onPressed: onProductPressed,
          ),

          // Cart
          Cart(
            cartProductList: cartProductList,
            onPressed: onProductPressed,
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        cartToTotal: '${cartProductList.length}',
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
