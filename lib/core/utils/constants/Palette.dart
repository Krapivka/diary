// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Palette {
  Palette._();

  //light theme
  static const Color backgroundLight = Color.fromARGB(255, 247, 247, 247);
  static const Color primaryLight = Color.fromARGB(255, 247, 247, 247);
  static const Color secondaryLight = Color.fromARGB(255, 151, 231, 225);
  static const Color textLight = Color.fromARGB(255, 53, 53, 53);

  //dark theme
  static const Color backgroundDark = Color.fromARGB(255, 14, 14, 14);
  static const Color primaryDark = Color.fromARGB(255, 46, 46, 46);
  static const Color secondaryDark = Color.fromARGB(255, 122, 162, 227);
  static const Color textDark = Color.fromARGB(255, 247, 247, 247);

  //accent
  static const Color primaryAccent = Color.fromARGB(255, 107, 99, 255);
  static const Color secondaryAccent = Color.fromARGB(255, 106, 212, 221);

  //calendar
  static const Color markerColor = Color.fromARGB(255, 144, 177, 230);

  static const Color successColor = Color.fromARGB(255, 58, 230, 149);
  static const Color unfinishedColor = Colors.redAccent;
}
