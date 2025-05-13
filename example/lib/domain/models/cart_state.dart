import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> items,
  }) = _CartState;
}
