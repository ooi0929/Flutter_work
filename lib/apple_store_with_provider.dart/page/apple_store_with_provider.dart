import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/bottom_bar.dart';
import '../state/provider_badge.dart';
import '../state/provider_cart.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithProvider extends StatefulWidget {
  const AppleStoreWithProvider({super.key});

  @override
  State<AppleStoreWithProvider> createState() => _AppleStoreWithProviderState();
}

class _AppleStoreWithProviderState extends State<AppleStoreWithProvider> {
  /// 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderCart(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderBadge(
            providerCart: context.read(),
          ),
        )
      ],
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            /// Store
            Store(),

            /// Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Selector<ProviderBadge, int>(
          selector: (context, providerBadge) => providerBadge.counter,
          builder: (context, counter, child) => BottomBar(
            currentIndex: currentIndex,
            cartToTotal: '$counter',
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}
