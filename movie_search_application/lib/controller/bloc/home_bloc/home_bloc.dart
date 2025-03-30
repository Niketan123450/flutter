import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_event.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_state.dart';
import 'package:movie_search_application/model/movie_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  Future<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    String jsonString = await rootBundle.loadString('assets/movies.json');

    // Parse JSON and return list of MovieModel
    List<MovieModel> movies = movieModelFromJson(jsonString);
    emit(HomeSuccessState(movieList: movies));
  }
}
