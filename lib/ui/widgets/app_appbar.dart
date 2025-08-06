import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../screens/profile/profile_screen.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Optional title; leave null if you don’t want one.
  final String? title;

  const AppAppBar({Key? key, this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: title != null
          ? Text(title!, style: AppTheme.heading2)
          : null,
      actions: [
        IconButton(
          icon: ClipOval(
            child: Image.asset(
              'assets/User_profile.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
        ),
        const SizedBox(width:2),
      ],
    );
  }
}
