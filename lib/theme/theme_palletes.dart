import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Themes {
  ///Amber , Violent Color Theme
  List themesList = [
    ///Default Theme///
    ThemeData(
      colorSchemeSeed: Color.fromRGBO(196, 223, 223, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(227, 244, 244, 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(196, 223, 223, 1),
      ),
      popupMenuTheme: PopupMenuThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color.fromRGBO(227, 244, 244, 1),
          shadowColor: Colors.transparent,
          elevation: 5,
          textStyle: const TextStyle(color: Colors.black)),
      switchTheme: SwitchThemeData(
          trackColor:
              MaterialStateProperty.all(const Color.fromRGBO(210, 233, 233, 1))),
      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(210, 233, 233, 1),
        subtitleTextStyle:
            GoogleFonts.poppins(color: Colors.black54, fontSize: 16.sp),
      ),
      iconButtonTheme: IconButtonThemeData(
          style:
              ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),
      useMaterial3: true,
    ),

    ///-----2------///
    ThemeData(
      colorSchemeSeed: Colors.purpleAccent.shade100,
      scaffoldBackgroundColor: const Color.fromRGBO(77, 76, 125, 1),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 19.sp),
        backgroundColor: const Color.fromRGBO(54, 48, 98, 1),
      ),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      popupMenuTheme: PopupMenuThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color.fromRGBO(249, 148, 23, 1),
          shadowColor: Colors.transparent,
          elevation: 5,
          textStyle: const TextStyle(color: Colors.black)),
      hintColor: Colors.white54,

      switchTheme: SwitchThemeData(
          thumbColor:
              MaterialStateProperty.all(const Color.fromRGBO(249, 148, 23, 1))),
      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(249, 148, 23, 1),
        subtitleTextStyle:
            GoogleFonts.poppins(color: Colors.black54, fontSize: 16.sp),
      ),
      iconButtonTheme: IconButtonThemeData(
          style:
              ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),
      useMaterial3: true,
    ),

    ///-----3------///
    ThemeData(
      colorSchemeSeed: Color.fromRGBO(242, 190, 209, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(248, 232, 238, 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(242, 190, 209, 1),
      ),
      popupMenuTheme: PopupMenuThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color.fromRGBO(253, 206, 223, 1),
          shadowColor: Colors.transparent,
          elevation: 5,
          textStyle: const TextStyle(color: Colors.black)),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.black38),
          trackColor:
              MaterialStateProperty.all(const Color.fromRGBO(253, 206, 223, 1))),
      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(253, 206, 223, 1),
        subtitleTextStyle:
            GoogleFonts.poppins(color: Colors.black54, fontSize: 16.sp),
      ),
      iconButtonTheme: IconButtonThemeData(
          style:
              ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),
      useMaterial3: true,
    ),

    ///-----DarkMode-------///
    ThemeData.dark(
      useMaterial3: true,
    ),



    ///Muted Sea Urchin Color Palette
    ThemeData(
      colorSchemeSeed: Colors.purpleAccent,
      scaffoldBackgroundColor: const Color.fromRGBO(226,200,238, 1),
      appBarTheme:  AppBarTheme(
        backgroundColor: const Color.fromRGBO(170,126,190, 1),
      ),
      popupMenuTheme: PopupMenuThemeData(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color.fromRGBO(226,200,238, 1),
          shadowColor: Colors.transparent,
          elevation: 5,
          textStyle: const TextStyle(color: Colors.black)),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.black38),
          trackColor:
          MaterialStateProperty.all(const Color.fromRGBO(253, 206, 223, 1))),
      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO	(186,148,204, 1),
        subtitleTextStyle:
        GoogleFonts.poppins(color: Colors.black54, fontSize: 16.sp),
      ),
      iconButtonTheme: IconButtonThemeData(
          style:
          ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),
      useMaterial3: true,
    ),
  ];
}
