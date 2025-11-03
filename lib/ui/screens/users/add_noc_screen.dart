// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../../screens/profile/profile_screen.dart';
// import '../../../core/theme_controller.dart';
// // Add below existing imports
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AddNocScreen extends StatefulWidget {
//   const AddNocScreen({super.key});

//   @override
//   State<AddNocScreen> createState() => _AddNocScreenState();
// }

// class _AddNocScreenState extends State<AddNocScreen> {
//   // form controllers
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _contactCtrl = TextEditingController();

//   // sample projects
//   final List<String> _projects = const [
//     'NPCI',
//     'TelstraApari',
//     'BPCL Aruba WIFI',
//   ];
//   List<String> _assigned = [];

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     super.dispose();
//   }

//   void _clear() {
//     setState(() {
//       _nameCtrl.clear();
//       _emailCtrl.clear();
//       _contactCtrl.clear();
//       _assigned = [];
//     });
//   }
// final int _selectedTab = 0;

// void _handleTabChange(int i) {
//   if (i == _selectedTab) return;
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen(); break;
//     case 1: target = const AddProjectScreen(); break;
//     case 2: target = const AddActivityScreen(); break;
//     case 3: target = const AnalyticsScreen(); break;
//     case 4: target = const ViewUsersScreen(); break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
// }
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add NOC',
//       centerTitle: true,
//       // AppBar actions (theme toggle + profile) — same as other pages
//       actions: [
//         IconButton(
//           tooltip:
//               Theme.of(context).brightness == Brightness.dark
//                   ? 'Light mode'
//                   : 'Dark mode',
//           icon: Icon(
//             Theme.of(context).brightness == Brightness.dark
//                 ? Icons.light_mode_outlined
//                 : Icons.dark_mode_outlined,
//             color: cs.onSurface,
//           ),
//           onPressed: () => ThemeScope.of(context).toggle(),
//         ),
//         IconButton(
//           tooltip: 'Profile',
//           onPressed: () {
//             Navigator.of(
//               context,
//             ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
         
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
     
//       currentIndex: _selectedTab,
// onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           Card(
//             color: cs.surfaceContainerHighest,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Header row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Create NOC',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleLarge?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clear, child: const Text('Clear')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // fields (2-column on wide, stacked on mobile)
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640;
//                       final gap = isWide ? 12.0 : 0.0;

//                       final left = [
//                         _TextField(label: 'Full Name *', controller: _nameCtrl),
//                         _TextField(label: 'Email *', controller: _emailCtrl),
//                         _TextField(
//                           label: 'Contact No *',
//                           controller: _contactCtrl,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ];

//                       final right = [
//                         const _ReadOnlyField(
//                           label: 'Role',
//                           value: 'Network Operations Center Engineer (NOC)',
//                         ),
//                         _MultiSelectDropdown(
//                           label: 'Assign to Projects',
//                           items: _projects,
//                           selected: _assigned,
//                           onChanged: (v) => setState(() => _assigned = v),
//                         ),
//                       ];

//                       if (!isWide) {
//                         return Column(children: [...left, ...right]);
//                       }
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(child: Column(children: left)),
//                           SizedBox(width: gap),
//                           Expanded(child: Column(children: right)),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 16),
//                   // wide create button aligned to right (similar to Save on Add Project)
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(minWidth: 220),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // TODO: hook actual create
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('PM Created')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Create',
//                           style: TextStyle(fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ------------ small UI helpers (same look/feel as other add pages) ------------

// class _FieldShell extends StatelessWidget {
//   final String label;
//   final Widget child;
//   const _FieldShell({required this.label, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: cs.onSurfaceVariant,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 6),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _TextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ReadOnlyField extends StatelessWidget {
//   final String label;
//   final String value;
//   const _ReadOnlyField({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         enabled: false,
//         controller: TextEditingController(text: value),
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _MultiSelectDropdown extends StatelessWidget {
//   final String label;
//   final List<String> items;
//   final List<String> selected;
//   final ValueChanged<List<String>> onChanged;
//   const _MultiSelectDropdown({
//     required this.label,
//     required this.items,
//     required this.selected,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return _FieldShell(
//       label: label,
//       child: Container(
//         decoration: BoxDecoration(
//           color: cs.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             isExpanded: true,
//             value: null,
//             iconEnabledColor: cs.onSurfaceVariant,
//             dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//             hint: Text(
//               selected.isEmpty ? 'Assign to Projects' : selected.join(', '),
//               style: TextStyle(
//                 color: selected.isEmpty ? cs.onSurfaceVariant : cs.onSurface,
//               ),
//             ),
//             items:
//                 items
//                     .map(
//                       (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
//                     )
//                     .toList(),
//             onChanged: (v) {
//               if (v == null) return;
//               final next = [...selected];
//               if (next.contains(v)) {
//                 next.remove(v);
//               } else {
//                 next.add(v);
//               }
//               onChanged(next);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../../screens/profile/profile_screen.dart';
import '../../../core/theme_controller.dart';

// Bottom-nav targets
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// API
import 'package:pmgt/core/api_client.dart';

/// Simple option model for the “Assign to Projects” control
class ProjectOption {
  final String code; // project_code OR id
  final String name; // project_name
  ProjectOption({required this.code, required this.name});
}

class AddNocScreen extends StatefulWidget {
  const AddNocScreen({super.key});

  @override
  State<AddNocScreen> createState() => _AddNocScreenState();
}

class _AddNocScreenState extends State<AddNocScreen> {
  // form controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  // loaded from API
  List<ProjectOption> _projectOptions = [];
  // store selected project codes
  List<String> _assignedCodes = [];

  bool _busy = false;

  ApiClient get _api => context.read<ApiClient>();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = (jsonDecode(res.body) as List?) ?? [];
        final mapped = list.map((p) {
          final m = p as Map<String, dynamic>;
          final code = (m['project_code'] ?? m['id'] ?? '').toString();
          final name = (m['project_name'] ?? '').toString();
          return ProjectOption(code: code, name: name);
        }).where((e) => e.code.isNotEmpty && e.name.isNotEmpty).toList();
        setState(() => _projectOptions = mapped);
      } else {
        setState(() => _projectOptions = []);
      }
    } catch (_) {
      setState(() => _projectOptions = []);
    }
  }

  void _clear() {
    setState(() {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _contactCtrl.clear();
      _assignedCodes = [];
    });
  }

  bool get _canSubmit {
    final nameOk = _nameCtrl.text.trim().length > 1;
    final emailOk = RegExp(r'^\S+@\S+\.\S+$').hasMatch(_emailCtrl.text.trim());
    final phoneOk = _contactCtrl.text.trim().length >= 7;
    return nameOk && emailOk && phoneOk;
  }

  Future<void> _createNoc() async {
    if (!_canSubmit) {
      _toast('Please fill Full Name, valid Email and Contact No.');
      return;
    }
    setState(() => _busy = true);
    try {
      final payload = {
        'full_name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'contact_no': _contactCtrl.text.trim(),
        'project_codes': _assignedCodes,
      };
      final res = await _api.post('/api/nocs', body: payload);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        _toast('NOC created successfully', success: true);
        _clear();
      } else if (res.statusCode == 409) {
        _toast('A NOC with that email already exists.');
      } else {
        _toast('Failed to create NOC. Please try again.');
      }
    } catch (_) {
      _toast('Failed to create NOC. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    final bg = success
        ? const Color(0xFF2E7D32)
        : (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF5E2A2A)
            : const Color(0xFFFFE9E9));
    final fg = success ? Colors.white : cs.onSurface;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: TextStyle(color: fg)), backgroundColor: bg),
    );
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add NOC',
      centerTitle: true,
      actions: [
        IconButton(
          tooltip:
              Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: (i) => _handleTabChange(i),
      safeArea: false,
      reserveBottomPadding: true,
      body: Stack(
        children: [
          ListView(
            padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
            children: [
              Card(
                color: cs.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                              'Create NOC',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w800),
                            ),
                          ),
                          TextButton(onPressed: _clear, child: const Text('Clear')),
                        ],
                      ),
                      Divider(color: cs.outlineVariant),

                      // fields (2-column on wide, stacked on mobile)
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
                              controller: _contactCtrl,
                              keyboardType: TextInputType.phone,
                            ),
                          ];

                          final right = [
                            const _ReadOnlyField(
                              label: 'Role',
                              value: 'Network Operations Center Engineer (NOC)',
                            ),
                            _MultiProjectPicker(
                              label: 'Assign to Projects',
                              options: _projectOptions,
                              selectedCodes: _assignedCodes,
                              onChanged: (codes) => setState(() => _assignedCodes = codes),
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

                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 220),
                          child: ElevatedButton(
                            onPressed: _busy ? null : _createNoc,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.black,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(_busy ? 'Creating…' : 'Create',
                                style: const TextStyle(fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (_busy)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.25),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

/// ------------ small UI helpers (same look/feel as other add pages) ------------

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
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
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
  const _TextField({required this.label, required this.controller, this.keyboardType});

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
            borderSide: const BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        enabled: false,
        controller: TextEditingController(text: value),
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}

/// Multi-select using a bottom sheet; displays chosen project names inline
class _MultiProjectPicker extends StatelessWidget {
  final String label;
  final List<ProjectOption> options;
  final List<String> selectedCodes;
  final ValueChanged<List<String>> onChanged;

  const _MultiProjectPicker({
    required this.label,
    required this.options,
    required this.selectedCodes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final selectedNames = options
        .where((p) => selectedCodes.contains(p.code))
        .map((p) => p.name)
        .toList();

    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: () => _pickProjects(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedNames.isEmpty ? 'Select' : selectedNames.join(', '),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selectedNames.isEmpty ? cs.onSurfaceVariant : cs.onSurface,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickProjects(BuildContext context) async {
    final temp = {...selectedCodes};
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text('Assign to Projects',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (_, i) {
                      final p = options[i];
                      final checked = temp.contains(p.code);
                      return CheckboxListTile(
                        dense: true,
                        value: checked,
                        onChanged: (v) {
                          if (v == true) {
                            temp.add(p.code);
                          } else {
                            temp.remove(p.code);
                          }
                          // trigger rebuild of the bottom sheet list tile
                          (context as Element).markNeedsBuild();
                        },
                        title: Text(p.name),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        onChanged(temp.toList());
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
