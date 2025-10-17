import 'package:flutter/material.dart';
import '../../../core/theme_controller.dart';
import '../profile/profile_screen.dart';
import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
// Bottom-nav root screens for MainLayout routing
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';

class AddFEVendorScreen extends StatefulWidget {
  const AddFEVendorScreen({super.key});

  @override
  State<AddFEVendorScreen> createState() => _AddFEVendorScreenState();
}

class _AddFEVendorScreenState extends State<AddFEVendorScreen> {
  // --- dropdown data (sample) ---
  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final _sites = const ['Site 001', 'Site 002', 'Site 003'];
  final _zones = const ['North', 'East', 'South', 'West'];
  final _states = const ['Maharashtra', 'Gujarat', 'Karnataka'];
  final _districts = const ['Thane', 'Pune', 'Ahmedabad', 'Bengaluru Urban'];

  // --- selections ---
  String? _project;
  String? _site;
  String? _zone;
  String? _state;
  String? _district;

  // --- text controllers ---
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  final _bankNameCtrl = TextEditingController();
  final _bankAccCtrl = TextEditingController();
  final _bankIfscCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _vendorNameCtrl = TextEditingController();

  final _roleCtrl = TextEditingController(text: 'Field Engineer / Vendor');

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccCtrl.dispose();
    _bankIfscCtrl.dispose();
    _panCtrl.dispose();
    _vendorNameCtrl.dispose();
    _roleCtrl.dispose();
    super.dispose();
  }

  void _clearAll() {
    setState(() {
      _fullNameCtrl.clear();
      _emailCtrl.clear();
      _contactCtrl.clear();
      _bankNameCtrl.clear();
      _bankAccCtrl.clear();
      _bankIfscCtrl.clear();
      _panCtrl.clear();
      _vendorNameCtrl.clear();
      _project = null;
      _site = null;
      _zone = null;
      _state = null;
      _district = null;
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

    // return MainLayout(
    //   title: 'Add Field Engineer',
    //   centerTitle: true,
    //   currentIndex: 0,
    //   onTabChanged: (_) {},
    //   safeArea: false,
    //   reserveBottomPadding: true,
    //   body: ListView(
    return MainLayout(
      title: 'Add Field Engineer',
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
                  // Header row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create Field Engineer / Vendor',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearAll,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // ===== Top section: Identity / Assignment =====
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _TextField(
                          label: 'Full Name *',
                          controller: _fullNameCtrl,
                        ),
                        _TextField(
                          label: 'Email *',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _TextField(
                          label: 'Contact No *',
                          controller: _contactCtrl,
                          keyboardType: TextInputType.phone,
                        ),
                      ];

                      final right = [
                        _ROText('Role', _roleCtrl),
                        _Dropdown<String>(
                          label: 'Project Working *',
                          value: _project,
                          items: _projects,
                          onChanged: (v) => setState(() => _project = v),
                        ),
                        _Dropdown<String>(
                          label: 'Site *',
                          value: _site,
                          items: _sites,
                          onChanged: (v) => setState(() => _site = v),
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

                  const SizedBox(height: 14),
                  Divider(color: cs.outlineVariant),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 2),
                    child: Text(
                      'Bank Details',
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  // ===== Bank + Region section =====
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _TextField(
                          label: 'Bank Name',
                          controller: _bankNameCtrl,
                        ),
                        _TextField(
                          label: 'Bank IFSC',
                          controller: _bankIfscCtrl,
                        ),
                        _Dropdown<String>(
                          label: 'Zone *',
                          value: _zone,
                          items: _zones,
                          onChanged: (v) => setState(() => _zone = v),
                        ),
                        _Dropdown<String>(
                          label: 'State *',
                          value: _state,
                          items: _states,
                          onChanged: (v) => setState(() => _state = v),
                        ),
                      ];

                      final right = [
                        _TextField(
                          label: 'Bank Account No',
                          controller: _bankAccCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        _TextField(label: 'Pan No', controller: _panCtrl),
                        _TextField(
                          label: 'Vendor Name',
                          controller: _vendorNameCtrl,
                        ),
                        _Dropdown<String>(
                          label: 'District *',
                          value: _district,
                          items: _districts,
                          onChanged: (v) => setState(() => _district = v),
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
                  // wide create button aligned to right (similar to Save on Add Project)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 220),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: hook actual create
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('PM Created')),
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

/// --- Small UI helpers (same as other forms) ---

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
  const _ROText(this.label, this.controller);

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
