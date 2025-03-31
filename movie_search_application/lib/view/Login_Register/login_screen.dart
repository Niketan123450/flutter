import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_application/common/helper/message/display_message.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/common/Widgets/custom_button.dart';

import 'package:movie_search_application/view/Login_Register/Widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginRegisterBloc bloc = LoginRegisterBloc();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
        bloc: bloc,
        listenWhen: (current, previous) => current is LoginRegisterActionState,
        buildWhen: (current, previous) => current is! LoginRegisterActionState,
        listener: (context, state) {
          ///NAVIGATE TO HOMESCREEN
          if (state is LoginWithDataState) {
            context.replace('/navbar');
          }
          ///NAVIGATE TO REGISTERSCREEN
          else if (state is RegisterNavigateState) {
            context.push('/register');
          } else if (state is LoginRegisterWithDataErrorState) {
            DisplayMessage.showMessage(message: state.error, context: context);
          } else if (state is LoginRegisterWithDataSuccessState) {
            DisplayMessage.showMessage(
              message: state.successMessage,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // color: const Color.fromARGB(160, 0, 0, 0),
                    child: Image.asset(
                      "assets/images/splash.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(160, 0, 0, 0),
                    // child: Image.asset("assets/images/splash.jpg", fit: BoxFit.cover),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: screenHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 24,
                      right: 24,
                      left: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.06),
                          width: screenWidth,
                          height: screenHeight * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.05,
                            ),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextfield(
                                  title: "Email",
                                  bloc: bloc,
                                  textcontroller: bloc.emailController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextfield(
                                  title: "Password",
                                  bloc: bloc,
                                  textcontroller: bloc.passwordController,
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: bloc.isChecked,
                                    splashRadius: 8,
                                    checkColor: AppColors.primary,
                                    // activeColor: AppColors.primary,
                                    fillColor: WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                    onChanged: (val) {
                                      bloc.add(
                                        CheckboxSelectionEvent(isChecked: val!),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Remember Me",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  ///ADDING LoginWithDataButtonNavigateEvent TO LOGINREGISTERBLOC

                                  bloc.add(
                                    LoginWithDataEvent(
                                      userCredential: {
                                        // "email": "niketangadade88@gmail.com",
                                        // "password": "Niketan@123",
                                        "email": bloc.emailController.text,
                                        "password":
                                            bloc.passwordController.text,
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  child: const CustomButton(title: "Login"),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ///ADDING RegisterButtonNavigateEvent TO LOGINREGISTERBLOC
                                  bloc.add(RegisterNavigateEvent());
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "Create one",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
