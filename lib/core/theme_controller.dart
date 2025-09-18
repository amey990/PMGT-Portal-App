// import 'package:flutter/material.dart';

// /// Holds ThemeMode and notifies listeners when it changes.
// class ThemeController extends ChangeNotifier {
//   ThemeMode _mode;
//   ThemeController({ThemeMode initialMode = ThemeMode.system}) : _mode = initialMode;

//   ThemeMode get mode => _mode;

//   void setMode(ThemeMode mode) {
//     if (_mode == mode) return;
//     _mode = mode;
//     notifyListeners();
//   }

//   void toggle() {
//     if (_mode == ThemeMode.dark) {
//       setMode(ThemeMode.light);
//     } else {
//       setMode(ThemeMode.dark);
//     }
//   }
// }

// /// Inherited access without adding a package.
// class ThemeScope extends InheritedNotifier<ThemeController> {
//   const ThemeScope({
//     super.key,
//     required ThemeController controller,
//     required Widget child,
//   }) : super(notifier: controller, child: child);

//   static ThemeController of(BuildContext context) {
//     final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
//     assert(scope != null, 'ThemeScope not found above in the tree.');
//     return scope!.notifier!;
//   }
// }


import 'package:flutter/material.dart';

/// Holds ThemeMode and notifies listeners when it changes.
class ThemeController extends ChangeNotifier {
  ThemeMode _mode;
  ThemeController({ThemeMode initialMode = ThemeMode.system}) : _mode = initialMode;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }

  void toggle() {
    if (_mode == ThemeMode.dark) {
      setMode(ThemeMode.light);
    } else {
      setMode(ThemeMode.dark);
    }
  }
}

/// Inherited access without adding a package.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope not found above in the tree.');
    return scope!.notifier!;
  }
}
