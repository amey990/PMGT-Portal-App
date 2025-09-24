
import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class SimpleBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double height;

  const SimpleBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.height = 70,
  });

  static const _icons = <IconData>[
    Icons.dashboard_outlined,
    Icons.folder_open_outlined,
    Icons.bar_chart_outlined,
    Icons.person_outline,
  ];

  static const double addButtonSize = 56.0;

  /// If a page uses `extendBody: true`, add this much bottom padding to the body.
  static double reservedBodyPadding(BuildContext context) {
    final inset = MediaQuery.of(context).padding.bottom;
    return (addButtonSize / 2) + inset + 12; // space the raised + consumes
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final barColor = cs.surface;
    final selected = cs.primary;
    final unselected = cs.onSurface;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: SizedBox(
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // background + icons
            Container(
              decoration: BoxDecoration(
                color: barColor,
                border: Border(top: BorderSide(color: cs.outlineVariant)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 2; i++)
                    IconButton(
                      icon: Icon(_icons[i], size: 28, color: i == currentIndex ? selected : unselected),
                      onPressed: () => onTap(i),
                    ),
                  const SizedBox(width: addButtonSize), // spacer for +
                  for (var i = 2; i < 4; i++)
                    IconButton(
                      icon: Icon(_icons[i], size: 28, color: i == currentIndex ? selected : unselected),
                      onPressed: () => onTap(i),
                    ),
                ],
              ),
            ),

            // centered +
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
                    decoration: const BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
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
