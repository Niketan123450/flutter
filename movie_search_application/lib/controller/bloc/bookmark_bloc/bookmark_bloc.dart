import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/controller/session_data.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitialState()) {
    on<BookmarkInitialEvent>(bookmarkInitialEvent);
    on<AddBookmarkEvent>(addBookmarkEvent);
    on<RemoveBookmarkEvent>(removeBookmarkEvent);
  }

  Future<void> bookmarkInitialEvent(
    BookmarkInitialEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoadingState());
    List<MovieModel> movies = await SessionData.getBookmarks();
    emit(BookmarkSuccessState(bookmarkList: movies));
  }

  // Add Movie to Bookmark
  Future<void> addBookmarkEvent(
    AddBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getBookmarks();
    movies.add(event.movie);
    await SessionData.storeBookmarks(movies);
    emit(BookmarkSuccessState(bookmarkList: movies));
  }

  Future<void> removeBookmarkEvent(
    RemoveBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getBookmarks();
    movies.removeWhere((m) => m.title == event.movie.title);
    await SessionData.storeBookmarks(movies);
    emit(BookmarkSuccessState(bookmarkList: movies));
  }
}
