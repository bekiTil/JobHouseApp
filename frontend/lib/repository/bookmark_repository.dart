import 'package:flutter/material.dart';
import 'package:frontend/data_Providers/bookmark_data_providers.dart';
import 'package:frontend/models/bookmark.dart';

class BookmarkRepository {
  final BookmarkDataProvider dataProvider = BookmarkDataProvider();

  Future<Bookmark>? createBookmark(Bookmark bookmark) async {
    return await dataProvider.createBookmark(bookmark);
  }

  Future<List<Bookmark>>? getBookmarks() async {
    try {
      return await dataProvider.getBookmarks();
    } catch (e) {
      rethrow;
    }
  }

  Future<Bookmark>? updateBookmark(Bookmark bookmark) async {
    return await dataProvider.updateBookmarks(bookmark);
  }

  Future<void>? deleteBookmark(String? id) async {
    return await dataProvider.deleteBookmark(id!);
  }
}
