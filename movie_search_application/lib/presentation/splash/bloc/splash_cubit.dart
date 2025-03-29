import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStated() async {
    await Future.delayed(Duration(seconds: 2));
    emit(Authenticated());
  }
}
