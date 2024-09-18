import 'package:google_fonts/google_fonts.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

// String _fontFamily = 'Lato';
TextTheme? textTheme = GoogleFonts.latoTextTheme();
TextTheme? darkTextTheme = GoogleFonts.latoTextTheme().copyWith(
  bodyMedium:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  bodyLarge:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  bodySmall:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  titleLarge:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  titleMedium:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  titleSmall:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  labelLarge:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  labelMedium:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
  labelSmall:
      GoogleFonts.lato(textStyle: const TextStyle(color: Palette.primaryLight)),
);

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Palette.backgroundLight,
      primary: Palette.primaryLight,
      secondary: Palette.secondaryLight,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.secondaryDark,
      selectionHandleColor: Palette.primaryAccent,
      selectionColor: Palette.primaryAccent,
    ),
    scaffoldBackgroundColor: Palette.backgroundLight,

    // appBarTheme: const AppBarTheme(
    //   color: Palette.primaryLight,
    // ),
    // bottomAppBarTheme: const BottomAppBarTheme(
    //   color: Palette.primaryLight,
    // ),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: Palette.secondaryLight,
    // ),
    // iconTheme: IconThemeData(color: Palette.textLight),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.secondaryAccent),
    // fontFamily: _fontFamily,
    textTheme: textTheme);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Palette.backgroundDark,
      primary: Palette.primaryDark,
      secondary: Palette.secondaryDark,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.secondaryLight,
      selectionHandleColor: Palette.primaryAccent,
      selectionColor: Palette.primaryAccent,
    ),
    // appBarTheme: const AppBarTheme(
    //   color: Palette.primaryDark,
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Palette.primaryDark,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Palette.backgroundDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryAccent),
    //  fontFamily: _fontFamily,
    textTheme: darkTextTheme);


//   useMaterial3: true,
//   brightness: Brightness.light,
//   primaryColor: Palette.primary,
//   primaryColorDark: Palette.primaryDark,
//   appBarTheme: AppBarTheme(
//     color: Palette.primary,
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     cursorColor: Palette.primaryDark,
//     selectionHandleColor: Palette.primaryDark,
//     selectionColor: Palette.primaryDark,
//   ),
//   focusColor: Palette.primaryDark,
//   inputDecorationTheme: InputDecorationTheme(
//     focusColor: Palette.primaryDark,
//     hoverColor: Palette.primaryDark,
//     floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
//       if (states.contains(MaterialState.error)) {
//         return const TextStyle(
//           color: Colors.red,
//         );
//       } else {
//         return const TextStyle(
//           color: Palette.primaryDark,
//         );
//       }
//     }),
//     focusedBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Palette.primaryDark,
//         width: 2.0,
//       ),
//     ),
//   ),
//   scaffoldBackgroundColor: Palette.primary,
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: Palette.primaryDark,
//       textStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
//   fontFamily: _fontFamily,
// );

// ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   primaryColor: Palette.primaryDark,
//   primaryColorDark: Palette.accentDark,
//   appBarTheme: const AppBarTheme(
//     color: Palette.primaryDark,
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     cursorColor: Palette.primary,
//     selectionHandleColor: Palette.primary,
//     selectionColor: Palette.primary,
//   ),
//   focusColor: Palette.primary,
//   inputDecorationTheme: InputDecorationTheme(
//     focusColor: Palette.primary,
//     hoverColor: Palette.primary,
//     floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
//       if (states.contains(MaterialState.error)) {
//         return const TextStyle(
//           color: Colors.red,
//         );
//       } else {
//         return const TextStyle(
//           color: Palette.primary,
//         );
//       }
//     }),
//     focusedBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Palette.primary,
//         width: 2.0,
//       ),
//     ),
//   ),
//   scaffoldBackgroundColor: Palette.primaryDark,
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: Palette.primary,
//       textStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
//   fontFamily: _fontFamily,
// );
