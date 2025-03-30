import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_application/controller/bloc/search_bloc/search_event.dart';
import 'package:movie_search_application/controller/bloc/search_bloc/search_state.dart';
import 'package:movie_search_application/model/movie_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<MovieModel> movieList = [];

  SearchBloc() : super(SearchInitialState()) {
    on<LoadMoviesEvent>(loadMovies);
    on<SearchMoviesEvent>(searchMovies);
  }

  Future<void> loadMovies(
    LoadMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    try {
      String jsonString = await rootBundle.loadString('assets/movies.json');

      movieList = movieModelFromJson(jsonString);
      emit(SearchLoadedState(movieList));
    } catch (e) {
      emit(SearchErrorState("Failed to load movies: ${e.toString()}"));
    }
  }

  void searchMovies(SearchMoviesEvent event, Emitter<SearchState> emit) {
    final query = event.query.toLowerCase();
    final filteredMovies =
        movieList
            .where((movie) => movie.title!.toLowerCase().contains(query))
            .toList();
    emit(SearchLoadedState(filteredMovies));
  }
}
