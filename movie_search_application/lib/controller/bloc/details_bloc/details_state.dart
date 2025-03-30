import 'package:movie_search_application/model/movie_model.dart';

abstract class DetailsState {}

abstract class DetailsActionState extends DetailsState {}

class DetailsInitialState extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsSuccessState extends DetailsState {
  final List<MovieModel> bookmarkList;
  final List<MovieModel> watchListList;

  DetailsSuccessState({
    required this.bookmarkList,
    required this.watchListList,
  });
}

class DetailsFailureState extends DetailsState {}
