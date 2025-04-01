import 'package:go_router/go_router.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/view/Login_Register/login_screen.dart';
import 'package:movie_search_application/view/Login_Register/register_screen.dart';
import 'package:movie_search_application/view/details/details_screen.dart';
import 'package:movie_search_application/view/navbar/navbar_screen.dart';
import 'package:movie_search_application/view/search/search_screen.dart';
import 'package:movie_search_application/view/see_all/see_all_screen.dart';
import 'package:movie_search_application/view/splash/splash_screen.dart';
import 'package:movie_search_application/view/welcome/welcome_screen.dart';

GoRouter route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/navbar',
      name: 'navbar',
      builder: (context, state) => const NavbarScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/seeAll',
      name: 'seeAll',
      builder: (context, state) => const SeeAllScreen(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      builder: (context, state) {
        final movie = state.extra as MovieModel;
        return DetailsScreen(movieModel: movie);
      },
    ),
  ],
);
