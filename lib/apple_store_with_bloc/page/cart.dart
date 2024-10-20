import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/product.dart';
import '../common/product_tile.dart';
import '../state/cart_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> cartProductList = context.watch<CartBloc>().state;

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
                  onPressed: (product) =>
                      context.read<CartBloc>().add(OnProductPressed(product)),
                );
              },
            ),
    );
  }
}
