// lib/ui/screens/users/add_user_screen.dart
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
// Add after existing imports
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  // --- form state ---
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  final _roles = const ['Admin', 'Project Manager', 'NOC', 'SCM'];
  String? _role;

  bool _showPass = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _usernameCtrl.clear();
      _emailCtrl.clear();
      _passwordCtrl.clear();
      _confirmCtrl.clear();
      _role = null;
      _showPass = false;
      _showConfirm = false;
    });
  }

  final int _selectedTab = 0;

  void _handleTabChange(int i) {
    if (i == _selectedTab) return;
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
        break;
      case 1:
        target = const AddProjectScreen();
        break;
      case 2:
        target = const AddActivityScreen();
        break;
      case 3:
        target = const AnalyticsScreen();
        break;
      case 4:
        target = const ViewUsersScreen();
        break;
      default:
        return;
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add User',
      centerTitle: true,
      actions: [
        IconButton(
          tooltip:
              Theme.of(context).brightness == Brightness.dark
                  ? 'Light mode'
                  : 'Dark mode',
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
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
          icon: ClipOval(
            child: Image.asset(
              'assets/User_profile.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      // currentIndex: 0,
      // onTabChanged: (_) {},
      currentIndex: _selectedTab,
      onTabChanged: (i) => _handleTabChange(i),
      safeArea: false,
      reserveBottomPadding: true,
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          Card(
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create User',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(onPressed: _clear, child: const Text('Clear')),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // Form grid
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _TextField(
                          label: 'Username *',
                          controller: _usernameCtrl,
                        ),
                        _TextField(
                          label: 'Email ID *',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ];

                      final right = [
                        _Dropdown<String>(
                          label: 'Role *',
                          value: _role,
                          items: _roles,
                          onChanged: (v) => setState(() => _role = v),
                        ),
                        _PasswordField(
                          label: 'Password *',
                          controller: _passwordCtrl,
                          visible: _showPass,
                          onToggle:
                              () => setState(() => _showPass = !_showPass),
                        ),
                        _PasswordField(
                          label: 'Confirm Password *',
                          controller: _confirmCtrl,
                          visible: _showConfirm,
                          onToggle:
                              () =>
                                  setState(() => _showConfirm = !_showConfirm),
                        ),
                      ];

                      if (!isWide) {
                        return Column(children: [...left, ...right]);
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Column(children: left)),
                          SizedBox(width: gap),
                          Expanded(child: Column(children: right)),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 220),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: validation + API call
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User Created')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Create',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---- Reusable inputs (same look as other pages) ----

class _FieldShell extends StatelessWidget {
  final String label;
  final Widget child;
  const _FieldShell({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const _TextField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool visible;
  final VoidCallback onToggle;
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.visible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        obscureText: !visible,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              visible ? Icons.visibility_off : Icons.visibility,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            iconEnabledColor: cs.onSurfaceVariant,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            style: TextStyle(color: cs.onSurface, fontSize: 14),
            items:
                items
                    .map(
                      (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
                    )
                    .toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
