// import 'package:flutter/material.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../widgets/app_appbar.dart';
// import '../../widgets/app_drawer.dart';
// import '../../widgets/custom_bottom_nav_bar.dart';

// /// Main reusable scaffold
// class MainLayout extends StatelessWidget {
//   const MainLayout({
//     super.key,
//     this.title,
//     this.centerTitle = false,
//     this.actions,
//     required this.body,
//     required this.currentIndex,
//     required this.onTabChanged,
//     this.extendBodyBehindNav = true,
//     this.safeArea = true,
//     this.reserveBottomPadding = true,
//     this.drawerEnabled = true,
//   });

//   /// Title in the app bar
//   final String? title;
//   final bool centerTitle;
//   final List<Widget>? actions;

//   /// Middle content
//   final Widget body;

//   /// Bottom nav state
//   final int currentIndex;
//   final ValueChanged<int> onTabChanged;

//   /// If true, lets content draw under the custom bar (looks nicer with blur/alpha)
//   final bool extendBodyBehindNav;

//   /// Wrap body with SafeArea
//   final bool safeArea;

//   /// Adds bottom padding so scrollables don't sit under the bar
//   final bool reserveBottomPadding;

//   /// Show hamburger drawer
//   final bool drawerEnabled;

//   @override
//   Widget build(BuildContext context) {
//     final Widget middle =
//         reserveBottomPadding
//             ? Padding(
//               padding: EdgeInsets.only(
//                 bottom: CustomBottomNavBar.reservedBodyPadding(context),
//               ),
//               child: body,
//             )
//             : body;

//     final content = safeArea ? SafeArea(child: middle) : middle;

//     return Scaffold(
//       // allow the custom stacked nav bar to float over content
//       extendBody: extendBodyBehindNav,
//       appBar: AppAppBar(
//         title: title,
//         centerTitle: centerTitle,
//         actions: actions,
//       ),
//       drawer: drawerEnabled ? const AppDrawer() : null,
//       body: content,
//       // Your custom nav bar
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: currentIndex,
//         onTap: onTabChanged,
//       ),
//     );
//   }
// }

// // ---------------------------------------------------------------------------
// // Optional: Full app shell that manages pages & titles with an IndexedStack.
// // Drop-in home widget for your MaterialApp.
// // ---------------------------------------------------------------------------
// class AppShell extends StatefulWidget {
//   AppShell({
//     super.key,
//     required this.pages,
//     required this.titles,
//     this.initialIndex = 0,
//     this.actionsBuilder,
//     this.onNavChanged,
//   }) : assert(
//          pagesLengthMatchesTitles(pages, titles),
//          'pages and titles length must match',
//        );

//   final List<Widget> pages;
//   final List<String> titles;
//   final int initialIndex;
//   final List<Widget> Function(int index)? actionsBuilder;
//   final ValueChanged<int>? onNavChanged;

//   static bool pagesLengthMatchesTitles(List<Widget> p, List<String> t) =>
//       p.length == t.length;

//   @override
//   State<AppShell> createState() => _AppShellState();
// }

// class _AppShellState extends State<AppShell> {
//   late int _index = widget.initialIndex;

//   void _onTap(int i) {
//     if (_index == i) return;
//     setState(() => _index = i);
//     widget.onNavChanged?.call(i);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MainLayout(
//       title: widget.titles[_index],
//       actions: widget.actionsBuilder?.call(_index),
//       currentIndex: _index,
//       onTabChanged: _onTap,
//       body: IndexedStack(index: _index, children: widget.pages),
//     );
//   }
// }

// // ---------------------------------------------------------------------------
// // Example placeholder body (delete once your dashboard is plugged in)
// // ---------------------------------------------------------------------------
// class DashboardBody extends StatelessWidget {
//   const DashboardBody({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: cs.surfaceVariant,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Text(
//             'Replace with your dashboard widgets',
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );
//   }
// }


// lib/widgets/layout/main_layout.dart
// Reusable app shell that wires your AppBar, Drawer, and custom BottomNavBar
// Each page supplies only the center `body`; title OR a custom `titleWidget`.

import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../widgets/app_appbar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

/// Main reusable scaffold
class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    this.title,
    this.titleWidget, // NEW: custom title (e.g., your Project/Summary ToggleButtons)
    this.centerTitle = false,
    this.actions,
    required this.body,
    required this.currentIndex,
    required this.onTabChanged,
    this.extendBodyBehindNav = true,
    this.safeArea = true,
    this.reserveBottomPadding = true,
    this.drawerEnabled = true,
  });

  /// Title in the app bar
  final String? title;
  /// When provided, overrides [title] and is placed in the middle of the AppBar.
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;

  /// Middle content
  final Widget body;

  /// Bottom nav state
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  /// If true, lets content draw under the custom bar (looks nicer with blur/alpha)
  final bool extendBodyBehindNav;

  /// Wrap body with SafeArea
  final bool safeArea;

  /// Adds bottom padding so scrollables don't sit under the bar
  final bool reserveBottomPadding;

  /// Show hamburger drawer
  final bool drawerEnabled;

  @override
  Widget build(BuildContext context) {
    final Widget middle = reserveBottomPadding
        ? Padding(
            padding: EdgeInsets.only(
              bottom: CustomBottomNavBar.reservedBodyPadding(context),
            ),
            child: body,
          )
        : body;

    final content = safeArea ? SafeArea(child: middle) : middle;

    return Scaffold(
      // allow the custom stacked nav bar to float over content
      extendBody: extendBodyBehindNav,
      appBar: AppAppBar(
        title: title,
        titleWidget: titleWidget, // pass along
        centerTitle: centerTitle,
        actions: actions,
      ),
      drawer: drawerEnabled ? const AppDrawer() : null,
      body: content,
      // Your custom nav bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Optional: Full app shell that manages pages & titles with an IndexedStack.
// Drop-in home widget for your MaterialApp.
// ---------------------------------------------------------------------------
class AppShell extends StatefulWidget {
  AppShell({
    super.key,
    required this.pages,
    required this.titles,
    this.initialIndex = 0,
    this.actionsBuilder,
    this.onNavChanged,
  }) : assert(
          pagesLengthMatchesTitles(pages, titles),
          'pages and titles length must match',
        );

  final List<Widget> pages;
  final List<String> titles;
  final int initialIndex;
  final List<Widget> Function(int index)? actionsBuilder;
  final ValueChanged<int>? onNavChanged;

  static bool pagesLengthMatchesTitles(List<Widget> p, List<String> t) =>
      p.length == t.length;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  void _onTap(int i) {
    if (_index == i) return;
    setState(() => _index = i);
    widget.onNavChanged?.call(i);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: widget.titles[_index],
      actions: widget.actionsBuilder?.call(_index),
      currentIndex: _index,
      onTabChanged: _onTap,
      body: IndexedStack(index: _index, children: widget.pages),
    );
  }
}

// ---------------------------------------------------------------------------
// Example placeholder body (delete once your dashboard is plugged in)
// ---------------------------------------------------------------------------
class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Replace with your dashboard widgets',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}