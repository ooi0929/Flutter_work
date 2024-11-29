import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/riverpod_cart.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> cartProductList = ref.watch(cartProvider);

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
                  onPressed: ref.read(cartProvider.notifier).onProductPressed,
                );
              },
            ),
    );
  }
}
