import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc.dart';

@immutable
abstract class BadgeEvent {
  const BadgeEvent();
}

class OnCartTotalChange extends BadgeEvent {
  final int total;

  const OnCartTotalChange(this.total);
}

class BadgeBloc extends Bloc<BadgeEvent, int> {
  BadgeBloc({
    required CartBloc cartBloc,
  }) : super(0) {
    cartBlocSubs = cartBloc.stream.listen((cartProductList) {
      add(OnCartTotalChange(cartProductList.length));
    });
  }

  late final StreamSubscription cartBlocSubs;

  @override
  Future<void> close() {
    cartBlocSubs.cancel();
    return super.close();
  }
}
