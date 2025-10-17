import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
// Bottom-nav root screens (for MainLayout routing)
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  // Controllers
  final _nameCtrl = TextEditingController();
  final _roleCtrl = TextEditingController(text: 'Customer'); // read-only
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _showPassword = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _roleCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _passwordCtrl.clear();
      _confirmCtrl.clear();
      _showPassword = false;
      _showConfirm = false;
    });
  }

  void _create() {
    // TODO: wire validation + API
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Customer created')));
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
      title: 'Add Customer',
      centerTitle: true,
      // currentIndex: 0,
      // onTabChanged: (_) {},
      currentIndex: _selectedTab,
      onTabChanged: (i) => _handleTabChange(i),
      safeArea: false,
      reserveBottomPadding: true,
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
                          'Create Customer',
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

                  // Grid
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _TextField(
                          label: 'Customer Name *',
                          controller: _nameCtrl,
                        ),
                        _TextField(
                          label: 'Email *',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _PasswordField(
                          label: 'Password *',
                          controller: _passwordCtrl,
                          visible: _showPassword,
                          onToggle:
                              () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                        ),
                      ];

                      final right = [
                        _ROText(label: 'Role', controller: _roleCtrl),
                        const SizedBox(height: 6), // keep grid rhythm
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
                        onPressed: _create,
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

/// ---- Small UI helpers (consistent) ----

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
  final int maxLines;
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
        maxLines: maxLines,
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

class _ROText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _ROText({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        enabled: false,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
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
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              visible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: cs.onSurfaceVariant,
            ),
          ),
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
