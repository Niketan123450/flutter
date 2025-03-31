import 'package:movie_search_application/model/movie_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<MovieModel> movieList;

  SearchLoadedState(this.movieList);
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}
