import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // Background Color
      scaffoldBackgroundColor: const Color(0xFFFFFFF7),

      // fonts
      fontFamily: 'IM_Fell_DW_Pica',

      // for buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFFFF7),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'IM_FELL_Great_Primer'),
              backgroundColor: const Color.fromARGB(255, 27, 29, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ))),
      // for appbars
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color(0xFFFFFFF7),
          // elevation: 2,
          // shadowColor: Colors.black,
          titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)));
}
