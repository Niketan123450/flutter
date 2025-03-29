import 'package:get_it/get_it.dart';
import 'package:movie_search_application/controller/home_bloc/home_bloc.dart';
import 'package:movie_search_application/core/network/dio_client.dart';
import 'package:movie_search_application/data/auth/repositories/auth.dart';
import 'package:movie_search_application/data/auth/sources/auth_api_service.dart';
import 'package:movie_search_application/domain/auth/repositories/auth.dart';
import 'package:movie_search_application/domain/auth/usecases/signin.dart';
import 'package:movie_search_application/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  //Repostories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //UseCase
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<HomeBloc>(HomeBloc());
}
