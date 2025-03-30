import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/view/Widgets/search_container.dart';
import 'package:movie_search_application/view/search/search_screen.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.black,
      child: GestureDetector(
        onTap: () {
          AppNavigator.push(context, SearchScreen());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  AppNavigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12),
              Text(
                "Details",
                style: GoogleFonts.montserrat(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  color: AppColors.primary,
                  weight: 23,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.watch_later,
                  color: AppColors.primary,
                  weight: 23,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: AppColors.primary,
                  weight: 23,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
