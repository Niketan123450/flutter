import 'package:movie_search_application/model/movie_model.dart';

abstract class WatchListState {}

abstract class WatchListActionState extends WatchListState {}

class WatchListInitialState extends WatchListState {}

class WatchListLoadingState extends WatchListState {}

class WatchListSuccessState extends WatchListState {
  final List<MovieModel> watchListList;

  WatchListSuccessState({required this.watchListList});
}

class WatchListFailureState extends WatchListState {}
