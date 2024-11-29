import 'package:flutter/material.dart';

import '../common/product.dart';

class InheritedCart extends InheritedWidget {
  const InheritedCart({
    super.key,
    required super.child,
    required this.cartProductList,
    required this.onProductPressed,
  });

  // 카트에 담긴 상품 목록
  final List<Product> cartProductList;

  // 상품 클릭
  final void Function(Product product) onProductPressed;

  @override
  bool updateShouldNotify(InheritedCart oldWidget) {
    print('${cartProductList.length} / ${oldWidget.cartProductList.length}');
    return cartProductList != oldWidget.cartProductList;
  }

  // InheritedCart.of(context)로 손쉽게 접근
  static InheritedCart of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCart>()!;
  }
}

// InheritedWidget을 상속받은 클래스만 입력 가능
extension BuildContextExt on BuildContext {
  // context.read<InheritedCart>()로 손쉽게 접근
  T read<T extends InheritedWidget>() {
    return dependOnInheritedWidgetOfExactType<T>()!;
  }
}
