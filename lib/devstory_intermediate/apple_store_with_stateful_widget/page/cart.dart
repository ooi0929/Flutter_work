import 'package:flutter/material.dart';

import '../common/product.dart';
import '../common/product_tile.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.cartProductList,
    required this.onPressed,
  });

  // 카트에 담긴 상품 목록
  final List<Product> cartProductList;

  // 클릭 이벤트
  final void Function(Product product) onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cartProductList.isEmpty
          // Empty
          ? const Center(
              child: Text(
                'Empty',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                ),
              ),
            )
          // Not Empty
          : ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                // index에 해당하는 상품 불러오기.
                Product product = cartProductList[index];

                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: onPressed,
                );
              },
            ),
    );
  }
}
