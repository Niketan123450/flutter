abstract class SearchEvent {}

class LoadMoviesEvent extends SearchEvent {}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  SearchMoviesEvent(this.query);
}
