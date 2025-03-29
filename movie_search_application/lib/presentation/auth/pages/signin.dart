import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_application/common/helper/message/display_message.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/core/configs/assets/app_images.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/data/auth/models/signin_req_params.dart';
import 'package:movie_search_application/domain/auth/usecases/signin.dart';
import 'package:movie_search_application/presentation/auth/pages/signup.dart';
import 'package:movie_search_application/view/home/pages/home.dart';
import 'package:movie_search_application/utils/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                signinButton(context),
                SizedBox(height: 30),
                signupText(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget signinText() {
    return Text(
      'sign In',
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

  Widget signinButton(BuildContext context) {
    return ReactiveButton(
      title: 'Sign In',
      activeColor: AppColors.primary,
      onPressed: () async {
        sl<SigninUseCase>().call(
          params: SigninReqParams(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
        AppNavigator.pushAndRemove(context, HomePage());
      },
      onSuccess: () {
        AppNavigator.pushAndRemove(context, HomePage());
      },
      onFailure: (error) {
        DisplayMessage.errorMessage(error, context);
      },
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
}
