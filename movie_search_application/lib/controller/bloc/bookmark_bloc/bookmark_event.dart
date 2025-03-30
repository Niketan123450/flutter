import 'package:movie_search_application/model/movie_model.dart';

abstract class BookmarkEvent {}

class BookmarkInitialEvent extends BookmarkEvent {}

class AddBookmarkEvent extends BookmarkEvent {
  final MovieModel movie;
  AddBookmarkEvent({required this.movie});
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final MovieModel movie;
  RemoveBookmarkEvent({required this.movie});
}
