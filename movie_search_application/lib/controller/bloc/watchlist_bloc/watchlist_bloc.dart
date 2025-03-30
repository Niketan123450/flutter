import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_event.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/controller/session_data.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListInitialState()) {
    on<WatchListInitialEvent>(watchListInitialEvent);
    on<AddWatchListEvent>(addWatchListEvent);
    on<RemoveWatchListEvent>(removeWatchListEvent);
  }

  Future<void> watchListInitialEvent(
    WatchListInitialEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(WatchListLoadingState());
    List<MovieModel> movies = await SessionData.getWatchLists();
    emit(WatchListSuccessState(watchListList: movies));
  }

  // Add Movie to Bookmark
  Future<void> addWatchListEvent(
    AddWatchListEvent event,
    Emitter<WatchListState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getWatchLists();
    movies.add(event.movie);
    await SessionData.storeWatchLists(movies);
    emit(WatchListSuccessState(watchListList: movies));
  }

  Future<void> removeWatchListEvent(
    RemoveWatchListEvent event,
    Emitter<WatchListState> emit,
  ) async {
    List<MovieModel> movies = await SessionData.getWatchLists();
    movies.removeWhere((m) => m.title == event.movie.title);
    await SessionData.storeWatchLists(movies);
    emit(WatchListSuccessState(watchListList: movies));
  }
}
