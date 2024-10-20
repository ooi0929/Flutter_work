import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.cartToTotal,
    this.onTap,
  });

  // 현재 선택된 index
  final int currentIndex;

  // 카트에 담긴 상품 개수
  final String cartToTotal;

  // 클릭 이벤트
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        // Store
        const BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Store',
        ),

        // Cart
        BottomNavigationBarItem(
          // 카트에 담긴 상품 개수 Badge
          icon: badges.Badge(
            badgeContent: Text(
              cartToTotal,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            child: Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
      ],
    );
  }
}
