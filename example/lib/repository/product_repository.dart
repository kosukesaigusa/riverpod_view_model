import 'package:flutter_riverpod/flutter_riverpod.dart'; // For Provider
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/models/product.dart';

part 'product_repository.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) => const ProductRepository();

class ProductRepository {
  const ProductRepository();

  Future<Product> fetchProduct(String productId) async {
    await _simulateDelay();
    if (productId == 'error') {
      throw Exception(
        'Failed to fetch product data (ID: $productId)',
      );
    }
    final product = _dummyProducts[productId];
    if (product != null) {
      return product;
    } else {
      throw Exception('Product not found (ID: $productId)');
    }
  }

  Future<void> _simulateDelay() =>
      Future.delayed(const Duration(milliseconds: 800));

  static const _dummyProducts = <String, Product>{
    'p1': Product(
      id: 'p1',
      name: 'Awesome Gadget',
      price: 99.99,
      description: 'This is a truly awesome gadget that will enrich your life.',
      imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Gadget',
    ),
    'p2': Product(
      id: 'p2',
      name: 'Regular Widget',
      price: 19.99,
      description: 'This is just a regular widget. Good for everyday tasks.',
      imageUrl: 'https://via.placeholder.com/150/00FF00/FFFFFF?text=Widget',
    ),
    'error': Product(
      id: 'error',
      name: '',
      price: 0,
      description: '',
      imageUrl: '',
    ), // To simulate error
  };
}
