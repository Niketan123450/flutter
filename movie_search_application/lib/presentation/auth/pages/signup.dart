import 'package:flutter/material.dart';

import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/data/auth/models/signup_req_params.dart';
import 'package:movie_search_application/data/auth/repositories/auth.dart';
import 'package:movie_search_application/data/auth/sources/auth_api_service.dart';
import 'package:movie_search_application/domain/auth/usecases/signup.dart';
import 'package:movie_search_application/utils/service_locator.dart';

import 'package:reactive_button/reactive_button.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signupText(),
            SizedBox(height: 30),
            emailField(),
            SizedBox(height: 30),
            passwordField(),
            SizedBox(height: 30),
            signupButton(),
          ],
        ),
      ),
    );
  }

  Widget signupText() {
    return Text(
      'sign Up',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget emailField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(hintText: 'Email'),
    );
  }

  Widget passwordField() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(hintText: 'Password'),
    );
  }

  Widget signupButton() {
    return ReactiveButton(
      title: 'Sign Up',
      activeColor: AppColors.primary,
      onPressed: () async {
        await sl<SignupUseCase>().call(
          params: SignupReqParams(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
      },
      onSuccess: () {},
      onFailure: (error) {},
    );
  }
}
