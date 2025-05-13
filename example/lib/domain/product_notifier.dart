import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/product_repository.dart';
import 'models/product.dart';

part 'product_notifier.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  FutureOr<Product> build(String productId) async {
    final productRepository = ref.watch(productRepositoryProvider);
    final product = await productRepository.fetchProduct(productId);
    return product;
  }
}
