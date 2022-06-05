part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {
  const BookmarkEvent();
}

class BookmarkLoad extends BookmarkEvent {}

class BookmarkCreate extends BookmarkEvent {
  final Bookmark bookmark;
  const BookmarkCreate({required this.bookmark});
}

class BookmarkUpdate extends BookmarkEvent {
  final Bookmark bookmark;
  const BookmarkUpdate({required this.bookmark});
}

class BookmarkDelete extends BookmarkEvent {
  final Bookmark bookmark;
  const BookmarkDelete({required this.bookmark});
}
