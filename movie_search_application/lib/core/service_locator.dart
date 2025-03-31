import 'package:get_it/get_it.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_bloc.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/navbar_bloc/navbar_bloc.dart';
import 'package:movie_search_application/controller/bloc/search_bloc/search_bloc.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Bloc
  getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
  getIt.registerLazySingleton<BookmarkBloc>(() => BookmarkBloc());
  getIt.registerLazySingleton<DetailsBloc>(() => DetailsBloc());
  getIt.registerLazySingleton<LoginRegisterBloc>(() => LoginRegisterBloc());
  getIt.registerLazySingleton<NavbarBloc>(() => NavbarBloc());
  getIt.registerLazySingleton<SearchBloc>(() => SearchBloc());
  getIt.registerLazySingleton<WatchListBloc>(() => WatchListBloc());

  // registerFactory
  // getIt.registerFactory<HomeBloc>(() => HomeBloc());
  // getIt.registerFactory<BookmarkBloc>(() => BookmarkBloc());
  // getIt.registerFactory<DetailsBloc>(() => DetailsBloc());
  // getIt.registerFactory<LoginRegisterBloc>(() => LoginRegisterBloc());
  // getIt.registerFactory<NavbarBloc>(() => NavbarBloc());
  // getIt.registerFactory<SearchBloc>(() => SearchBloc());
  // getIt.registerFactory<WatchListBloc>(() => WatchListBloc());
}
