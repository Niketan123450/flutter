import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/model/movie_model.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitialState()) {
    on<BookmarkInitialEvent>(bookmarkInitialEvent);
  }

  Future<void> bookmarkInitialEvent(
    BookmarkInitialEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoadingState());
    String jsonString = await rootBundle.loadString('assets/movies.json');

    // Parse JSON and return list of MovieModel
    List<MovieModel> movies = movieModelFromJson(jsonString);
    emit(BookmarkSuccessState(bookmarkList: movies));
  }
}
