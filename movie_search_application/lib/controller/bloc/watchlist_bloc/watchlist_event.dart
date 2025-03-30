import 'package:movie_search_application/model/movie_model.dart';

abstract class WatchListEvent {}

class WatchListInitialEvent extends WatchListEvent {}

class AddWatchListEvent extends WatchListEvent {
  final MovieModel movie;
  AddWatchListEvent({required this.movie});
}

class RemoveWatchListEvent extends WatchListEvent {
  final MovieModel movie;
  RemoveWatchListEvent({required this.movie});
}
