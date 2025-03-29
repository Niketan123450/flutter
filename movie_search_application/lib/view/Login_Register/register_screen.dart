import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/view/Widgets/custom_button.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_dropdown.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_radiobutton.dart';
import 'package:movie_search_application/view/Widgets/custom_snackbar.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_textfield.dart';
import 'package:movie_search_application/view/Login_Register/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginRegisterBloc bloc = LoginRegisterBloc();

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
        bloc: bloc,
        listenWhen: (current, previous) => current is LoginRegisterActionState,
        buildWhen: (current, previous) => current is! LoginRegisterActionState,
        listener: (context, state) {
          /// Go to Login Screen
          if (state is LoginNavigateState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is LoginRegisterWithDataErrorState) {
            CustomSnackbar.customSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 12,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 24,
                            color: const Color.fromRGBO(18, 18, 18, 1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(18, 18, 18, 1),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Create account",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    CustomTextfield(
                      title: "Name",
                      bloc: bloc,
                      textcontroller: bloc.usernameController,
                    ),
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

                    /// Dropdown for Language Selection
                    CustomDropdown(
                      title: "Language",
                      items: const [
                        "",
                        "English",
                        "Spanish",
                        "French",
                        "German",
                      ],
                      bloc: bloc,
                    ),

                    /// Radio Buttons for Gender Selection
                    CustomRadioButton(title: "Gender", bloc: bloc),

                    /// Register Button
                    GestureDetector(
                      onTap: () {
                        ///ADDING RegisterWithDataButtonNavigateEvent TO LOGINREGISTERBLOC
                        bloc.add(
                          OnRegisterWithDataEvent(
                            userCredential: {
                              "email": bloc.emailController.text,
                              "password": bloc.passwordController.text,
                              "username": bloc.usernameController.text,
                              "lang": bloc.selectedDropdownValue,
                              "gender": bloc.selectedGender,
                            },
                          ),
                        );
                      },
                      child: const CustomButton(title: "Register"),
                    ),

                    /// Login Redirection
                    GestureDetector(
                      onTap: () {
                        ///ADDING LoginButtonNavigateEvent TO LOGINREGISTERBLOC
                        bloc.add(OnLoginNavigateEvent());
                      },
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account?",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(74, 138, 196, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/google.png",
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          "assets/icons/google.png",
                          height: 16,
                          width: 16,
                        ),
                      ],
                    ),

                    /// Terms and Privacy Policy
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "By clicking Register, you agree to our",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Terms and Privacy Policy.",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(74, 138, 196, 1),
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
        },
      ),
    );
  }
}
