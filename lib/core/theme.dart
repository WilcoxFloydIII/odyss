import 'package:flutter/material.dart';
import 'package:odyss/core/colors.dart';

class AppTheme {
  static const Color _primaryBlack = Color(0xFF000000);
  static const Color _darkText = Color(0xFF000000);
  static const Color _lightText = Color(0xFFFFFFFF);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _darkBackground = Color(0xFF000000);
  static const Color _primaryPink = Color(0xFFF5008B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primaryBlack,
    scaffoldBackgroundColor: _lightBackground,
    cardColor: _lightText,
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightBackground,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      foregroundColor: _darkText,
    ),
    colorScheme: ColorScheme.light(
      primary: _primaryBlack,
      secondary: _primaryBlack,
    ),
    iconTheme: const IconThemeData(color: _darkText),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(_darkText),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryPink;
          }
          return _lightText;
        }),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _darkBackground;
          }
          return _darkBackground;
        }),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(35),
          ),
        ),
        alignment: Alignment.center,
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15, horizontal: 20))
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryPink;
          }
          return _darkText;
        }),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: _darkText, fontWeight: FontWeight.bold)),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppTheme._darkText,
      shape: null,
    ),
    fontFamily: 'Montserrat',
    extensions: <ThemeExtension<dynamic>>[
      MyColors(primary: Color(0xFF000000), backgound: Color(0xFFFFFFFF))
    ]
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _primaryBlack,
    scaffoldBackgroundColor: _darkBackground,
    cardColor: _darkText,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkBackground,
      foregroundColor: _lightText,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: _primaryBlack,
      secondary: _primaryBlack,
    ),
    iconTheme: const IconThemeData(color: _lightText),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(_lightText),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryPink;
          }
          return _darkText;
        }),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _lightBackground;
          }
          return _lightBackground;
        }),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(26))),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return _primaryPink;
          }
          return _lightText;
        }),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: _lightText)),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppTheme._lightBackground,
      shape: null,
    ),
    fontFamily: 'Montserrat',
    extensions: <ThemeExtension<dynamic>>[
      MyColors(primary: Color(0xFFFFFFFF), backgound: Color(0xFF000000))
    ]
  );
}
