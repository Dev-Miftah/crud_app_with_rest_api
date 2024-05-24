import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors.dart';

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    iconTheme: const IconThemeData(color: kPrimaryColor),
    titleTextStyle: GoogleFonts.notoSerif(textStyle: const TextStyle(color: kPrimaryColor, letterSpacing: 2, fontSize: 22)),

  );
}