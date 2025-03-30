import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class DisplayMessage {
  static void showMessage({
    required String message,
    required BuildContext context,
    bool isError = false,
    IconData? icon,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    // Define default icon and background based on the error status
    IconData defaultIcon =
        isError ? Icons.error_outline : Icons.check_circle_outline;
    Color defaultBackground =
        isError ? Colors.redAccent : AppColors.secondBackground;

    // Create the SnackBar
    var snackbar = SnackBar(
      content: Row(
        children: [
          Icon(icon ?? defaultIcon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.montserrat(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? defaultBackground,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: duration,
      elevation: 6.0,
    );

    // Show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
