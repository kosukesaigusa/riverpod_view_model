import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required String description,
    required String imageUrl,
  }) = _Product;

  // If you need JSON serialization
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
