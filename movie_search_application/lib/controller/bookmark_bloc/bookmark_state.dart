import 'package:movie_search_application/model/movie_model.dart';

abstract class BookmarkState {}

abstract class BookmarkActionState extends BookmarkState {}

class BookmarkInitialState extends BookmarkState {}

class BookmarkLoadingState extends BookmarkState {}

class BookmarkSuccessState extends BookmarkState {
  final List<MovieModel> bookmarkList;

  BookmarkSuccessState({required this.bookmarkList});
}

class BookmarkFailureState extends BookmarkState {}
