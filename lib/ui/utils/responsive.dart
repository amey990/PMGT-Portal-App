import 'package:flutter/material.dart';

// class Breakpoints {
//   static const double xs = 320;  // very small phones
//   static const double sm = 360;  // common small
//   static const double md = 400;  // common medium
//   static const double lg = 480;  // larger phones / small foldables
// }

// extension ContextSizeX on BuildContext {
//   double get w => MediaQuery.of(this).size.width;
//   double get h => MediaQuery.of(this).size.height;
//   bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;

//   bool get isXS => w < Breakpoints.xs;
//   bool get isSM => w >= Breakpoints.xs && w < Breakpoints.sm;
//   bool get isMD => w >= Breakpoints.sm && w < Breakpoints.md;
//   bool get isLG => w >= Breakpoints.md;
// }

// EdgeInsets responsivePadding(BuildContext context) {
//   final width = context.w;
//   if (width < Breakpoints.xs) return const EdgeInsets.all(12);
//   if (width < Breakpoints.sm) return const EdgeInsets.all(16);
//   if (width < Breakpoints.md) return const EdgeInsets.all(20);
//   return const EdgeInsets.all(24);
// }

class Breakpoints {
  static const double xs = 320; // very small phones
  static const double sm = 360; // small phones
  static const double md = 400; // medium phones
  static const double lg = 480; // large phones
  static const double tablet = 600; // tablets/large foldables
}

extension ContextSizeX on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isXS => w < Breakpoints.xs;
  bool get isSM => w >= Breakpoints.xs && w < Breakpoints.sm;
  bool get isMD => w >= Breakpoints.sm && w < Breakpoints.md;
  bool get isLG => w >= Breakpoints.md && w < Breakpoints.tablet;
  bool get isTablet => w >= Breakpoints.tablet;
}

/// Smaller horizontal padding on phones so cards can be wider.
// EdgeInsets responsivePadding(BuildContext context) {
//   final w = context.w;

//   if (w < Breakpoints.xs)
//     return const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
//   if (w < Breakpoints.sm)
//     return const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
//   if (w < Breakpoints.md)
//     return const EdgeInsets.symmetric(horizontal: 14, vertical: 12);
//   if (w < Breakpoints.lg)
//     return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
//   if (w < Breakpoints.tablet)
//     return const EdgeInsets.symmetric(horizontal: 18, vertical: 14);

//   // tablets and above
//   return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
// }

EdgeInsets responsivePadding(BuildContext context) {
  final w = context.w;

  // Small sides on all screens; scales slightly but stays tight.
  final horizontal = (w * 0.03).clamp(8.0, 16.0);
  final vertical = (w * 0.02).clamp(8.0, 14.0);

  return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}

/// Scrollable that prevents render overflow and still lets the child grow to fill.
class AntiOverflowScroll extends StatelessWidget {
  final Widget child;
  const AntiOverflowScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            // IMPORTANT: no IntrinsicHeight here (it conflicts with LayoutBuilder in subtree)
            child: child,
          ),
        );
      },
    );
  }
}

/// Centered, constrained-width container (nice for long forms)
class MaxWidth extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const MaxWidth({super.key, this.maxWidth = 560, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
