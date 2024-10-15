import 'package:flutter/material.dart';
import 'package:flutter_workspace/apple_store_with_inherited_widget/state/inherited_cart.dart';

import '../common/bottom_bar.dart';
import '../common/product.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithInheritedWidget extends StatefulWidget {
  const AppleStoreWithInheritedWidget({super.key});

  @override
  State<AppleStoreWithInheritedWidget> createState() =>
      _AppleStoreWithInheritedWidgetState();
}

class _AppleStoreWithInheritedWidgetState
    extends State<AppleStoreWithInheritedWidget> {
  // 현재 선택된 index
  int currentIndex = 0;

  // 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  // 상품 클릭
  // 불변 객체로 참조 주소를 나눠줘야함.
  void onProductPressed(Product product) {
    setState(() {
      if (cartProductList.contains(product)) {
        // cartProductList.remove(product);
        cartProductList = cartProductList.where((e) => e != product).toList();
      } else {
        // cartProductList.add(product);
        cartProductList = [...cartProductList, product];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 여기서는 null 값으로 오류
    // InheritedCart가 생성되기 전의 BuildContext 값을 사용하였기 때문
    // final inheritedCart = context.read<InheritedCart>();

    // 자식 위젯의 생성자로 넘기지 않고
    // InheritedCart 위젯으로 전달
    return InheritedCart(
      cartProductList: cartProductList,
      onProductPressed: onProductPressed,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            // Store
            Store(),

            // Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            // Builder() 위젯을 통해
            // InheritedCart가 생성된 이후의 context의 값을 가져와 사용하자
            final inheritedCart = context.read<InheritedCart>();
            return BottomBar(
              currentIndex: currentIndex,
              cartToTotal: '${inheritedCart.cartProductList.length}',
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          },
        ),
      ),
    );
  }
}
