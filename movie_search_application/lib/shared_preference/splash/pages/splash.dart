import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/core/configs/assets/app_images.dart';
// import 'package:movie_search_application/presentation/auth/pages/signin.dart';
import 'package:movie_search_application/view/home/pages/home.dart';
import 'package:movie_search_application/shared_preference/splash/bloc/splash_cubit.dart';
import 'package:movie_search_application/shared_preference/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // AppNavigator.pushReplacement(context, SigninPage());
          }
          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const HomePage());
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(152, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
