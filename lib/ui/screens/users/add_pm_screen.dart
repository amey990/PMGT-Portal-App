// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// // Add below existing imports
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AddPmScreen extends StatefulWidget {
//   const AddPmScreen({super.key});

//   @override
//   State<AddPmScreen> createState() => _AddPmScreenState();
// }

// class _AddPmScreenState extends State<AddPmScreen> {
//   // sample data
//   final List<String> _projects = const [
//     'NPCI',
//     'TelstraApari',
//     'BPCL Aruba WIFI',
//   ];

//   // controllers / state
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _contactCtrl = TextEditingController();
//   final _roleCtrl = TextEditingController(text: 'Project Manager (PM)');
//   String? _assignedProject;

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     _roleCtrl.dispose();
//     super.dispose();
//   }

//   void _clear() {
//     setState(() {
//       _nameCtrl.clear();
//       _emailCtrl.clear();
//       _contactCtrl.clear();
//       _assignedProject = null;
//       _roleCtrl.text = 'Project Manager (PM)';
//     });
//   }

//   final int _selectedTab = 0;

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
//       title: 'Add Project Manager',
//       centerTitle: true,
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
//           // icon: ClipOval(
//           //   child: Image.asset(
//           //     'assets/User_profile.png',
//           //     width: 36,
//           //     height: 36,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
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
//                   // header
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Create Project Manager',
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

//                   // grid-ish layout
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 760;
//                       final gap = isWide ? 12.0 : 0.0;

//                       final left = [
//                         _TextField(label: 'Full Name *', controller: _nameCtrl),
//                         _TextField(
//                           label: 'Email *',
//                           controller: _emailCtrl,
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         _TextField(
//                           label: 'Contact No *',
//                           controller: _contactCtrl,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ];

//                       final right = [
//                         _ROText('Role', _roleCtrl),
//                         _Dropdown<String>(
//                           label: 'Assign to Projects',
//                           value: _assignedProject,
//                           items: _projects,
//                           onChanged:
//                               (v) => setState(() {
//                                 _assignedProject = v;
//                               }),
//                         ),
//                         const SizedBox(height: 48), // to balance height a bit
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

// /// ---------- Reusable compact field widgets (same look as other pages) ----------

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

// class _ROText extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _ROText(this.label, this.controller);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         enabled: false,
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

// class _Dropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
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
//           child: DropdownButton<T>(
//             value: value,
//             isExpanded: true,
//             iconEnabledColor: cs.onSurfaceVariant,
//             dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//             style: TextStyle(color: cs.onSurface, fontSize: 14),
//             items:
//                 items
//                     .map(
//                       (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
//                     )
//                     .toList(),
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
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
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// API + session
import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/state/user_session.dart';

/// Simple, non-nullable option model for projects (code/id + name)
class ProjectOption {
  final String code;
  final String name;
  const ProjectOption({required this.code, required this.name});
}

class AddPmScreen extends StatefulWidget {
  const AddPmScreen({super.key});

  @override
  State<AddPmScreen> createState() => _AddPmScreenState();
}

class _AddPmScreenState extends State<AddPmScreen> {
  // controllers / state
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _roleCtrl = TextEditingController(text: 'Project Manager (PM)');

  // options and selected values
  List<ProjectOption> _projectOptions = <ProjectOption>[];
  final Set<String> _assignedCodes = <String>{};

  bool _loadingProjects = false;
  bool _submitting = false;

  ApiClient get _api => context.read<ApiClient>();
  UserSession get _session => context.read<UserSession>();

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    _roleCtrl.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _contactCtrl.clear();
      _assignedCodes.clear();
      _roleCtrl.text = 'Project Manager (PM)';
    });
  }

  Future<void> _fetchProjects() async {
    setState(() => _loadingProjects = true);
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body) as List<dynamic>;
        final mapped = data.map((p) {
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
    } finally {
      if (mounted) setState(() => _loadingProjects = false);
    }
  }

  bool get _canSubmit =>
      _nameCtrl.text.trim().length > 1 &&
      _emailCtrl.text.trim().length > 3 &&
      _contactCtrl.text.trim().length >= 7;

  Future<void> _createPm() async {
    if (!_canSubmit) {
      _toast('Full name, email and contact number are required');
      return;
    }
    setState(() => _submitting = true);
    try {
      final payload = {
        'full_name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'contact_no': _contactCtrl.text.trim(),
        'project_codes': _assignedCodes.toList(),
      };

      final res = await _api.post('/api/project-managers', body: payload);

      if (res.statusCode == 409) {
        _toast('A project manager with that email already exists');
      } else if (res.statusCode >= 200 && res.statusCode < 300) {
        _toast('Project manager created', success: true);
        _clear();
      } else {
        _toast('Failed to create project manager');
      }
    } catch (_) {
      _toast('Failed to create project manager');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    final bg = success ? const Color(0xFF2E7D32)
        : (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF5E2A2A)
            : const Color(0xFFFFE9E9));
    final fg = success ? Colors.white : cs.onSurface;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: TextStyle(color: fg)), backgroundColor: bg),
    );
  }

  // bottom-nav
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

  Future<void> _pickProjects() async {
    if (_projectOptions.isEmpty) return;
    final selected = Set<String>.from(_assignedCodes);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, controller) {
            final cs = Theme.of(context).colorScheme;
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                children: [
                  Container(
                    width: 36, height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Text('Assign to Projects',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: _projectOptions.length,
                      itemBuilder: (context, i) {
                        final p = _projectOptions[i];
                        final checked = selected.contains(p.code);
                        return CheckboxListTile(
                          value: checked,
                          onChanged: (v) {
                            if (v == true) {
                              selected.add(p.code);
                            } else {
                              selected.remove(p.code);
                            }
                            // force rebuild of the bottom sheet
                            (context as Element).markNeedsBuild();
                          },
                          title: Text(p.name),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppTheme.accentColor,
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
                          Navigator.pop(context);
                          setState(() {
                            _assignedCodes
                              ..clear()
                              ..addAll(selected);
                          });
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Render comma-separated selected project names
    final selectedNames = _projectOptions
        .where((p) => _assignedCodes.contains(p.code))
        .map((p) => p.name)
        .toList();

    return MainLayout(
      title: 'Add Project Manager',
      centerTitle: true,
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
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: _handleTabChange,
      safeArea: false,
      reserveBottomPadding: true,
      body: ListView(
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
                  // header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create Project Manager',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      TextButton(onPressed: _clear, child: const Text('Clear')),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // grid-ish layout
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
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
                        _ROText('Role', _roleCtrl),
                        _FieldShell(
                          label: 'Assign to Projects',
                          child: InkWell(
                            onTap: _loadingProjects ? null : _pickProjects,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: cs.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: cs.outlineVariant),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _loadingProjects
                                        ? Text('Loading…', style: TextStyle(color: cs.onSurfaceVariant))
                                        : Text(
                                            selectedNames.isEmpty
                                                ? 'Select'
                                                : selectedNames.join(', '),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: selectedNames.isEmpty
                                                  ? cs.onSurfaceVariant
                                                  : cs.onSurface,
                                            ),
                                          ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48), // balance height a bit
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
                        onPressed: _submitting ? null : _createPm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          _submitting ? 'Creating…' : 'Create',
                          style: const TextStyle(fontWeight: FontWeight.w800),
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

/* ---------- Reusable compact field widgets ---------- */

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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}
