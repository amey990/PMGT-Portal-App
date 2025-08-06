// lib/core/no_glow_scroll_behavior.dart

import 'package:flutter/material.dart';

/// A ScrollBehavior that removes the default overscroll glow/indicator.
class NoGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Simply return the child without any glow.
    return child;
  }
}
