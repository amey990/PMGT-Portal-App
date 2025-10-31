// import 'package:flutter/material.dart';
// import 'core/theme.dart';
// import 'core/theme_controller.dart';
// import 'ui/screens/Auth/splash_screen.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final ThemeController _themeController = ThemeController(
//     initialMode: ThemeMode.system,
//   );

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
//             theme: AppTheme.light,
//             darkTheme: AppTheme.dark,
//             themeMode: _themeController.mode,
//             builder: (context, child) {
//               final media = MediaQuery.of(context);
//               final clamped = media.textScaler.clamp(=//                 minScaleFactor: 0.9,
//                 maxScaleFactor: 1.2,
//               );
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

// lib/main.dart
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'core/theme_controller.dart';
import 'ui/screens/Auth/splash_screen.dart';

// ⬇️ providers/bootstrap wrapper you added
import 'app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wrap the app with AppBootstrap so UserSession + ApiClient are available everywhere.
  runApp(const _Root());
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    return AppBootstrap(child: const MyApp());
  }
}

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
            // Keep your current entry point; SplashScreen can decide where to go.
            home: const SplashScreen(),
            // (Optional) Add routes now or later when you wire login/dashboard:
            // routes: {
            //   '/login': (_) => const LoginScreen(),
            //   '/dashboard': (_) => const DashboardScreen(),
            // },
          );
        },
      ),
    );
  }
}
