import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'async_value_group.dart';

sealed class AsyncDependency<T> {}

class AsyncValueDependency<T> extends AsyncDependency<T> {
  AsyncValueDependency(this.asyncValue);

  final AsyncValue<T> asyncValue;
}

class FutureDependency<T> extends AsyncDependency<T> {
  FutureDependency(this.future);

  final Future<T> Function() future;
}

// class Group2<T1, T2> {
//   const Group2(
//     this._ref, {
//     required this.dependencies,
//   });

//   final Ref _ref;

//   final (Dependency<T1> t1, Dependency<T2> t2) dependencies;

//   Future<void> watch() async {
//     final dependency1 = dependencies.$1;
//     final dependency2 = dependencies.$2;

//     switch (dependency1) {
//       case ProviderDependency(:final provider):
//         _ref.watch(provider);
//       case FutureDependency(:final futureFactory):
//         await futureFactory(_ref);
//     }
//   }

//   void invalidateAll() {
//     final dependency1 = dependencies.$1;
//     final dependency2 = dependencies.$2;

//     switch (dependency1) {
//       case ProviderDependency(:final provider):
//         _ref.invalidate(provider);
//       case FutureDependency(:final futureFactory):
//         futureFactory(_ref);
//     }
//   }
// }

// ignore: strict_raw_type
extension AsyncDependencyGroup on AsyncValue {
  static AsyncValue<(T1, T2)> group2<T1, T2>(
    Ref ref,
    AsyncDependency<T1> t1,
    AsyncDependency<T2> t2,
  ) {
    // if (t1 is AsyncValueDependency<T1> && t2 is AsyncValueDependency<T2>) {
    //   final asyncValue1 = t1.asyncValue;
    //   final asyncValue2 = t2.asyncValue;
    //   return AsyncValueGroup.group2(asyncValue1, asyncValue2);
    // } else {
    //   throw UnimplementedError();
    // }
    switch ((t1, t2)) {
      case (
          AsyncValueDependency<T1>(asyncValue: final asyncValue1),
          AsyncValueDependency<T2>(asyncValue: final asyncValue2)
        ):
        return AsyncValueGroup.group2(asyncValue1, asyncValue2);
      case (
          FutureDependency(future: final future1),
          FutureDependency(future: final future2)
        ):
        throw UnimplementedError();
      // //
      // final futureProvider1 = FutureProvider<T1>(futureFactory1);
      // final asyncValue1 = ref.watch(futureProvider1);

      // final futureProvider2 = FutureProvider<T2>(futureFactory2);
      // final asyncValue2 = ref.watch(futureProvider2);
      // return AsyncValueGroup.group2(asyncValue1, asyncValue2);
      // final futures = (future1, future2);
      // final result = await Future.wait(futures);
      // return AsyncValueGroup.group2(result.$1, result.$2);
      default:
        throw UnimplementedError();
    }
  }
}
