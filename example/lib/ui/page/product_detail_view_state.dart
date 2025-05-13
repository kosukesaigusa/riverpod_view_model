import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/product.dart';

part 'product_detail_view_state.freezed.dart';

@freezed
class ProductDetailViewState with _$ProductDetailViewState {
  const factory ProductDetailViewState({
    Product? product,
    @Default(false) bool isLoadingProduct,
    Object? productError,
    @Default(false) bool isProductInCart,
    @Default(0) int totalCartItemCount,
  }) = _ProductDetailViewState;
}
