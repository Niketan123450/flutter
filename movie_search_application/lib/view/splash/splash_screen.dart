import 'package:flutter/material.dart';
import 'package:movie_search_application/view/navbar/navbar_screen.dart';
import 'package:movie_search_application/controller/shared_preference/session_data.dart';
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: const Color.fromARGB(160, 0, 0, 0),
            child: Image.asset("assets/images/splash.jpg", fit: BoxFit.cover),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(160, 0, 0, 0),
            // child: Image.asset("assets/images/splash.jpg", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
