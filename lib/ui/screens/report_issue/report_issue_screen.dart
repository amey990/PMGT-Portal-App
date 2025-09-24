// lib/ui/screens/report_issue/report_issue_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
// Bottom-nav root screens for routing
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';


class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  // bottom nav state required by MainLayout
  int _selectedTab = 0;

  // form controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController(text: 'commedia9900@gmail.co');
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // dropdown data
  final List<String> _priorities = const ['High', 'Moderate', 'Low'];
  final List<String> _modules = const [
    'Dashboard',
    'Project',
    'Site',
    'Activities',
    'Reminders',
    'User management',
    'Analytics',
    'Inventory',
    'Accounts',
    'PA',
  ];

  String? _priority = 'Moderate';
  String? _module = 'Dashboard';

  // picked files
  final List<PlatformFile> _files = [];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null && mounted) {
      setState(() {
        _files.addAll(result.files);
      });
    }
  }

  void _removeFile(PlatformFile f) {
    setState(() => _files.remove(f));
  }

  void _clear() {
    setState(() {
      _nameCtrl.clear();
      _emailCtrl.text = _emailCtrl.text; // keep default
      _titleCtrl.clear();
      _descCtrl.clear();
      _priority = 'Moderate';
      _module = 'Dashboard';
      _files.clear();
    });
  }

  void _send() {
    // TODO: Wire this up to your backend or emailer
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Issue submitted')));
    _clear();
  }

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

    return MainLayout(
      title: 'Report Issue / Bug',
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
      // >>> these two are REQUIRED by MainLayout <<<
      // currentIndex: _selectedTab,
      // onTabChanged: (i) => setState(() => _selectedTab = i),
      currentIndex: _selectedTab,
      onTabChanged: (i) => _handleTabChange(i),


      reserveBottomPadding: true,
      safeArea: false,
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
                          'Report an Issue / Bug',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clear,
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  const SizedBox(height: 12),
                  _Field(label: 'Name', child: _tf(_nameCtrl, cs)),
                  _Field(
                    label: 'Email',
                    child: _tf(
                      _emailCtrl,
                      cs,
                      keyboard: TextInputType.emailAddress,
                    ),
                  ),
                  _Field(label: 'Issue Title', child: _tf(_titleCtrl, cs)),

                  // Priority + Module row
                  LayoutBuilder(
                    builder: (ctx, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _Field(
                          label: 'Priority',
                          child: _drop<String>(
                            cs: cs,
                            value: _priority,
                            items: _priorities,
                            onChanged:
                                (v) =>
                                    setState(() => _priority = v ?? _priority),
                          ),
                        ),
                      ];

                      final right = [
                        _Field(
                          label: 'Affected Module',
                          child: _drop<String>(
                            cs: cs,
                            value: _module,
                            items: _modules,
                            onChanged:
                                (v) => setState(() => _module = v ?? _module),
                          ),
                        ),
                      ];

                      if (!isWide) return Column(children: [...left, ...right]);
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

                  _Field(
                    label: 'Description',
                    child: _tf(
                      _descCtrl,
                      cs,
                      maxLines: 6,
                      hint: 'Describe the issue, steps to reproduce, etc.',
                    ),
                  ),

                  const SizedBox(height: 8),
                  // File picker row
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickFiles,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Text('Select Files'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              _files
                                  .map(
                                    (f) => Chip(
                                      label: Text(
                                        f.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onDeleted: () => _removeFile(f),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      spacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: _clear,
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _send,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
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

  // ----------------- tiny helpers -----------------
  Widget _tf(
    TextEditingController c,
    ColorScheme cs, {
    int maxLines = 1,
    String? hint,
    TextInputType? keyboard,
  }) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      keyboardType: keyboard,
      style: TextStyle(color: cs.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: cs.surface,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.accentColor),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _drop<T>({
    required ColorScheme cs,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
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
                  .map((e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});
  final String label;
  final Widget child;

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
