import 'package:kt_dart/collection.dart';

extension KtListExtension<T> on Iterable<T> {
  KtList<T> toKtList<T>() => KtList.from(this as Iterable<T>);

  KtMutableList<T> toKtMutableList<T>() =>
      KtMutableList.from(this as Iterable<T>);
}
