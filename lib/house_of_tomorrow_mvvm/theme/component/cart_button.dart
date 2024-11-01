import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/service/cart_service.dart';
import '../../util/route_path.dart';
import 'button/button.dart';
import 'counter_badge.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    int count = context.watch<CartService>().cartItemList.length;
    return CounterBadge(
      label: "$count",
      isShow: count > 0,
      child: Button(
        icon: 'basket',
        type: ButtonType.flat,
        onPressed: () {
          Navigator.pushNamed(context, RoutePath.cart);
        },
      ),
    );
  }
}