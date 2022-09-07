import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static  TextTheme lightText =  TextTheme(
      headline1: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline3: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText2: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      subtitle1: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.black,
      ),
      subtitle2: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: Colors.black,
      ),
    );

  static ThemeData lightTheme(){
    return ThemeData(
      textTheme: lightText,
      brightness: Brightness.light,
      iconTheme: const IconThemeData(
        color: Colors.pink,
      ),
      appBarTheme:  AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        titleTextStyle: lightText.headline2,
        iconTheme: const IconThemeData(
          color: Colors.pink,
          size: 35,
        )
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          primary: Colors.pink,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
            )
          )
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        selectedIconTheme: IconThemeData(
          color: Colors.black,
          size: 50
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
          size: 50,
        )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20)
          )
        )
      )
    );
  }

  static  TextTheme darkText =  TextTheme(
      headline1: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

  static ThemeData darkTheme(){
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme:  AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 3,
        centerTitle: true,
        titleTextStyle: lightText.headline2,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 50,
        )
      ),
      cardTheme: const CardTheme(
        color: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
            )
          )
        )
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          color: Colors.black,
          size: 50
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
          size: 50,
        )
      )
    );
  }
}