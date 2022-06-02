part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoadSuccess extends BookmarkState {
  final List<Bookmark> bookmarks;

  BookmarkLoadSuccess({this.bookmarks = const <Bookmark>[]});

  @override
  List<Object> get props => [bookmarks];
}

class BookmarkOperationFailure extends BookmarkState {
  final Object? error;

  const BookmarkOperationFailure({this.error});
}
