part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState extends Equatable{
  const BookmarkState();
}

class BookmarkLoading extends BookmarkState {
  @override
  List<Object?> get props => [];
}

class BookmarkLoadSuccess extends BookmarkState {
  final List<Bookmark> bookmarks;
  final String type;

  const BookmarkLoadSuccess(
      {required this.type, this.bookmarks = const <Bookmark>[]});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookmarkOperationFailure extends BookmarkState {
  final Object? error;

  const BookmarkOperationFailure({this.error});

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
