import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoviesEvent extends SearchEvent {}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  SearchMoviesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
