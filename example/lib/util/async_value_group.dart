// ignore_for_file: avoid_catches_without_on_clauses, public_member_api_docs, strict_raw_type, lines_longer_than_80_chars

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 複数の [AsyncValue] をグループ化して、1つの [AsyncValue] として扱えるようにするための拡張クラス。
///
/// [AsyncValue] の [when] を参考に実装している。
extension AsyncValueGroup on AsyncValue {
  /// 2つの [AsyncValue] をグループ化して、1つの [AsyncValue] にする。
  ///
  /// 以下のような状態の制御が可能である。
  ///
  /// - 初回ローディング時は常に [AsyncLoading] を返す。
  /// - リフレッシュ時とリロード時は、オプションによって既存の値を使用するか [AsyncLoading] を返すかを制御できる。
  /// - エラー時は [AsyncError] を返す。
  ///
  /// ```dart
  /// // 基本的な使用例
  /// final asyncValueGroup = AsyncValueGroup.group2(asyncValue1, asyncValue2);
  ///
  /// // リロード時も既存の値を使用する例
  /// final asyncValueGroup = AsyncValueGroup.group2(
  ///   asyncValue1,
  ///   asyncValue2,
  ///   skipLoadingOnReload: true,
  /// );
  /// ```
  ///
  /// パラメータ:
  ///
  /// - [t1] には 1 つめの [AsyncValue] を指定する。
  /// - [t2] には 2 つめの [AsyncValue] を指定する。
  /// - [skipLoadingOnReload] には リロード時（依存関係の変更による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リロード時に既存の値を使用する。
  ///   - false の場合、リロード時に [AsyncLoading] を返す。
  ///   - デフォルトは false.
  /// - [skipLoadingOnRefresh] には リフレッシュ時（手動による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リフレッシュ時に既存の値を使用する。
  ///   - false の場合、リフレッシュ時に [AsyncLoading] を返す。
  ///   - デフォルトは true.
  ///
  /// 戻り値:
  ///
  /// - 初回ローディング時: [AsyncLoading].
  /// - リフレッシュ時: [skipLoadingOnRefresh] の値に応じて既存の値または [AsyncLoading].
  /// - リロード時: [skipLoadingOnReload] の値に応じて既存の値または [AsyncLoading].
  /// - エラー時: [AsyncError].
  /// - それ以外: 全ての値を組み合わせた [AsyncData].
  static AsyncValue<(T1, T2)> group2<T1, T2>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading = t1 is AsyncLoading || t2 is AsyncLoading;
    final isRefreshing = t1.isRefreshing || t2.isRefreshing;
    final isReloading = t1.isReloading || t2.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) || (t2.hasError && (!t2.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error = [t1, t2].firstWhere((t) => t.hasError).error ??
          'Unknown error occurred.';
      final stackTrace = [t1, t2].firstWhere((t) => t.hasError).stackTrace ??
          StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData((t1.requireValue, t2.requireValue));
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  /// 3つの [AsyncValue] をグループ化して、1つの [AsyncValue] にする。
  ///
  /// 以下のような状態の制御が可能である。
  ///
  /// - 初回ローディング時は常に [AsyncLoading] を返す。
  /// - リフレッシュ時とリロード時は、オプションによって既存の値を使用するか [AsyncLoading] を返すかを制御できる。
  /// - エラー時は [AsyncError] を返す。
  ///
  /// ```dart
  /// // 基本的な使用例
  /// final asyncValueGroup = AsyncValueGroup.group3(asyncValue1, asyncValue2, asyncValue3);
  ///
  /// // リロード時も既存の値を使用する例
  /// final asyncValueGroup = AsyncValueGroup.group3(
  ///   asyncValue1,
  ///   asyncValue2,
  ///   asyncValue3,
  ///   skipLoadingOnReload: true,
  /// );
  /// ```
  ///
  /// パラメータ:
  ///
  /// - [t1] には 1 つめの [AsyncValue] を指定する。
  /// - [t2] には 2 つめの [AsyncValue] を指定する。
  /// - [t3] には 3 つめの [AsyncValue] を指定する。
  /// - [skipLoadingOnReload] には リロード時（依存関係の変更による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リロード時に既存の値を使用する。
  ///   - false の場合、リロード時に [AsyncLoading] を返す。
  ///   - デフォルトは false.
  /// - [skipLoadingOnRefresh] には リフレッシュ時（手動による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リフレッシュ時に既存の値を使用する。
  ///   - false の場合、リフレッシュ時に [AsyncLoading] を返す。
  ///   - デフォルトは true.
  ///
  /// 戻り値:
  ///
  /// - 初回ローディング時: [AsyncLoading].
  /// - リフレッシュ時: [skipLoadingOnRefresh] の値に応じて既存の値または [AsyncLoading].
  /// - リロード時: [skipLoadingOnReload] の値に応じて既存の値または [AsyncLoading].
  /// - エラー時: [AsyncError].
  /// - それ以外: 全ての値を組み合わせた [AsyncData].
  static AsyncValue<(T1, T2, T3)> group3<T1, T2, T3>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2,
    AsyncValue<T3> t3, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading =
        t1 is AsyncLoading || t2 is AsyncLoading || t3 is AsyncLoading;
    final isRefreshing = t1.isRefreshing || t2.isRefreshing || t3.isRefreshing;
    final isReloading = t1.isReloading || t2.isReloading || t3.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) ||
        (t2.hasError && (!t2.hasValue)) ||
        (t3.hasError && (!t3.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error = [t1, t2, t3].firstWhere((t) => t.hasError).error ??
          'Unknown error occurred.';
      final stackTrace =
          [t1, t2, t3].firstWhere((t) => t.hasError).stackTrace ??
              StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData((t1.requireValue, t2.requireValue, t3.requireValue));
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  /// 4つの [AsyncValue] をグループ化して、1つの [AsyncValue] にする。
  ///
  /// 以下のような状態の制御が可能である。
  ///
  /// - 初回ローディング時は常に [AsyncLoading] を返す。
  /// - リフレッシュ時とリロード時は、オプションによって既存の値を使用するか [AsyncLoading] を返すかを制御できる。
  /// - エラー時は [AsyncError] を返す。
  ///
  /// ```dart
  /// // 基本的な使用例
  /// final asyncValueGroup = AsyncValueGroup.group4(asyncValue1, asyncValue2, asyncValue3, asyncValue4);
  ///
  /// // リロード時も既存の値を使用する例
  /// final asyncValueGroup = AsyncValueGroup.group4(
  ///   asyncValue1,
  ///   asyncValue2,
  ///   asyncValue3,
  ///   asyncValue4,
  ///   skipLoadingOnReload: true,
  /// );
  /// ```
  ///
  /// パラメータ:
  ///
  /// - [t1] には 1 つめの [AsyncValue] を指定する。
  /// - [t2] には 2 つめの [AsyncValue] を指定する。
  /// - [t3] には 3 つめの [AsyncValue] を指定する。
  /// - [t4] には 4 つめの [AsyncValue] を指定する。
  /// - [skipLoadingOnReload] には リロード時（依存関係の変更による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リロード時に既存の値を使用する。
  ///   - false の場合、リロード時に [AsyncLoading] を返す。
  ///   - デフォルトは false.
  /// - [skipLoadingOnRefresh] には リフレッシュ時（手動による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リフレッシュ時に既存の値を使用する。
  ///   - false の場合、リフレッシュ時に [AsyncLoading] を返す。
  ///   - デフォルトは true.
  ///
  /// 戻り値:
  ///
  /// - 初回ローディング時: [AsyncLoading].
  /// - リフレッシュ時: [skipLoadingOnRefresh] の値に応じて既存の値または [AsyncLoading].
  /// - リロード時: [skipLoadingOnReload] の値に応じて既存の値または [AsyncLoading].
  /// - エラー時: [AsyncError].
  /// - それ以外: 全ての値を組み合わせた [AsyncData].
  static AsyncValue<(T1, T2, T3, T4)> group4<T1, T2, T3, T4>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2,
    AsyncValue<T3> t3,
    AsyncValue<T4> t4, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading = t1 is AsyncLoading ||
        t2 is AsyncLoading ||
        t3 is AsyncLoading ||
        t4 is AsyncLoading;
    final isRefreshing = t1.isRefreshing ||
        t2.isRefreshing ||
        t3.isRefreshing ||
        t4.isRefreshing;
    final isReloading =
        t1.isReloading || t2.isReloading || t3.isReloading || t4.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) ||
        (t2.hasError && (!t2.hasValue)) ||
        (t3.hasError && (!t3.hasValue)) ||
        (t4.hasError && (!t4.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error = [t1, t2, t3, t4].firstWhere((t) => t.hasError).error ??
          'Unknown error occurred.';
      final stackTrace =
          [t1, t2, t3, t4].firstWhere((t) => t.hasError).stackTrace ??
              StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData(
        (t1.requireValue, t2.requireValue, t3.requireValue, t4.requireValue),
      );
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  /// 5つの [AsyncValue] をグループ化して、1つの [AsyncValue] にする。
  ///
  /// 以下のような状態の制御が可能である。
  ///
  /// - 初回ローディング時は常に [AsyncLoading] を返す。
  /// - リフレッシュ時とリロード時は、オプションによって既存の値を使用するか [AsyncLoading] を返すかを制御できる。
  /// - エラー時は [AsyncError] を返す。
  ///
  /// ```dart
  /// // 基本的な使用例
  /// final asyncValueGroup = AsyncValueGroup.group5(asyncValue1, asyncValue2, asyncValue3, asyncValue4, asyncValue5);
  ///
  /// // リロード時も既存の値を使用する例
  /// final asyncValueGroup = AsyncValueGroup.group5(
  ///   asyncValue1,
  ///   asyncValue2,
  ///   asyncValue3,
  ///   asyncValue4,
  ///   asyncValue5,
  ///   skipLoadingOnReload: true,
  /// );
  /// ```
  ///
  /// パラメータ:
  ///
  /// - [t1] には 1 つめの [AsyncValue] を指定する。
  /// - [t2] には 2 つめの [AsyncValue] を指定する。
  /// - [t3] には 3 つめの [AsyncValue] を指定する。
  /// - [t4] には 4 つめの [AsyncValue] を指定する。
  /// - [t5] には 5 つめの [AsyncValue] を指定する。
  /// - [skipLoadingOnReload] には リロード時（依存関係の変更による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リロード時に既存の値を使用する。
  ///   - false の場合、リロード時に [AsyncLoading] を返す。
  ///   - デフォルトは false.
  /// - [skipLoadingOnRefresh] には リフレッシュ時（手動による更新）に既存の値を使用するかどうかを指定する。
  ///   - true の場合、リフレッシュ時に既存の値を使用する。
  ///   - false の場合、リフレッシュ時に [AsyncLoading] を返す。
  ///   - デフォルトは true.
  ///
  /// 戻り値:
  ///
  /// - 初回ローディング時: [AsyncLoading].
  /// - リフレッシュ時: [skipLoadingOnRefresh] の値に応じて既存の値または [AsyncLoading].
  /// - リロード時: [skipLoadingOnReload] の値に応じて既存の値または [AsyncLoading].
  /// - エラー時: [AsyncError].
  /// - それ以外: 全ての値を組み合わせた [AsyncData].
  static AsyncValue<(T1, T2, T3, T4, T5)> group5<T1, T2, T3, T4, T5>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2,
    AsyncValue<T3> t3,
    AsyncValue<T4> t4,
    AsyncValue<T5> t5, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading = t1 is AsyncLoading ||
        t2 is AsyncLoading ||
        t3 is AsyncLoading ||
        t4 is AsyncLoading ||
        t5 is AsyncLoading;
    final isRefreshing = t1.isRefreshing ||
        t2.isRefreshing ||
        t3.isRefreshing ||
        t4.isRefreshing ||
        t5.isRefreshing;
    final isReloading = t1.isReloading ||
        t2.isReloading ||
        t3.isReloading ||
        t4.isReloading ||
        t5.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) ||
        (t2.hasError && (!t2.hasValue)) ||
        (t3.hasError && (!t3.hasValue)) ||
        (t4.hasError && (!t4.hasValue)) ||
        (t5.hasError && (!t5.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error = [t1, t2, t3, t4, t5].firstWhere((t) => t.hasError).error ??
          'Unknown error occurred.';
      final stackTrace =
          [t1, t2, t3, t4, t5].firstWhere((t) => t.hasError).stackTrace ??
              StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData(
        (
          t1.requireValue,
          t2.requireValue,
          t3.requireValue,
          t4.requireValue,
          t5.requireValue
        ),
      );
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  static AsyncValue<(T1, T2, T3, T4, T5, T6)> group6<T1, T2, T3, T4, T5, T6>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2,
    AsyncValue<T3> t3,
    AsyncValue<T4> t4,
    AsyncValue<T5> t5,
    AsyncValue<T6> t6, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading = t1 is AsyncLoading ||
        t2 is AsyncLoading ||
        t3 is AsyncLoading ||
        t4 is AsyncLoading ||
        t5 is AsyncLoading ||
        t6 is AsyncLoading;
    final isRefreshing = t1.isRefreshing ||
        t2.isRefreshing ||
        t3.isRefreshing ||
        t4.isRefreshing ||
        t5.isRefreshing ||
        t6.isRefreshing;
    final isReloading = t1.isReloading ||
        t2.isReloading ||
        t3.isReloading ||
        t4.isReloading ||
        t5.isReloading ||
        t6.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) ||
        (t2.hasError && (!t2.hasValue)) ||
        (t3.hasError && (!t3.hasValue)) ||
        (t4.hasError && (!t4.hasValue)) ||
        (t5.hasError && (!t5.hasValue)) ||
        (t6.hasError && (!t6.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error =
          [t1, t2, t3, t4, t5, t6].firstWhere((t) => t.hasError).error ??
              'Unknown error occurred.';
      final stackTrace =
          [t1, t2, t3, t4, t5, t6].firstWhere((t) => t.hasError).stackTrace ??
              StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData(
        (
          t1.requireValue,
          t2.requireValue,
          t3.requireValue,
          t4.requireValue,
          t5.requireValue,
          t6.requireValue
        ),
      );
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  static AsyncValue<(T1, T2, T3, T4, T5, T6, T7)>
      group7<T1, T2, T3, T4, T5, T6, T7>(
    AsyncValue<T1> t1,
    AsyncValue<T2> t2,
    AsyncValue<T3> t3,
    AsyncValue<T4> t4,
    AsyncValue<T5> t5,
    AsyncValue<T6> t6,
    AsyncValue<T7> t7, {
    // リロード時（依存関係の変更による更新）の挙動を制御する。
    // true の場合、リロード時に既存の値を使用する。
    bool skipLoadingOnReload = false,
    // リフレッシュ時（手動による更新）の挙動を制御する。
    // true の場合、リフレッシュ時に既存の値を使用する。
    bool skipLoadingOnRefresh = true,
  }) {
    // リフレッシュ中とリロード中の判定をする。
    final isLoading = t1 is AsyncLoading ||
        t2 is AsyncLoading ||
        t3 is AsyncLoading ||
        t4 is AsyncLoading ||
        t5 is AsyncLoading ||
        t6 is AsyncLoading ||
        t7 is AsyncLoading;
    final isRefreshing = t1.isRefreshing ||
        t2.isRefreshing ||
        t3.isRefreshing ||
        t4.isRefreshing ||
        t5.isRefreshing ||
        t6.isRefreshing ||
        t7.isRefreshing;
    final isReloading = t1.isReloading ||
        t2.isReloading ||
        t3.isReloading ||
        t4.isReloading ||
        t5.isReloading ||
        t6.isReloading ||
        t7.isReloading;

    // ロード中をスキップするべきか判定し、スキップしない場合のみ AsyncLoading を返す。
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) {
        return const AsyncLoading();
      }
    }

    // エラーがある場合は AsyncError を返す。
    if ((t1.hasError && (!t1.hasValue)) ||
        (t2.hasError && (!t2.hasValue)) ||
        (t3.hasError && (!t3.hasValue)) ||
        (t4.hasError && (!t4.hasValue)) ||
        (t5.hasError && (!t5.hasValue)) ||
        (t6.hasError && (!t6.hasValue)) ||
        (t7.hasError && (!t7.hasValue))) {
      // エラーを持つ最初の AsyncValue のエラーを返す。
      final error =
          [t1, t2, t3, t4, t5, t6, t7].firstWhere((t) => t.hasError).error ??
              'Unknown error occurred.';
      final stackTrace = [t1, t2, t3, t4, t5, t6, t7]
              .firstWhere((t) => t.hasError)
              .stackTrace ??
          StackTrace.current;
      return AsyncError(error, stackTrace);
    }

    // それ以外の場合は、全ての値を組み合わせた AsyncData を返す。
    try {
      return AsyncData(
        (
          t1.requireValue,
          t2.requireValue,
          t3.requireValue,
          t4.requireValue,
          t5.requireValue,
          t6.requireValue,
          t7.requireValue
        ),
      );
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }
}
