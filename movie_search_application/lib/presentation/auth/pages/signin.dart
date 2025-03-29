import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/core/configs/assets/app_images.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/presentation/auth/pages/signup.dart';
import 'package:reactive_button/reactive_button.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(152, 0, 0, 0),
            ),
            Column(
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
                SizedBox(height: 30),
                signupText(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget signinText() {
  return Text(
    'sign In',
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
    title: 'Sign In',
    activeColor: AppColors.primary,
    onPressed: () async {},
    onSuccess: () {},
    onFailure: (error) {},
  );
}

Widget signupText(BuildContext context) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(text: "Don't you have account?"),
        TextSpan(
          text: 'Sign Up',
          style: TextStyle(color: Colors.blue),
          recognizer:
              TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.push(context, SignupPage());
                },
        ),
      ],
    ),
  );
}
