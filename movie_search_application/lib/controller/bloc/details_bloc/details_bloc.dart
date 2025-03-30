import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:movie_search_application/controller/bloc/details_bloc/details_event.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/controller/session_data.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitialState()) {
    on<DetailsInitialEvent>(detailsInitialEvent);
    on<AddBookmarkEvent>(addBookmarkEvent);
    on<RemoveBookmarkEvent>(removeBookmarkEvent);
    on<AddWatchListEvent>(addWatchListEvent);
    on<RemoveWatchListEvent>(removeWatchListEvent);
  }

  Future<void> detailsInitialEvent(
    DetailsInitialEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoadingState());
    List<MovieModel> bookmarkMovies = await SessionData.getBookmarks();
    List<MovieModel> watchListMovies = await SessionData.getWatchLists();
    emit(
      DetailsSuccessState(
        bookmarkList: bookmarkMovies,
        watchListList: watchListMovies,
      ),
    );
  }

  // Add Movie to Bookmark
  Future<void> addBookmarkEvent(
    AddBookmarkEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> bookmarkMovies = await SessionData.getBookmarks();
    List<MovieModel> watchListMovies = await SessionData.getWatchLists();
    bookmarkMovies.add(event.movie);
    await SessionData.storeBookmarks(bookmarkMovies);
    emit(
      DetailsSuccessState(
        bookmarkList: bookmarkMovies,
        watchListList: watchListMovies,
      ),
    );
  }

  Future<void> addWatchListEvent(
    AddWatchListEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> bookmarkMovies = await SessionData.getBookmarks();
    List<MovieModel> watchListMovies = await SessionData.getWatchLists();
    watchListMovies.add(event.movie);
    await SessionData.storeWatchLists(watchListMovies);
    emit(
      DetailsSuccessState(
        bookmarkList: bookmarkMovies,
        watchListList: watchListMovies,
      ),
    );
  }

  Future<void> removeBookmarkEvent(
    RemoveBookmarkEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> bookmarkMovies = await SessionData.getBookmarks();
    List<MovieModel> watchListMovies = await SessionData.getWatchLists();
    bookmarkMovies.removeWhere((m) => m.title == event.movie.title);
    await SessionData.storeBookmarks(bookmarkMovies);
    emit(
      DetailsSuccessState(
        bookmarkList: bookmarkMovies,
        watchListList: watchListMovies,
      ),
    );
  }

  Future<void> removeWatchListEvent(
    RemoveWatchListEvent event,
    Emitter<DetailsState> emit,
  ) async {
    List<MovieModel> bookmarkMovies = await SessionData.getBookmarks();
    List<MovieModel> watchListMovies = await SessionData.getWatchLists();
    watchListMovies.removeWhere((m) => m.title == event.movie.title);
    await SessionData.storeWatchLists(watchListMovies);
    emit(
      DetailsSuccessState(
        bookmarkList: bookmarkMovies,
        watchListList: watchListMovies,
      ),
    );
  }
}
