import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:movie_search_application/core/configs/theme/app_colors.dart';

import 'package:reactive_button/reactive_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signinText(),
            SizedBox(height: 30),
            emailField(),
            SizedBox(height: 30),
            passwordField(),
            SizedBox(height: 30),
            signinButton(),
          ],
        ),
      ),
    );
  }
}

Widget signinText() {
  return Text(
    'sign Up',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  );
}

Widget emailField() {
  return TextField(decoration: InputDecoration(hintText: 'Email'));
}

Widget passwordField() {
  return TextField(decoration: InputDecoration(hintText: 'Password'));
}

Widget signinButton() {
  return ReactiveButton(
    title: 'Sign Up',
    activeColor: AppColors.primary,
    onPressed: () async {},
    onSuccess: () {},
    onFailure: (error) {},
  );
}
