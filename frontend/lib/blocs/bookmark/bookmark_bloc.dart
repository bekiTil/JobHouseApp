import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/bookmark_repository.dart';
import 'package:meta/meta.dart';
part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkRepository bookmarkRepository = BookmarkRepository();

  BookmarkBloc() : super(BookmarkLoading()) {
    on<BookmarkLoad>((event, emit) async {
      emit(BookmarkLoading());
      try {
        final bookmarks = await bookmarkRepository.getBookmarks();
        emit(BookmarkLoadSuccess(bookmarks: bookmarks!, type: "load"));
      } catch (error) {
        emit(BookmarkOperationFailure(error: error));
      }
    });

    on<BookmarkCreate>((event, emit) async {
      try {
        await bookmarkRepository.createBookmark(event.bookmark);
        final bookmarks = await bookmarkRepository.getBookmarks();
        emit(BookmarkLoadSuccess(bookmarks: bookmarks!, type: "create"));
      } catch (error) {
        emit(BookmarkOperationFailure(error: error));
      }
    });
    on<BookmarkUpdate>((event, emit) async {
      try {
        await bookmarkRepository.updateBookmark(event.bookmark);
        final bookmarks = await bookmarkRepository.getBookmarks();
        emit(BookmarkLoadSuccess(bookmarks: bookmarks!, type: "update"));
      } catch (error) {
        emit(BookmarkOperationFailure(error: error));
      }
    });
    on<BookmarkDelete>((event, emit) async {
      emit(BookmarkLoading());
      try {
        await bookmarkRepository.deleteBookmark(event.bookmark.id);
        final bookmarks = await bookmarkRepository.getBookmarks();
        emit(BookmarkLoadSuccess(bookmarks: bookmarks!, type: "delete"));
      } catch (error) {
        emit(BookmarkOperationFailure(error: error));
      }
    });
  }
}
