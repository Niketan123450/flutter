import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_event.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_state.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/controller/shared_preferences/session_data.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListInitialState()) {
    on<WatchListInitialEvent>(watchListInitialEvent);
  }

  Future<void> watchListInitialEvent(
    WatchListInitialEvent event,
    Emitter<WatchListState> emit,
  ) async {
    emit(WatchListLoadingState());
    List<MovieModel> movies = await SessionData.getWatchLists();
    emit(WatchListSuccessState(watchListList: movies));
  }
}
