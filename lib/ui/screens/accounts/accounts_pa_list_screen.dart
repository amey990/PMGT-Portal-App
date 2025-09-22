import 'package:flutter/material.dart';
import '../../../core/theme_controller.dart';
import '../../../core/theme.dart';
import '../../widgets/layout/main_layout.dart';
import '../../utils/responsive.dart';
import '../profile/profile_screen.dart';
import '../../widgets/app_drawer.dart';

class AccountsPaListScreen extends StatefulWidget {
  const AccountsPaListScreen({super.key});

  @override
  State<AccountsPaListScreen> createState() => _AccountsPaListScreenState();
}

class _AccountsPaListScreenState extends State<AccountsPaListScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Accounts – PA List',
      centerTitle: true,
      drawerMode: DrawerMode.accounts, // <<< enable Accounts drawer
      currentIndex: _tab,
      onTabChanged: (i) => setState(() => _tab = i),
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
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
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'PA List (Accounts) – plug real content here',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
