import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/riverpod_cart.dart';

class Store extends ConsumerWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];

          return ProductTile(
            product: product,
            isInCart: ref.watch(cartProvider).contains(product),
            onPressed: ref.read(cartProvider.notifier).onProductPressed,
          );
        },
      ),
    );
  }
}
