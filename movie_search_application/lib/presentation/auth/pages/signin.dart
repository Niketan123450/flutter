import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

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
