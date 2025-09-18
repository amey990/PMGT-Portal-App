// import 'package:flutter/material.dart';

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

// class AntiOverflowScroll extends StatelessWidget {
//   final Widget child;
//   const AntiOverflowScroll({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, c) {
//         return SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: c.maxHeight),
//             // IMPORTANT: no IntrinsicHeight here (it conflicts with LayoutBuilder in subtree)
//             child: child,
//           ),
//         );
//       },
//     );
//   }
// }


// class MaxWidth extends StatelessWidget {
//   final double maxWidth;
//   final Widget child;
//   const MaxWidth({super.key, this.maxWidth = 560, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: maxWidth),
//         child: child,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class Breakpoints {
  static const double xs = 320;  // very small phones
  static const double sm = 360;  // common small
  static const double md = 400;  // common medium
  static const double lg = 480;  // larger phones / small foldables
}

extension ContextSizeX on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isXS => w < Breakpoints.xs;
  bool get isSM => w >= Breakpoints.xs && w < Breakpoints.sm;
  bool get isMD => w >= Breakpoints.sm && w < Breakpoints.md;
  bool get isLG => w >= Breakpoints.md;
}

EdgeInsets responsivePadding(BuildContext context) {
  final width = context.w;
  if (width < Breakpoints.xs) return const EdgeInsets.all(12);
  if (width < Breakpoints.sm) return const EdgeInsets.all(16);
  if (width < Breakpoints.md) return const EdgeInsets.all(20);
  return const EdgeInsets.all(24);
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
