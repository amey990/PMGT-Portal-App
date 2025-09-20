// import 'package:flutter/material.dart';
// import 'core/theme.dart';
// import 'ui/screens/Auth/splash_screen.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PMGT App',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.theme,
//       home: const SplashScreen(),  // start here
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'core/theme.dart';
// import 'core/theme_controller.dart'; // <-- new (we’ll add this file next)
// import 'ui/screens/Auth/splash_screen.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // Theme controller lives at the top so any page can toggle later
//   final ThemeController _themeController =
//       ThemeController(initialMode: ThemeMode.system);

//   @override
//   Widget build(BuildContext context) {
//     return ThemeScope(
//       controller: _themeController,
//       child: AnimatedBuilder(
//         animation: _themeController,
//         builder: (context, _) {
//           return MaterialApp(
//             title: 'PMGT App',
//             debugShowCheckedModeBanner: false,
//             theme: AppTheme.light,        // Light look
//             darkTheme: AppTheme.dark,     // Dark look
//             themeMode: _themeController.mode, // Which one to use
//             // Clamp extreme accessibility scales a bit to protect layout
//             builder: (context, child) {
//               final media = MediaQuery.of(context);
//               final clamped = media.textScaler
//                   .clamp(minScaleFactor: 0.9, maxScaleFactor: 1.2);
//               return MediaQuery(
//                 data: media.copyWith(textScaler: clamped),
//                 child: child ?? const SizedBox.shrink(),
//               );
//             },
//             home: const SplashScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'core/theme_controller.dart';
import 'ui/screens/Auth/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController(
    initialMode: ThemeMode.system,
  );

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, _) {
          return MaterialApp(
            title: 'PMGT App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: _themeController.mode,
            builder: (context, child) {
              final media = MediaQuery.of(context);
              final clamped = media.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.2,
              );
              return MediaQuery(
                data: media.copyWith(textScaler: clamped),
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
