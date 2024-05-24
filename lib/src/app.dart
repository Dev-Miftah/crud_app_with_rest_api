import 'package:crud_app_with_rest_api_assignment13/src/constant/colors.dart';
import 'package:crud_app_with_rest_api_assignment13/src/views/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_data/appbar_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud app with REST API',
      theme: ThemeData(
        appBarTheme: appBarTheme(),
          textTheme: GoogleFonts.notoSerifTextTheme(Theme.of(context).textTheme)
      ),
      home: const ProductListScreen(),
    );
  }


}