import 'package:flutter/material.dart';
import 'package:frontend/data_Providers/bookmark_data_providers.dart';
import 'package:frontend/models/bookmark.dart';

class BookmarkRepository {
  final BookmarkDataProvider dataRepository;

  BookmarkRepository({
    required this.dataRepository,
  }) : assert(dataRepository != null);

  Future<Bookmark> createBookmark(Bookmark bookmark) async {
    return await dataRepository.createBookmark(bookmark);
  }

  Future<List<Bookmark>> getBookmarks() async {
    return await dataRepository.getBookmarks();
  }

  Future<Bookmark> updateBookmark(Bookmark bookmark) async {
    return await dataRepository.updateBookmarks(bookmark);
  }

  Future<void> deleteBookmark(String id) async {
    return await dataRepository.deleteBookmark(id);
  }
}
