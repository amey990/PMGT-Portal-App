// import 'package:flutter/material.dart';
// import '../../core/theme.dart';
// import '../../core/theme_controller.dart';
// import '../screens/profile/profile_screen.dart';

// class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   const AppAppBar({super.key, this.title});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return AppBar(
//       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       elevation: 0,
//       leading: Builder(
//         builder: (ctx) => IconButton(
//           icon: Icon(Icons.menu, color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//           onPressed: () => Scaffold.of(ctx).openDrawer(),
//         ),
//       ),
//       title: title != null
//           ? Text(
//               title!,
//               // use your custom heading but recolor to match theme
//               style: AppTheme.heading2.copyWith(color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? cs.onSurface),
//             )
//           : null,
//       actions: [
//         // Theme toggle
//         IconButton(
//           tooltip: 'Toggle theme',
//           onPressed: () => ThemeScope.of(context).toggle(),
//           icon: Icon(
//             Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
//             color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface,
//           ),
//         ),
//         // Profile avatar
//         IconButton(
//           icon: ClipOval(
//             child: Image.asset(
//               'assets/User_profile.png',
//               width: 36,
//               height: 36,
//               fit: BoxFit.cover,
//             ),
//           ),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => const ProfileScreen()),
//             );
//           },
//         ),
//         const SizedBox(width: 4),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../core/theme_controller.dart';
import '../screens/profile/profile_screen.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final List<Widget>? actions;

  const AppAppBar({
    super.key,
    this.title,
    this.centerTitle = false,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: AppTheme.heading2.copyWith(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? cs.onSurface,
              ),
            )
          : null,
      actions: [
        ...?actions,
        IconButton(
          tooltip: 'Toggle theme',
          onPressed: () => ThemeScope.of(context).toggle(),
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
            color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface,
          ),
        ),
        IconButton(
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
