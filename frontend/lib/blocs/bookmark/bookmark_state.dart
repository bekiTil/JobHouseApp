part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState {
  const BookmarkState();
}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoadSuccess extends BookmarkState {
  final List<Bookmark> bookmarks;
  final String type;

  const BookmarkLoadSuccess(
      {required this.type, this.bookmarks = const <Bookmark>[]});
}

class BookmarkOperationFailure extends BookmarkState {
  final Object? error;

  const BookmarkOperationFailure({this.error});
}
