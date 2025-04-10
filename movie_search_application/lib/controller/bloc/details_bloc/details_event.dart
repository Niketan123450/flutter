import 'package:movie_search_application/model/movie_model.dart';

abstract class DetailsEvent {}

class DetailsInitialEvent extends DetailsEvent {}

class AddBookmarkEvent extends DetailsEvent {
  final MovieModel movie;
  AddBookmarkEvent({required this.movie});
}

class RemoveBookmarkEvent extends DetailsEvent {
  final MovieModel movie;
  RemoveBookmarkEvent({required this.movie});
}

class AddWatchListEvent extends DetailsEvent {
  final MovieModel movie;
  AddWatchListEvent({required this.movie});
}

class RemoveWatchListEvent extends DetailsEvent {
  final MovieModel movie;
  RemoveWatchListEvent({required this.movie});
}
