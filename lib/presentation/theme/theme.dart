
import 'package:flutter/material.dart';

final myThemeLight = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF50A380),
      onPrimary: Color(0xFFBDE4BC),
      secondary: Color(0xFFDE8B1D),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFD61E1E),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFfcfcfc),
      onSurface: Color(0xFF323332)
  ),
  textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      )
  ),
);

final myThemeDark = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFB1E6D0),
      onPrimary: Color(0xFF254C3C),
      secondary: Color(0xFFE6C08C),
      onSecondary: Color(0xFF4C300A),
      error: Color(0xFFE68D8D),
      onError: Color(0xFF4C0B0B),
      surface: Color(0xFF323332),
      onSurface: Color(0xFFe4e6e5)
  ),
  textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
      )
  ),
);
