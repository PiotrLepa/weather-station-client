import 'package:flutter/cupertino.dart';
import 'package:kt_dart/collection.dart';

mixin PaginationHandler<T> {
  int _page = 0;
  bool _hasReachedEnd = false;
  KtMutableList<T> _fetchedItems = KtMutableList.empty();

  void onPageFetched({
    @required int page,
    @required bool hasReachedEnd,
    @required KtList<T> items,
  }) {
    _page = page;
    _hasReachedEnd = hasReachedEnd;
    _fetchedItems.addAll(items);
  }

  KtList<T> getAllItems() => _fetchedItems;

  int getNextPage() => _page + 1;

  bool hasMorePages() => !_hasReachedEnd;

  void clearPagination() {
    _page = 0;
    _hasReachedEnd = false;
    _fetchedItems = KtMutableList.empty();
  }
}
