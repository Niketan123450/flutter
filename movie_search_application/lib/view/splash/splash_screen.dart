import 'package:flutter/material.dart';
import 'package:movie_search_application/view/navbar/navbar_screen.dart';
import 'package:movie_search_application/shared_preference/session_data.dart';
import 'package:movie_search_application/view/welcome/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      await SessionData.getSessiondata();

      /// check is user has already logged in or not
      if (SessionData.isLogin!) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NavbarScreen()),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 138, 196, 1),
      body: Center(child: Image.asset("assets/images/splash.png")),
    );
  }
}
