import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRegisterBloc = LoginRegisterBloc();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<LoginRegisterBloc, LoginRegisterState>(
        bloc: loginRegisterBloc,
        listener: (context, state) {
          /// Go to login screen
          if (state is LoginNavigateState) {
            context.push('/login');
          }
          /// Go to Register Screen
          else if (state is RegisterNavigateState) {
            context.push('/register');
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 15,
            right: 27,
            left: 27,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth,
                child: Text(
                  "Search & Discover Movies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Image.asset("assets/images/welcome.png"),
              const SizedBox(height: 9),

              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      loginRegisterBloc.add(RegisterNavigateEvent());
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      margin: const EdgeInsets.only(top: 30),
                      height: screenHeight * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(screenWidth * 0.4),
                      ),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      loginRegisterBloc.add(LoginNavigateEvent());
                    },
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(229, 243, 255, 1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.4),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
