import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class AppText {
  static TextStyle primaryTitle = GoogleFonts.montserrat(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
  static TextStyle secondaryTitle = GoogleFonts.montserrat(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
  static TextStyle primaryDescription = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle secondaryDescription = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle description = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle smallText = GoogleFonts.montserrat(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
