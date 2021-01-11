import 'package:kt_dart/collection.dart';

extension KtListExtension<T> on Iterable<T> {
  KtList<T> toKtList() => KtList.from(this);

  KtMutableList<T> toKtMutableList() => KtMutableList.from(this);
}
