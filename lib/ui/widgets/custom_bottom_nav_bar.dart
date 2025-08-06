// lib/ui/widgets/custom_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  /// The currently selected tab index (0–3).
  final int currentIndex;

  /// Called when tapping one of the four tabs.
  final ValueChanged<int> onTap;

  /// Height of the dark bar itself.
  static const double barHeight = 70;

  /// Diameter of the floating center “+” button.
  static const double fabSize = 65;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  static const _icons = <IconData>[
    Icons.dashboard_outlined,
    Icons.folder_open_outlined,
    Icons.bar_chart_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1) The dark bar background + four icons
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: barHeight,
            color: const Color(0xFF191A1E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // first two icons
                for (int i = 0; i < 2; i++)
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

                // spacer for the “+” button
                const SizedBox(width: fabSize),

                // last two icons
                for (int i = 2; i < 4; i++)
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
        ),

        // 2) The floating center “+” button
        Positioned(
          bottom: barHeight - (fabSize / 2),
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                // TODO: handle the central action
              },
              child: Container(
                width: fabSize,
                height: fabSize,
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
    );
  }
}
