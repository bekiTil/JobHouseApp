import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/data_Providers/bookmark_data_providers.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../lib/repository/bookmark_repository.dart';
// import 'bookmark_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
class MockBookmarkRepository extends Mock implements BookmarkRepository {}

@GenerateMocks([MockBookmarkRepository])
void main() {
  final bookmarkRepository = MockBookmarkRepository();
  group("BookmarkRepository", () {
    final bookmarkJson = {
      "_id": "klfaj;lf",
      "user_id": "klsafj",
      "post_id": "ksdfha",
      "memo": "akdfhakfk",
      "post": {
        "_id": "kdfjhak",
        "poster_id": "lafssd",
        "number": 3,
        "description": "skfjs;gj",
        "category": "software",
        "image": "ldkfjla",
      }
    };
    final testerJson = {
      "_id": "1kdhfak33232",
      "user_id": "128jde383n3939",
      "post_id": "ksdkafak393099032fha",
      "memo": "it is the perfect",
      "post": {
        "_id": "alkfjalfjl12222",
        "poster_id": "dfkahl3498340",
        "number": 2,
        "description": "skfjs;gj",
        "category": "software",
        "image": "ldkfjla",
      }
    };
    final bookmark = Bookmark.fromJson(bookmarkJson);
    final tester = Bookmark.fromJson(testerJson);
    test('returns error when bookmark creation failed', () async {
      when(bookmarkRepository.createBookmark(bookmark))
          .thenAnswer((_) async => bookmark);
      final result = await bookmarkRepository.createBookmark(tester);
      expect(result, isA<Bookmark>());
    });
    test('returns error when bookmarks weren\'t loaded', () async {
      when(bookmarkRepository.getBookmarks())
          .thenAnswer((_) async => [bookmark, tester]);
      final result = await bookmarkRepository.getBookmarks();
      expect(result, isA<List<Bookmark>>());
    });

    test("returns error when bookmarks update isn't successful", () async {
      when(bookmarkRepository.updateBookmark(bookmark))
          .thenAnswer((_) async => bookmark);
      final result = await bookmarkRepository.updateBookmark(tester);
      expect(result, isA<Bookmark>());
    });

    test("returns error when bookmark deletion isn't working", () async {
      when(bookmarkRepository.deleteBookmark(bookmark.id))
          .thenAnswer((_) async {});
      final result = await bookmarkRepository.deleteBookmark(bookmark.id);
      expect(() => result, isNotNull);
    });
  });
}
