import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/view/Widgets/custom_button.dart';
import 'package:movie_search_application/view/Widgets/custom_snackbar.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_textfield.dart';
import 'package:movie_search_application/navbar_screen.dart';
import 'package:movie_search_application/view/Login_Register/register_screen.dart';

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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NavbarScreen()),
            );
          }
          ///NAVIGATE TO REGISTERSCREEN
          else if (state is RegisterNavigateState) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          } else if (state is LoginRegisterWithDataErrorState) {
            CustomSnackbar.customSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: Column(
                        children: [
                          CustomTextfield(
                            title: "Email",
                            bloc: bloc,
                            textcontroller: bloc.emailController,
                          ),
                          CustomTextfield(
                            title: "Password",
                            bloc: bloc,
                            textcontroller: bloc.passwordController,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: bloc.isChecked,
                                splashRadius: 8,
                                activeColor: const Color.fromRGBO(
                                  74,
                                  138,
                                  196,
                                  1,
                                ),
                                onChanged: (val) {
                                  bloc.add(
                                    OnCheckboxSelectionEvent(isChecked: val!),
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
                                  color: const Color.fromRGBO(74, 138, 196, 1),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              ///ADDING LoginWithDataButtonNavigateEvent TO LOGINREGISTERBLOC

                              bloc.add(
                                OnLoginWithDataEvent(
                                  userCredential: {
                                    "email": "niketangadade88@gmail.com",
                                    "password": "Niketan@123",
                                    // "email": bloc.emailController.text,
                                    // "password": bloc.passwordController.text,
                                  },
                                ),
                              );
                            },
                            child: const CustomButton(title: "Login"),
                          ),
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ///ADDING RegisterButtonNavigateEvent TO LOGINREGISTERBLOC
                              bloc.add(OnRegisterNavigateEvent());
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
          );
        },
      ),
    );
  }
}
