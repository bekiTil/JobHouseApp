part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class BookmarkLoad extends BookmarkEvent {
  const BookmarkLoad();

  @override
  List<Object> get props => [];
}

class BookmarkCreate extends BookmarkEvent {
  final Bookmark bookmark;

  const BookmarkCreate({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}

class BookmarkUpdate extends BookmarkEvent {
  final Bookmark bookmark;

  const BookmarkUpdate({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}

class BookmarkDelete extends BookmarkEvent {
  final Bookmark bookmark;

  const BookmarkDelete({required this.bookmark});

  @override
  List<Object> get props => [bookmark];
}


