// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   // Public constants so pages can reserve space if they use extendBody=true.
//   static const double barHeight = 58;
//   static const double fabSize = 56;

//   const CustomBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   static const _icons = <IconData>[
//     Icons.dashboard_outlined,
//     Icons.folder_open_outlined,
//     Icons.bar_chart_outlined,
//     Icons.person_outline,
//   ];

//   /// If a page uses `extendBody: true`, add bottom padding equal to this.
//   static double reservedBodyPadding(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).padding.bottom;
//     return barHeight + bottomInset;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final selected = cs.primary;
//     final unselected = cs.onSurface;
//     final barColor = cs.surface;

//     final bottomInset = MediaQuery.of(context).padding.bottom;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // Bar background + icons
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             height: barHeight + bottomInset,
//             padding: EdgeInsets.only(bottom: bottomInset),
//             decoration: BoxDecoration(
//               color: barColor,
//               border: Border(
//                 top: BorderSide(color: cs.outlineVariant),
//               ), // visual separator from content
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 for (int i = 0; i < 2; i++)
//                   IconButton(
//                     icon: Icon(
//                       _icons[i],
//                       size: 26,
//                       color: i == currentIndex ? selected : unselected,
//                     ),
//                     onPressed: () => onTap(i),
//                   ),
//                 const SizedBox(width: fabSize), // spacer for the center FAB
//                 for (int i = 2; i < 4; i++)
//                   IconButton(
//                     icon: Icon(
//                       _icons[i],
//                       size: 26,
//                       color: i == currentIndex ? selected : unselected,
//                     ),
//                     onPressed: () => onTap(i),
//                   ),
//               ],
//             ),
//           ),
//         ),

//         // Center “+” button
//         Positioned(
//           bottom: barHeight - (fabSize / 2),
//           left: 0,
//           right: 0,
//           child: Center(
//             child: GestureDetector(
//               onTap: () {
//                 // TODO: central action
//               },
//               child: Container(
//                 width: fabSize,
//                 height: fabSize,
//                 decoration: BoxDecoration(
//                   color: AppTheme.accentColor,
//                   shape: BoxShape.circle,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(Icons.add, size: 30, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// lib/ui/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const double barHeight = 58;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = <IconData>[
    Icons.dashboard_outlined,    // 0 Dashboard
    Icons.folder_open_outlined,  // 1 Projects
    Icons.add_circle_outline,    // 2 Add Activity
    Icons.bar_chart_outlined,    // 3 Analytics
    Icons.people_outline,        // 4 Users
  ];

  static double reservedBodyPadding(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return barHeight + bottomInset;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selected   = cs.primary;
    final unselected = cs.onSurfaceVariant;
    final barColor   = cs.surface;

    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      height: barHeight + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: BoxDecoration(
        color: barColor,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (i) {
          final isActive = i == currentIndex;
          return IconButton(
            icon: Icon(_icons[i],
                size: 26, color: isActive ? selected : unselected),
            onPressed: () => onTap(i),
          );
        }),
      ),
    );
  }
}
