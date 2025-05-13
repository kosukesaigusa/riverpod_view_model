import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/cart_notifier.dart';
import '../../domain/product_notifier.dart';
import 'product_detail_view_state.dart';

part 'product_detail_view_model.g.dart';

@riverpod
class ProductDetailViewModel extends _$ProductDetailViewModel {
  @override
  FutureOr<ProductDetailViewState> build(String productId) async {
    final productAsync = ref.watch(productNotifierProvider(productId));
    final cartState = ref.watch(cartNotifierProvider);
    final totalCartItemCount =
        cartState.items.fold<int>(0, (sum, item) => sum + item.quantity);

    return productAsync.when(
      data: (product) {
        final isProductInCart =
            cartState.items.any((item) => item.productId == product.id);
        return ProductDetailViewState(
          product: product,
          isProductInCart: isProductInCart,
          totalCartItemCount: totalCartItemCount,
        );
      },
      loading: () {
        return ProductDetailViewState(
          isLoadingProduct: true,
          totalCartItemCount: totalCartItemCount,
        );
      },
      error: (error, stackTrace) {
        return ProductDetailViewState(
          productError: error,
          totalCartItemCount: totalCartItemCount,
        );
      },
    );
  }

  Future<void> addToCart() async {
    final product = state.value?.product;
    if (product != null) {
      ref.read(cartNotifierProvider.notifier).addItem(product);
    } else {
      print('Cannot add to cart: Product not loaded.');
    }
  }
}
