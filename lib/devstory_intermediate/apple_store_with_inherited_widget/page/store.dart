import 'package:flutter/material.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/inherited_cart.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    InheritedCart inheritedCart = context.read<InheritedCart>();

    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: inheritedCart.cartProductList.contains(product),
            onPressed: inheritedCart.onProductPressed,
          );
        },
      ),
    );
  }
}
