// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productDetailViewModelHash() =>
    r'ce4529e91598e2fe1a74eb957f088e4b5aa5940f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<ProductDetailViewState> {
  late final String productId;

  FutureOr<ProductDetailViewState> build(
    String productId,
  );
}

/// See also [ProductDetailViewModel].
@ProviderFor(ProductDetailViewModel)
const productDetailViewModelProvider = ProductDetailViewModelFamily();

/// See also [ProductDetailViewModel].
class ProductDetailViewModelFamily
    extends Family<AsyncValue<ProductDetailViewState>> {
  /// See also [ProductDetailViewModel].
  const ProductDetailViewModelFamily();

  /// See also [ProductDetailViewModel].
  ProductDetailViewModelProvider call(
    String productId,
  ) {
    return ProductDetailViewModelProvider(
      productId,
    );
  }

  @override
  ProductDetailViewModelProvider getProviderOverride(
    covariant ProductDetailViewModelProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailViewModelProvider';
}

/// See also [ProductDetailViewModel].
class ProductDetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductDetailViewModel,
        ProductDetailViewState> {
  /// See also [ProductDetailViewModel].
  ProductDetailViewModelProvider(
    String productId,
  ) : this._internal(
          () => ProductDetailViewModel()..productId = productId,
          from: productDetailViewModelProvider,
          name: r'productDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDetailViewModelHash,
          dependencies: ProductDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              ProductDetailViewModelFamily._allTransitiveDependencies,
          productId: productId,
        );

  ProductDetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  FutureOr<ProductDetailViewState> runNotifierBuild(
    covariant ProductDetailViewModel notifier,
  ) {
    return notifier.build(
      productId,
    );
  }

  @override
  Override overrideWith(ProductDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailViewModelProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetailViewModel,
      ProductDetailViewState> createElement() {
    return _ProductDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailViewModelProvider &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<ProductDetailViewState> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductDetailViewModel,
        ProductDetailViewState> with ProductDetailViewModelRef {
  _ProductDetailViewModelProviderElement(super.provider);

  @override
  String get productId => (origin as ProductDetailViewModelProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
