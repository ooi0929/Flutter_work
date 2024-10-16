import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workspace/apple_store_with_riverpod/state/riverpod_badge.dart';

import '../common/bottom_bar.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithRiverpod extends StatefulWidget {
  const AppleStoreWithRiverpod({super.key});

  @override
  State<AppleStoreWithRiverpod> createState() => _AppleStoreWithRiverpodState();
}

class _AppleStoreWithRiverpodState extends State<AppleStoreWithRiverpod> {
  // 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            // Store
            Store(),

            // Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) => BottomBar(
            currentIndex: currentIndex,
            cartToTotal: '${ref.watch(badgeProvider)}',
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}
