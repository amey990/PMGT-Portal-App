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


class AddBdmScreen extends StatefulWidget {
  const AddBdmScreen({super.key});

  @override
  State<AddBdmScreen> createState() => _AddBdmScreenState();
}

class _AddBdmScreenState extends State<AddBdmScreen> {
  // form state
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _assignedProject;

  // sample projects
  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _phoneCtrl.clear();
      _assignedProject = null;
    });
  }

  final int _selectedTab = 0;

void _handleTabChange(int i) {
  if (i == _selectedTab) return;
  late final Widget target;
  switch (i) {
    case 0: target = const DashboardScreen(); break;
    case 1: target = const AddProjectScreen(); break;
    case 2: target = const AddActivityScreen(); break;
    case 3: target = const AnalyticsScreen(); break;
    case 4: target = const ViewUsersScreen(); break;
    default: return;
  }
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
}

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

    return MainLayout(
      title: 'Add BDM',
      centerTitle: true,
      // top-right actions (theme toggle + profile), consistent with other pages
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
        padding: pad.copyWith(top: 12, bottom: 12),
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
                  // header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create BDM',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(onPressed: _clear, child: const Text('CLEAR')),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // grid-like layout (2 columns on wide, stacked on narrow)
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _TextField(label: 'Full Name *', controller: _nameCtrl),
                        _TextField(
                          label: 'Email *',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _TextField(
                          label: 'Contact No *',
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                        ),
                      ];

                      final right = [
                        _ROText(
                          label: 'Role',
                          value:
                              'Business Development Manager (BDM)', // read-only
                        ),
                        _Dropdown<String>(
                          label: 'Assign to Projects',
                          value: _assignedProject,
                          items: _projects,
                          onChanged:
                              (v) => setState(() => _assignedProject = v),
                        ),
                        const SizedBox(height: 1),
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
                  // wide create button aligned to right (similar to Save on Add Project)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 220),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: hook actual create
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('BDM Created'))
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

/* ---------- small UI helpers (consistent with other screens) ---------- */

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

class _ROText extends StatelessWidget {
  final String label;
  final String value;
  const _ROText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: TextEditingController(text: value),
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
