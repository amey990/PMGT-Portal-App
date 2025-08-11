// // lib/ui/widgets/simple_bottom_bar.dart

// import 'package:flutter/material.dart';

// class SimpleBottomBar extends StatelessWidget {
//   /// Index of the currently selected tab (0–3).
//   final int currentIndex;

//   /// Called when a tab is tapped.
//   final ValueChanged<int> onTap;

//   /// Height of the bar.
//   final double height;

//   const SimpleBottomBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//     this.height = 70,
//   }) : super(key: key);

//   // The four icons you wanted:
//   static const _icons = <IconData>[
//     Icons.dashboard_outlined,
//     Icons.folder_open_outlined,
//     Icons.bar_chart_outlined,
//     Icons.person_outline,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false, left: false, right: false, bottom: true,
//       child: SizedBox(
//         height: height,
//         child: Container(
//           color: const Color(0xFF191A1E),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: List.generate(_icons.length, (i) {
//               final isActive = i == currentIndex;
//               return IconButton(
//                 icon: Icon(
//                   _icons[i],
//                   size: 28,
//                   color: isActive
//                       ? const Color(0xFFCBAE04)  // active
//                       : Colors.white,           // inactive
//                 ),
//                 onPressed: () => onTap(i),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }


// lib/ui/widgets/simple_bottom_bar.dart

import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class SimpleBottomBar extends StatelessWidget {
  /// Index of the currently selected tab (0–3).
  final int currentIndex;

  /// Called when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Height of the bar (above the phone’s home indicator).
  final double height;

  const SimpleBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.height = 70,
  });

  // The four icons you wanted:
  static const _icons = <IconData>[
    Icons.dashboard_outlined,
    Icons.folder_open_outlined,
    Icons.bar_chart_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    const addButtonSize = 56.0;

    return SafeArea(
      top: false, left: false, right: false, bottom: true,
      child: SizedBox(
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1) The background bar + the four icons (two on each side)
            Container(
              color: const Color(0xFF191A1E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // first two
                  for (var i = 0; i < 2; i++)
                    IconButton(
                      icon: Icon(
                        _icons[i],
                        size: 28,
                        color: i == currentIndex
                            ? const Color(0xFFCBAE04)
                            : Colors.white,
                      ),
                      onPressed: () => onTap(i),
                    ),

                  // spacer to make room for the + button
                  const SizedBox(width: addButtonSize),

                  // last two
                  for (var i = 2; i < 4; i++)
                    IconButton(
                      icon: Icon(
                        _icons[i],
                        size: 28,
                        color: i == currentIndex
                            ? const Color(0xFFCBAE04)
                            : Colors.white,
                      ),
                      onPressed: () => onTap(i),
                    ),
                ],
              ),
            ),

            // 2) The centered “+” button, half peeking above the bar
            Positioned(
              top: -(addButtonSize / 2),
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: handle your add action
                  },
                  child: Container(
                    width: addButtonSize,
                    height: addButtonSize,
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, size: 32, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
