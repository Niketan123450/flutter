import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:movie_search_application/controller/details_bloc/details_event.dart';
import 'package:movie_search_application/controller/details_bloc/details_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/shared_preference/session_data.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitialState()) {
    on<DetailsInitialEvent>(detailsInitialEvent);
    on<AddBookmarkEvent>(addBookmarkEvent);
    on<RemoveBookmarkEvent>(removeBookmarkEvent);
  }

  Future<void> detailsInitialEvent(
    DetailsInitialEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoadingState());
    List<MovieModel> movies = await SessionData.getBookmarks();
    emit(DetailsSuccessState(bookmarkList: movies));
  }

  // Add Movie to Bookmark
  Future<void> addBookmarkEvent(
    AddBookmarkEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getBookmarks();
    movies.add(event.movie);
    await SessionData.storeBookmarks(movies);
    emit(DetailsSuccessState(bookmarkList: movies));
  }

  Future<void> removeBookmarkEvent(
    RemoveBookmarkEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getBookmarks();
    movies.removeWhere((m) => m.title == event.movie.title);
    await SessionData.storeBookmarks(movies);
    emit(DetailsSuccessState(bookmarkList: movies));
  }
}
