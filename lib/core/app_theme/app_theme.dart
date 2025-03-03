import 'package:flutter/material.dart';
import 'package:tryproject/app/constants/theme_constant.dart';

ThemeData getApplicationTheme({required bool isDarkMode}) {
  return ThemeData(
    colorScheme: isDarkMode
        ? const ColorScheme.dark(primary: ThemeConstant.darkPrimaryColor)
        : const ColorScheme.light(primary: ThemeConstant.lightPrimaryColor),
    scaffoldBackgroundColor: isDarkMode
        ? ThemeConstant.darkPrimaryColor
        : ThemeConstant.lightPrimaryColor,
    fontFamily: "IM_Fell_English_SC",
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: isDarkMode
          ? ThemeConstant.lightPrimaryColor
          : ThemeConstant.darkPrimaryColor,
      selectionColor: isDarkMode
          ? ThemeConstant.lightPrimaryColor.withOpacity(0.4)
          : ThemeConstant.darkPrimaryColor.withOpacity(0.4),
      selectionHandleColor: isDarkMode
          ? ThemeConstant.lightPrimaryColor
          : ThemeConstant.darkPrimaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "IM_FELL_Great_Primer"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      foregroundColor: isDarkMode
          ? ThemeConstant.darkPrimaryColor
          : ThemeConstant.lightPrimaryColor,
      backgroundColor: isDarkMode
          ? ThemeConstant.lightPrimaryColor
          : ThemeConstant.darkPrimaryColor,
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: isDarkMode
          ? ThemeConstant.darkPrimaryColor
          : ThemeConstant.lightPrimaryColor,
      selectedItemColor: isDarkMode
          ? ThemeConstant.lightPrimaryColor
          : ThemeConstant.darkPrimaryColor,
      unselectedItemColor: isDarkMode
          ? Colors.white.withOpacity(0.7)
          : Colors.black.withOpacity(0.7),
      selectedIconTheme: IconThemeData(
        size: 28, // Custom size for selected icons
        color: isDarkMode
            ? ThemeConstant.lightPrimaryColor
            : ThemeConstant.darkPrimaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        size: 24, // Custom size for unselected icons
        color: isDarkMode
            ? Colors.white.withOpacity(0.7)
            : Colors.black.withOpacity(0.7),
      ),
      elevation: 8.0,
      showUnselectedLabels: true, // Show unselected labels
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14, // Customize label size
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(
                color: isDarkMode
                    ? ThemeConstant.lightPrimaryColor
                    : ThemeConstant.darkPrimaryColor,
                width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(
                color: isDarkMode
                    ? ThemeConstant.lightPrimaryColor
                    : ThemeConstant.darkPrimaryColor,
                width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: Colors.red, width: 2))),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkMode
          ? ThemeConstant.darkPrimaryColor
          : ThemeConstant.lightPrimaryColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: isDarkMode
            ? ThemeConstant.lightPrimaryColor
            : ThemeConstant.darkPrimaryColor,
      ),
      actionsIconTheme: IconThemeData(
        color: isDarkMode
            ? ThemeConstant.lightPrimaryColor
            : ThemeConstant.darkPrimaryColor,
      ),
    ),
  );
}