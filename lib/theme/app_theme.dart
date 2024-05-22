import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.rhinoDark800,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.rhinoDark800,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
    textTheme: TextTheme(
      bodyText2: GoogleFonts.manrope(color: Colors.white, fontSize: 16),
    ),
  );
}
