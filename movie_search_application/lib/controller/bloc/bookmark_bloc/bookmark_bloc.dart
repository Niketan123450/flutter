import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/core/services/session_data.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitialState()) {
    on<BookmarkInitialEvent>(bookmarkInitialEvent);
  }

  Future<void> bookmarkInitialEvent(
    BookmarkInitialEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoadingState());
    List<MovieModel> movies = await SessionData.getBookmarks();
    emit(BookmarkSuccessState(bookmarkList: movies));
  }
}
