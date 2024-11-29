import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_cubit.dart';

class BadgeCubit extends Cubit<int> {
  BadgeCubit({
    required CartCubit cartCubit,
  }) : super(0) {
    cartCubitSubs = cartCubit.stream
        .listen((cartProductList) => emit(cartProductList.length));
  }

  // Stream 생성
  late final StreamSubscription cartCubitSubs;

  // Stream 삭제
  @override
  Future<void> close() {
    cartCubitSubs.cancel();
    return super.close();
  }
}
