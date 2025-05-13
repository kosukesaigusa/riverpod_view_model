// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // --- Dependency Types ---
// sealed class Dependency<T> {}

// class AsyncValueDependency<T> extends Dependency<T> {
//   AsyncValueDependency(this.provider);
//   final ProviderListenable<AsyncValue<T>> provider;
// }

// class FutureDependency<T> extends Dependency<T> {
//   FutureDependency(this.futureFactory);
//   final Future<T> Function(Ref ref) futureFactory;
// }

// // --- Base ViewModel Class ---
// abstract class GroupedViewModelBase<T extends Object> extends AsyncNotifier<T> {
//   /// Subclasses must implement this to define their dependencies.
//   List<Dependency> dependencies(Ref ref);

//   /// Subclasses must implement this to map the fetched results to the final state type T.
//   /// The order of items in `results` matches the order in `dependencies`.
//   T mapData(List<dynamic> results);

//   @override
//   FutureOr<T> build() async {
//     final deps = dependencies(ref);
//     final futuresToAwait = <Future>[];
//     final asyncValueProviders = <ProviderListenable<AsyncValue<dynamic>>>[];

//     // Separate dependencies and prepare futures
//     for (final dep in deps) {
//       if (dep is AsyncValueDependency) {
//         // Watch the provider and add its future to the list to await readiness
//         final provider = dep.provider;
//         futuresToAwait
//             .add(ref.watch(provider.future)); // Wait for it to have data/error
//         asyncValueProviders.add(provider);
//       } else if (dep is FutureDependency) {
//         // Execute the future factory and add the future to the list
//         futuresToAwait.add(dep.futureFactory(ref));
//       }
//     }

//     try {
//       // Wait for all futures (from FutureDependency and AsyncValue.future) to complete
//       final allRawResults = await Future.wait(futuresToAwait);

//       // Now, re-read the current state of AsyncValue providers (they should have values now)
//       // and combine with future results in the correct order.
//       final finalResults = <dynamic>[];
//       var futureIdx = 0; // Index for results from Future.wait
//       final asyncValueIdxOffset = deps
//           .whereType<FutureDependency>()
//           .length; // Offset for AsyncValue results in allRawResults

//       for (var i = 0; i < deps.length; i++) {
//         final dep = deps[i];
//         if (dep is AsyncValueDependency) {
//           // Get the value from the corresponding AsyncValue result in allRawResults
//           // Note: This assumes AsyncValue.future resolves with the value.
//           // A safer way might be to re-read the provider state *after* await.
//           // Let's re-read for safety:
//           final asyncValue = ref.read(dep.provider);
//           if (asyncValue.hasError) {
//             // If error occurred even after waiting, throw it.
//             // Need to handle stack trace properly.
//             await Future.error(asyncValue.error!, asyncValue.stackTrace);
//           }
//           finalResults.add(asyncValue.requireValue); // Should be safe now
//         } else if (dep is FutureDependency) {
//           // Get the value from the Future.wait results
//           finalResults.add(allRawResults[futureIdx++]);
//         }
//       }

//       // Map the combined results to the final state T
//       return mapData(finalResults);
//     } catch (error, stackTrace) {
//       // Catch any error from Future.wait or requireValue/mapData
//       // Rethrow to let AsyncNotifier set the AsyncError state
//       // Using Future.error ensures it's treated as an async error state
//       await Future.error(error, stackTrace);
//       // This line should not be reached, but needed for type checking
//       rethrow;
//     }
//   }

//   /// Invalidates the ViewModel, causing `build` to re-run.
//   void invalidateAll() {
//     ref.invalidateSelf();
//   }

//   /// Refreshes the ViewModel and returns a Future that completes when the rebuild is finished.
//   Future<void> refreshAll() async {
//     ref.invalidateSelf();
//     // Await the new future provided by AsyncNotifier after invalidation
//     await future;
//   }
// }
