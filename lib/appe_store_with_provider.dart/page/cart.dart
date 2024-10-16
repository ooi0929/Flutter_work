import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/provider_cart.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> cartProductList = context.select<ProviderCart, List<Product>>(
      (providerCart) => providerCart.cartProductList,
    );

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
                  onPressed: context.read<ProviderCart>().onProductPressed,
                );
              },
            ),
    );
  }
}
