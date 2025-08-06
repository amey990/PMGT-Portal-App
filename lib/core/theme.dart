// import 'package:flutter/material.dart';

// class AppTheme {
//   // Colors
//   static const Color backgroundColor = Color(0xFF03020C);
//   static const Color accentColor = Color(0xFFFFD700); // Yellow from logo
//   static const Color textColor = Colors.white;

//   // Text Styles
//   static const TextStyle heading1 = TextStyle(
//     fontSize: 28,
//     fontWeight: FontWeight.bold,
//     color: textColor,
//   );

//   static const TextStyle heading2 = TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.w600,
//     color: textColor,
//   );

//   static const TextStyle bodyText = TextStyle(
//     fontSize: 16,
//     color: textColor,
//   );

//   // ThemeData
//   static ThemeData get theme {
//     return ThemeData(
//       brightness: Brightness.dark,
//       primaryColor: backgroundColor,
//       scaffoldBackgroundColor: backgroundColor,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         iconTheme: IconThemeData(color: textColor),
//         titleTextStyle: TextStyle(
//           color: textColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: accentColor,
//         brightness: Brightness.dark,
//       ),
//       useMaterial3: true,
//       fontFamily: 'Poppins', // optional custom font
//     );
//   }
// }


import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color backgroundColor = Color(0xFF03020C);
  static const Color accentColor     = Color(0xFFFFD700);
  static const Color textColor       = Colors.white;

  // Explicit Text Styles (optional overrides)
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Sansation',
    fontSize: 16,
    color: textColor,
  );

  // ThemeData
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      // Apply Sansation globally:
      fontFamily: 'Sansation',

      primaryColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,

      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: Brightness.dark,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          fontFamily: 'Sansation',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
