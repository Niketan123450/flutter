import 'package:get_it/get_it.dart';
import 'package:movie_search_application/controller/home_bloc/home_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<HomeBloc>(HomeBloc());
}
