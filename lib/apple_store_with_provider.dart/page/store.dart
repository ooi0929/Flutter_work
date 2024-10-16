import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/provider_cart.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProviderCart providerCart = context.watch<ProviderCart>();

    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];

          return ProductTile(
            product: product,
            isInCart: providerCart.cartProductList.contains(product),
            onPressed: providerCart.onProductPressed,
          );
        },
      ),
    );
  }
}
