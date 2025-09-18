import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../../core/theme_controller.dart';
import '../screens/profile/profile_screen.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;               // the page’s content
  final int currentIndex;          // bottom nav index
  final ValueChanged<int> onTap;   // bottom nav tap handler
  final List<Widget>? actions;     // optional extra actions

  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: Icon(Icons.menu,
                color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Text(title),
        centerTitle: false,
        actions: [
          ...?actions,
          IconButton(
            tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: cs.onSurface,
            ),
            onPressed: () => ThemeScope.of(context).toggle(),
          ),
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            icon: ClipOval(
              child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTap),
    );
  }
}
