import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/cart_item.dart';
import 'models/cart_state.dart';
import 'models/product.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  CartState build() => const CartState();

  void addItem(Product product) {
    final currentState = state;
    final items = List<CartItem>.from(currentState.items);

    final existingItemIndex =
        items.indexWhere((item) => item.productId == product.id);

    if (existingItemIndex != -1) {
      final existingItem = items[existingItemIndex];
      items[existingItemIndex] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      items.add(CartItem(productId: product.id, quantity: 1));
    }

    state = currentState.copyWith(items: items);
  }
}
