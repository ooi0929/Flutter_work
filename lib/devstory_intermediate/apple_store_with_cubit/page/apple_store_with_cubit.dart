import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bottom_bar.dart';
import '../state/badge_cubit.dart';
import '../state/cart_cubit.dart';
import 'cart.dart';
import 'store.dart';

class AppleStoreWithCubit extends StatefulWidget {
  const AppleStoreWithCubit({super.key});

  @override
  State<AppleStoreWithCubit> createState() => _AppleStoreWithCubitState();
}

class _AppleStoreWithCubitState extends State<AppleStoreWithCubit> {
  // 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          // 자동으로 타입 추론이 된다.
          // 의존성에 따라 순서 반드시 지켜주기.
          create: (context) => BadgeCubit(cartCubit: context.read()),
        )
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
        bottomNavigationBar: BlocBuilder<BadgeCubit, int>(
          builder: (context, state) {
            return BottomBar(
              currentIndex: currentIndex,
              cartToTotal: '$state',
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
