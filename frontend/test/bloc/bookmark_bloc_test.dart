import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/bookmark_repository.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

final post = Post(
    id: "23jkfhkf",
    poster_id: 'dfjshj',
    number: 3,
    description: "kjdf",
    category: "kfjdsj",
    posterName: "kdfgkjf",
    date: "kdfhjha");
final bookmark = Bookmark(user_id: "klfaj;lf", post_id: "klsafj", post: post);

class MockBookmarkRepository extends Mock implements BookmarkRepository {}

@GenerateMocks([CompanyRepository, PostRepository])
void main() {
  final mockPostRepository = MockBookmarkRepository();
  group('Bookmark Bloc', () {
    blocTest<BookmarkBloc, BookmarkState>(
      'emits nothing when no event is added',
      build: () => BookmarkBloc(),
      expect: () => [],
    );

    blocTest<BookmarkBloc, BookmarkState>(
      'emits [BookmarkOperationFailure] when BookmarkCreate is added',
      build: () => BookmarkBloc(),
      act: (bookmarkBloc) => bookmarkBloc.add(BookmarkCreate(bookmark: bookmark)),
      expect: () => [
        const BookmarkOperationFailure(error: "fake exception"),
      ],
    );

    blocTest<BookmarkBloc, BookmarkState>(
      'emits [BookmarkOperationFailure] when BookmarkUpdate is added',
      build: () => BookmarkBloc(),
      act: (bookmarkBloc) => bookmarkBloc.add(BookmarkUpdate(bookmark: bookmark)),
      expect: () => [
        const BookmarkOperationFailure(error: "fake exception"),
      ],
    );

    blocTest<BookmarkBloc, BookmarkState>(
      'emits [BookmarkLoading, BookmarkOperationFailure] when BookmarkDelete is added',
      build: () => BookmarkBloc(),
      act: (bookmarkBloc) => bookmarkBloc.add(BookmarkDelete(bookmark: bookmark)),
      expect: () => [
        BookmarkLoading(),
        const BookmarkOperationFailure(error: "fake exception"),
      ],
    );
  });
}
