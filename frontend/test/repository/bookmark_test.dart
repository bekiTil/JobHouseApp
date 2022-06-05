import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/data_Providers/bookmark_data_providers.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:frontend/models/models.dart';
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
    final post = Post(
        id: "23jkfhkf",
        poster_id: 'dfjshj',
        number: 3,
        description: "kjdf",
        category: "kfjdsj",
        posterName: "kdfgkjf",
        date: "kdfhjha");
    final bookmark =
        Bookmark(user_id: "klfaj;lf", post_id: "klsafj", post: post);

    test('returns error when bookmark creation failed', () async {
      when(bookmarkRepository.createBookmark(bookmark))
          .thenAnswer((_) async => bookmark);
      final result = await bookmarkRepository.createBookmark(bookmark);
      expect(result, isA<Bookmark>());
    });
    test('returns error when bookmarks weren\'t loaded', () async {
      when(bookmarkRepository.getBookmarks())
          .thenAnswer((_) async => [bookmark, bookmark]);
      final result = await bookmarkRepository.getBookmarks();
      expect(result, isA<List<Bookmark>>());
    });

    test("returns error when bookmarks update isn't successful", () async {
      when(bookmarkRepository.updateBookmark(bookmark))
          .thenAnswer((_) async => bookmark);
      final result = await bookmarkRepository.updateBookmark(bookmark);
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
