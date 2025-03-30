import 'package:movie_search_application/model/movie_model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<MovieModel> movieList;

  HomeSuccessState({required this.movieList});
}

class HomeFailureState extends HomeState {}
