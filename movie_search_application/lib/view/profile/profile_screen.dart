import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_application/core/services/firebase_data.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

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

            context.push('/login');
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
