import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/controller/watchlist_bloc/watchlist_event.dart';
import 'package:movie_search_application/controller/watchlist_bloc/watchlist_state.dart';
import 'package:movie_search_application/model/movie_model.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListInitialState()) {
    on<WatchListInitialEvent>(watchListInitialEvent);
  }

  Future<void> watchListInitialEvent(
    WatchListInitialEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(WatchListLoadingState());
    String jsonString = await rootBundle.loadString('assets/movies.json');

    // Parse JSON and return list of MovieModel
    List<MovieModel> movies = movieModelFromJson(jsonString);
    emit(WatchListSuccessState(watchListList: movies));
  }
}
