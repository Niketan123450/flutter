import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/common/helper/message/display_message.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/common/Widgets/custom_button.dart';
import 'package:movie_search_application/core/service_locator.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_dropdown.dart';
import 'package:movie_search_application/view/Login_Register/Widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginRegisterBloc bloc = getIt<LoginRegisterBloc>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
        bloc: bloc,
        listenWhen: (current, previous) => current is LoginRegisterActionState,
        buildWhen: (current, previous) => current is! LoginRegisterActionState,
        listener: (context, state) {
          /// Go to Login Screen
          if (state is LoginNavigateState) {
            context.go('/login');
          } else if (state is LoginRegisterWithDataErrorState) {
            DisplayMessage.showMessage(message: state.error, context: context);
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
                  height: MediaQuery.sizeOf(context).height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 12,
                      right: 24,
                      left: 24,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.14,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Create Account",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextfield(
                                title: "Name",
                                bloc: bloc,
                                textcontroller: bloc.usernameController,
                              ),
                            ),
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

                            /// Dropdown for Language Selection
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDropdown(
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
                            ),

                            SizedBox(height: 20),

                            /// Register Button
                            GestureDetector(
                              onTap: () {
                                ///ADDING RegisterWithDataButtonNavigateEvent TO LOGINREGISTERBLOC
                                bloc.add(
                                  RegisterWithDataEvent(
                                    userCredential: {
                                      "email": bloc.emailController.text,
                                      "password": bloc.passwordController.text,
                                      "username": bloc.usernameController.text,
                                      "lang": bloc.selectedDropdownValue,
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.14,
                                ),
                                child: const CustomButton(title: "Register"),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            /// Login Redirection
                            GestureDetector(
                              onTap: () {
                                ///ADDING LoginButtonNavigateEvent TO LOGINREGISTERBLOC
                                bloc.add(LoginNavigateEvent());
                              },
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already Have account?",
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
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/google.png",
                                  fit: BoxFit.cover,
                                  height: screenHeight * 0.04,
                                  width: screenHeight * 0.04,
                                ),
                                const SizedBox(width: 20),
                                Image.asset(
                                  "assets/icons/facebook.png",
                                  height: screenHeight * 0.04,
                                  width: screenHeight * 0.04,
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),

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
                                      color: const Color.fromRGBO(
                                        74,
                                        138,
                                        196,
                                        1,
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
