import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors you already had
  static const Color backgroundDark = Color(0xFF03020C);
  static const Color accentColor     = Color(0xFFFFD700);
  static const Color textOnDark      = Colors.white;

  // Optional explicit text styles that you can use in widgets
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textOnDark,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textOnDark,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 16,
    color: textOnDark,
  );

  /// ---- THEME DATA ----

  // Material 3 ColorSchemes derived from your seed color
  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light);

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.dark);

  /// Light theme (for users who prefer light or when you toggle to light)
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    fontFamily: 'Sansation',
    scaffoldBackgroundColor: _lightScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScheme.surface,
      foregroundColor: _lightScheme.onSurface,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontFamily: 'Sansation',
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ).copyWith(color: _lightScheme.onSurface),
      iconTheme: IconThemeData(color: _lightScheme.onSurface),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Dark theme (your current default look)
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    fontFamily: 'Sansation',
    scaffoldBackgroundColor: backgroundDark, // keep your deep background
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      iconTheme: IconThemeData(color: textOnDark),
      titleTextStyle: TextStyle(
        fontFamily: 'Sansation',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textOnDark,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}


// import 'package:flutter/material.dart';

// class AppTheme {
//   // Brand
//   static const Color backgroundDark = Color(0xFF0E0D12); // slightly lighter than 0xFF03020C for better contrast
//   static const Color accentColor     = Color(0xFFFFD700);
//   static const Color textOnDark      = Colors.white;

//   // Optional text styles
//   static const TextStyle heading1 = TextStyle(
//     fontFamily: 'Sansation', fontSize: 28, fontWeight: FontWeight.bold, color: textOnDark,
//   );

//   static const TextStyle heading2 = TextStyle(
//     fontFamily: 'Sansation', fontSize: 22, fontWeight: FontWeight.w600, color: textOnDark,
//   );

//   static const TextStyle bodyText = TextStyle(
//     fontFamily: 'Sansation', fontSize: 16, color: textOnDark,
//   );

//   /// --- BASE COLOR ROLES WE CONTROL EXPLICITLY ---
//   // Light
//   static const _lightScaffold = Color(0xFFF7F0E3);
//   static const _lightCard     = Color(0xFFE6E1D7); // visible against scaffold
//   static const _lightPanel    = Color(0xFFEBE6DC);
//   static const _lightOutline  = Color(0xFFBDB5A6);
//   static const _lightOutlineV = Color(0xFFD8D1C4);

//   // Dark
//   static const _darkScaffold = backgroundDark;
//   static const _darkCard     = Color(0xFF2B2A2F); // visible against scaffold
//   static const _darkPanel    = Color(0xFF232227);
//   static const _darkOutline  = Color(0xFF4B4B52);
//   static const _darkOutlineV = Color(0xFF3A3A40);

//   /// Material 3 ColorSchemes from seed, then hardened with our roles.
//   static ColorScheme _hardenLight(ColorScheme cs) => cs.copyWith(
//         surface: _lightPanel,
//         surfaceContainerHigh: _lightPanel,
//         surfaceContainerHighest: _lightCard,
//         outline: _lightOutline,
//         outlineVariant: _lightOutlineV,
//         primary: accentColor,
//         secondary: accentColor,
//       );

//   static ColorScheme _hardenDark(ColorScheme cs) => cs.copyWith(
//         surface: _darkPanel,
//         surfaceContainerHigh: _darkPanel,
//         surfaceContainerHighest: _darkCard,
//         outline: _darkOutline,
//         outlineVariant: _darkOutlineV,
//         primary: accentColor,
//         secondary: accentColor,
//         onSurface: Colors.white,
//         onSurfaceVariant: const Color(0xFFBFBCC7),
//       );

//   static final ColorScheme _lightScheme = _hardenLight(
//     ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light),
//   );

//   static final ColorScheme _darkScheme = _hardenDark(
//     ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.dark),
//   );

//   /// Light theme
//   static final ThemeData light = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: _lightScheme,
//     fontFamily: 'Sansation',
//     scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
//     appBarTheme: AppBarTheme(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       foregroundColor: _lightScheme.onSurface,
//       elevation: 0,
//       titleTextStyle: const TextStyle(
//         fontFamily: 'Sansation', fontSize: 20, fontWeight: FontWeight.w600,
//       ).copyWith(color: _lightScheme.onSurface),
//       iconTheme: IconThemeData(color: _lightScheme.onSurface),
//     ),
//     cardColor: const Color.fromARGB(255, 244, 244, 243),
//     cardTheme: const CardTheme(color: _lightCard),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: _lightPanel,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _lightOutline),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _lightOutlineV),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: accentColor, width: 1.4),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _lightOutline),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//   );

//   /// Dark theme
//   static final ThemeData dark = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: _darkScheme,
//     fontFamily: 'Sansation',
//     scaffoldBackgroundColor: _darkScaffold,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: _darkScaffold,
//       elevation: 0,
//       iconTheme: IconThemeData(color: textOnDark),
//       titleTextStyle: TextStyle(
//         fontFamily: 'Sansation', fontSize: 20, fontWeight: FontWeight.w600, color: textOnDark,
//       ),
//     ),
//     cardColor: _darkCard,
//     cardTheme: const CardTheme(color: _darkCard),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: _darkPanel,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _darkOutline),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _darkOutlineV),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: accentColor, width: 1.4),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: _darkOutline),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//   );
// }
