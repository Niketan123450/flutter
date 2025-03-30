import 'package:flutter/material.dart';
import 'package:movie_search_application/controller/firebase/firebase_data.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/view/Login_Register/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: IconButton(
          onPressed: () {
            FirebaseData.logoutFromFirebase();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.logout_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
