import 'package:flutter/material.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(
            color: Colors.white54,
          ), // Optional for hint color
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.primary),
            onPressed: () {
              // Add your notification logic here
            },
          ),
          filled: true,
          fillColor: Colors.black, // Background color of the text field
          // Add borders for different states
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.primary, // Border when not focused
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.primary, // Border when focused
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red, // Border when there's an error
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.red, // Border when focused and error
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
