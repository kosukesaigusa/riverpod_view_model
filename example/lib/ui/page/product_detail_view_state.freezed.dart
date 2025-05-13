// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductDetailViewState {
  Product? get product => throw _privateConstructorUsedError;
  bool get isLoadingProduct => throw _privateConstructorUsedError;
  Object? get productError => throw _privateConstructorUsedError;
  bool get isProductInCart => throw _privateConstructorUsedError;
  int get totalCartItemCount => throw _privateConstructorUsedError;

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDetailViewStateCopyWith<ProductDetailViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailViewStateCopyWith<$Res> {
  factory $ProductDetailViewStateCopyWith(ProductDetailViewState value,
          $Res Function(ProductDetailViewState) then) =
      _$ProductDetailViewStateCopyWithImpl<$Res, ProductDetailViewState>;
  @useResult
  $Res call(
      {Product? product,
      bool isLoadingProduct,
      Object? productError,
      bool isProductInCart,
      int totalCartItemCount});

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductDetailViewStateCopyWithImpl<$Res,
        $Val extends ProductDetailViewState>
    implements $ProductDetailViewStateCopyWith<$Res> {
  _$ProductDetailViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? isLoadingProduct = null,
    Object? productError = freezed,
    Object? isProductInCart = null,
    Object? totalCartItemCount = null,
  }) {
    return _then(_value.copyWith(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      isLoadingProduct: null == isLoadingProduct
          ? _value.isLoadingProduct
          : isLoadingProduct // ignore: cast_nullable_to_non_nullable
              as bool,
      productError:
          freezed == productError ? _value.productError : productError,
      isProductInCart: null == isProductInCart
          ? _value.isProductInCart
          : isProductInCart // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCartItemCount: null == totalCartItemCount
          ? _value.totalCartItemCount
          : totalCartItemCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductDetailViewStateImplCopyWith<$Res>
    implements $ProductDetailViewStateCopyWith<$Res> {
  factory _$$ProductDetailViewStateImplCopyWith(
          _$ProductDetailViewStateImpl value,
          $Res Function(_$ProductDetailViewStateImpl) then) =
      __$$ProductDetailViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Product? product,
      bool isLoadingProduct,
      Object? productError,
      bool isProductInCart,
      int totalCartItemCount});

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ProductDetailViewStateImplCopyWithImpl<$Res>
    extends _$ProductDetailViewStateCopyWithImpl<$Res,
        _$ProductDetailViewStateImpl>
    implements _$$ProductDetailViewStateImplCopyWith<$Res> {
  __$$ProductDetailViewStateImplCopyWithImpl(
      _$ProductDetailViewStateImpl _value,
      $Res Function(_$ProductDetailViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? isLoadingProduct = null,
    Object? productError = freezed,
    Object? isProductInCart = null,
    Object? totalCartItemCount = null,
  }) {
    return _then(_$ProductDetailViewStateImpl(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      isLoadingProduct: null == isLoadingProduct
          ? _value.isLoadingProduct
          : isLoadingProduct // ignore: cast_nullable_to_non_nullable
              as bool,
      productError:
          freezed == productError ? _value.productError : productError,
      isProductInCart: null == isProductInCart
          ? _value.isProductInCart
          : isProductInCart // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCartItemCount: null == totalCartItemCount
          ? _value.totalCartItemCount
          : totalCartItemCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProductDetailViewStateImpl implements _ProductDetailViewState {
  const _$ProductDetailViewStateImpl(
      {this.product,
      this.isLoadingProduct = false,
      this.productError,
      this.isProductInCart = false,
      this.totalCartItemCount = 0});

  @override
  final Product? product;
  @override
  @JsonKey()
  final bool isLoadingProduct;
  @override
  final Object? productError;
  @override
  @JsonKey()
  final bool isProductInCart;
  @override
  @JsonKey()
  final int totalCartItemCount;

  @override
  String toString() {
    return 'ProductDetailViewState(product: $product, isLoadingProduct: $isLoadingProduct, productError: $productError, isProductInCart: $isProductInCart, totalCartItemCount: $totalCartItemCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailViewStateImpl &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.isLoadingProduct, isLoadingProduct) ||
                other.isLoadingProduct == isLoadingProduct) &&
            const DeepCollectionEquality()
                .equals(other.productError, productError) &&
            (identical(other.isProductInCart, isProductInCart) ||
                other.isProductInCart == isProductInCart) &&
            (identical(other.totalCartItemCount, totalCartItemCount) ||
                other.totalCartItemCount == totalCartItemCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      product,
      isLoadingProduct,
      const DeepCollectionEquality().hash(productError),
      isProductInCart,
      totalCartItemCount);

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailViewStateImplCopyWith<_$ProductDetailViewStateImpl>
      get copyWith => __$$ProductDetailViewStateImplCopyWithImpl<
          _$ProductDetailViewStateImpl>(this, _$identity);
}

abstract class _ProductDetailViewState implements ProductDetailViewState {
  const factory _ProductDetailViewState(
      {final Product? product,
      final bool isLoadingProduct,
      final Object? productError,
      final bool isProductInCart,
      final int totalCartItemCount}) = _$ProductDetailViewStateImpl;

  @override
  Product? get product;
  @override
  bool get isLoadingProduct;
  @override
  Object? get productError;
  @override
  bool get isProductInCart;
  @override
  int get totalCartItemCount;

  /// Create a copy of ProductDetailViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDetailViewStateImplCopyWith<_$ProductDetailViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
