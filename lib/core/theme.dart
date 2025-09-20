// import 'package:flutter/material.dart';

// class AppTheme {
//   // Brand colors you already had
//   static const Color backgroundDark = Color(0xFF03020C);
//   static const Color accentColor     = Color(0xFFFFD700);
//   static const Color textOnDark      = Colors.white;

//   // Optional explicit text styles that you can use in widgets
//   static const TextStyle heading1 = TextStyle(
//     fontFamily: 'Sansation',
//     fontSize: 28,
//     fontWeight: FontWeight.bold,
//     color: textOnDark,
//   );

//   static const TextStyle heading2 = TextStyle(
//     fontFamily: 'Sansation',
//     fontSize: 22,
//     fontWeight: FontWeight.w600,
//     color: textOnDark,
//   );

//   static const TextStyle bodyText = TextStyle(
//     fontFamily: 'Sansation',
//     fontSize: 16,
//     color: textOnDark,
//   );

//   /// ---- THEME DATA ----

//   // Material 3 ColorSchemes derived from your seed color
//   static final ColorScheme _lightScheme =
//       ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light);

//   static final ColorScheme _darkScheme =
//       ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.dark);

//   /// Light theme (for users who prefer light or when you toggle to light)
//   static final ThemeData light = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: _lightScheme,
//     fontFamily: 'Sansation',
//     scaffoldBackgroundColor: _lightScheme.surface,
//     appBarTheme: AppBarTheme(
//       backgroundColor: _lightScheme.surface,
//       foregroundColor: _lightScheme.onSurface,
//       elevation: 0,
//       titleTextStyle: const TextStyle(
//         fontFamily: 'Sansation',
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ).copyWith(color: _lightScheme.onSurface),
//       iconTheme: IconThemeData(color: _lightScheme.onSurface),
//     ),
//     inputDecorationTheme: const InputDecorationTheme(
//       border: OutlineInputBorder(),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//   );

//   /// Dark theme (your current default look)
//   static final ThemeData dark = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: _darkScheme,
//     fontFamily: 'Sansation',
//     scaffoldBackgroundColor: backgroundDark, // keep your deep background
//     appBarTheme: const AppBarTheme(
//       backgroundColor: backgroundDark,
//       elevation: 0,
//       iconTheme: IconThemeData(color: textOnDark),
//       titleTextStyle: TextStyle(
//         fontFamily: 'Sansation',
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//         color: textOnDark,
//       ),
//     ),
//     inputDecorationTheme: const InputDecorationTheme(
//       border: OutlineInputBorder(),
//     ),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//   );
// }

import 'package:flutter/material.dart';

class AppTheme {
  // Brand
  static const Color accentColor = Color(0xFFFFD700);
  static const Color backgroundDark = Color(0xFF03020C);

  // Optional text styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 16,
    color: Colors.white,
  );

  // ---------- Light roles (white page, sheet-like cards) ----------
  // Page is pure white; cards & filled fields are a soft neutral so they “lift”
  static const Color _lightScaffold = Colors.white;
  static const Color _lightCard = Color(
    0xFFF7F7F7,
  ); // card/surfaceContainerHighest
  static const Color _lightPanel = Color(0xFFFAFAFA); // filled inputs
  static const Color _lightOutline = Color(0xFFE3E3E3);
  static const Color _lightOutlineV = Color(0xFFEAEAEA);

  // ---------- Dark roles ----------
  static const Color _darkScaffold = backgroundDark;
  static const Color _darkCard = Color(0xFF1E1E22);
  static const Color _darkPanel = Color(0xFF151519);
  static const Color _darkOutline = Color(0xFF3C3C43);
  static const Color _darkOutlineV = Color(0xFF2D2D33);

  static ColorScheme _hardenLight(ColorScheme cs) => cs.copyWith(
    surface: _lightPanel,
    surfaceContainerHigh: _lightPanel,
    surfaceContainerHighest: _lightCard,
    outline: _lightOutline,
    outlineVariant: _lightOutlineV,
    primary: accentColor,
    secondary: accentColor,
    onSurface: const Color(0xFF101010),
    onSurfaceVariant: const Color(0xFF6A6A6A),
  );

  static ColorScheme _hardenDark(ColorScheme cs) => cs.copyWith(
    surface: _darkPanel,
    surfaceContainerHigh: _darkPanel,
    surfaceContainerHighest: _darkCard,
    outline: _darkOutline,
    outlineVariant: _darkOutlineV,
    primary: accentColor,
    secondary: accentColor,
    onSurface: Colors.white,
    onSurfaceVariant: const Color(0xFFBEBEC6),
  );

  static final ColorScheme _lightScheme = _hardenLight(
    ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.light),
  );

  static final ColorScheme _darkScheme = _hardenDark(
    ColorScheme.fromSeed(seedColor: accentColor, brightness: Brightness.dark),
  );

  // ----------------------- Light theme -----------------------
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    fontFamily: 'Sansation',
    scaffoldBackgroundColor: _lightScaffold, // 👈 true white page
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScaffold,
      foregroundColor: _lightScheme.onSurface,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontFamily: 'Sansation',
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ).copyWith(color: _lightScheme.onSurface),
      iconTheme: IconThemeData(color: _lightScheme.onSurface),
    ),
    cardColor: _lightCard, // 👈 near-white card
    cardTheme: const CardThemeData(
      color: _lightCard,
      surfaceTintColor: Colors.transparent, // no M3 gray tint
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightPanel, // 👈 subtle fill for textfields
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _lightOutline),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _lightOutlineV),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accentColor, width: 1.4),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _lightOutline),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerColor: _lightOutlineV,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // ----------------------- Dark theme -----------------------
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    fontFamily: 'Sansation',
    scaffoldBackgroundColor: _darkScaffold,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkScaffold,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'Sansation',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardColor: _darkCard,
    cardTheme: const CardThemeData(
      color: _darkCard,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkPanel,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkOutline),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkOutlineV),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accentColor, width: 1.4),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkOutline),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    dividerColor: _darkOutlineV,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
