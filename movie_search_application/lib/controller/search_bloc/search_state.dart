import 'package:equatable/equatable.dart';
import 'package:movie_search_application/model/movie_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<MovieModel> movieList;

  SearchLoadedState(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
