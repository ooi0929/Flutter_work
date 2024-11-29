import 'package:flutter/material.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/inherited_cart.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 부모 위젯트이에서 InheritedCart를 등록해두면
    // 부모 위젯을 거치지 않고 바로 InheritedCart에 접근 가능
    // InheritedCart inheritedCart =
    // context.dependOnInheritedWidgetOfExactType<InheritedCart>()!;
    // final List<Product> cartProductList = inheritedCart.cartProductList;

    // static 메서드인 of()를 사용해서 손쉽게 호출
    // final List<Product> cartProductList =
    //     InheritedCart.of(context).cartProductList;

    // 제네릭을 활용한 read<>로 더 손쉽게 호출
    InheritedCart inheritedCart = context.read<InheritedCart>();

    final List<Product> cartProductList = inheritedCart.cartProductList;

    return Scaffold(
      body: cartProductList.isEmpty

          // Empty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            )

          // Not Empty
          : ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                Product product = cartProductList[index];
                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: inheritedCart.onProductPressed,
                );
              },
            ),
    );
  }
}
