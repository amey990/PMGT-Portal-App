// lib/ui/screens/home_shell.dart
import 'package:flutter/material.dart';
import '../widgets/layout/main_layout.dart'; // AppShell
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/Projects/add_project_screen.dart';
import '../screens/activities/add_activity_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/users/view_users_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      pages: const [
        DashboardScreen(),   // 0
        AddProjectScreen(),  // 1
        AddActivityScreen(), // 2
        AnalyticsScreen(),   // 3
        ViewUsersScreen(),   // 4
      ],
      titles: const [
        'Dashboard',
        'Projects',
        'Add Activity',
        'Analytics',
        'Users',
      ],
    );
  }
}
