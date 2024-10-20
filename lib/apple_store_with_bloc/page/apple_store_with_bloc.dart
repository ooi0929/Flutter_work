import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bottom_bar.dart';
import '../state/badge_bloc.dart';
import '../state/cart_bloc.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithBloc extends StatefulWidget {
  const AppleStoreWithBloc({super.key});

  @override
  State<AppleStoreWithBloc> createState() => _AppleStoreWithBlocState();
}

class _AppleStoreWithBlocState extends State<AppleStoreWithBloc> {
  // 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => BadgeBloc(cartBloc: context.read()),
        ),
      ],
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
        bottomNavigationBar: BlocBuilder<BadgeBloc, int>(
          builder: (context, total) {
            return BottomBar(
              currentIndex: currentIndex,
              cartToTotal: '$total',
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          },
        ),
      ),
    );
  }
}
