import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_detail_view_model.dart';

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({required this.productId, super.key});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelState = ref.watch(productDetailViewModelProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModelState.value?.product?.name ?? 'Product Details',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Badge(
                label: Text('${viewModelState.value?.totalCartItemCount ?? 0}'),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(productDetailViewModelProvider(productId));
        },
        child: viewModelState.when(
          data: (state) {
            final product = state.product;
            if (product == null) {
              return const Center(child: Text('Failed to load product data.'));
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.imageUrl.isNotEmpty)
                    Center(
                      child: Image.network(
                        product.imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¥${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      icon: state.isProductInCart
                          ? const Icon(Icons.check_circle)
                          : const Icon(
                              Icons.add_shopping_cart,
                            ),
                      label: Text(
                        state.isProductInCart ? 'Added to Cart' : 'Add to Cart',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isProductInCart
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      onPressed: state.isProductInCart
                          ? null
                          : () {
                              ref
                                  .read(
                                    productDetailViewModelProvider(productId)
                                        .notifier,
                                  )
                                  .addToCart();
                            },
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (error, stackTrace) {
            print(
              'Error in ProductDetailPage: $error\n$stackTrace',
            );
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'An error occurred: $error',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(
                          productDetailViewModelProvider(productId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
