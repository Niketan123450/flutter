import 'package:flutter/material.dart';

// class DisplayMessage {
//   static void errorMessage(String message, BuildContext context) {
//     var snackbar = SnackBar(
//       content: Text(message),
//       behavior: SnackBarBehavior.floating,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackbar);
//   }
// }
import 'package:flutter/material.dart';

class DisplayMessage {
  static void showMessage({
    required String message,
    required BuildContext context,
    bool isError = false,
    IconData? icon,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Define default icon and background based on the error status
    IconData defaultIcon =
        isError ? Icons.error_outline : Icons.check_circle_outline;
    Color defaultBackground = isError ? Colors.redAccent : Colors.green;

    // Create the SnackBar
    var snackbar = SnackBar(
      content: Row(
        children: [
          Icon(icon ?? defaultIcon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
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
