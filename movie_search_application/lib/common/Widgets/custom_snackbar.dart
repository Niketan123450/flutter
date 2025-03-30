import 'package:flutter/material.dart';

class CustomSnackbar {
  static void customSnackba(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            fontFamily: "Roboto",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
