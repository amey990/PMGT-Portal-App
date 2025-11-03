// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AddBdmScreen extends StatefulWidget {
//   const AddBdmScreen({super.key});

//   @override
//   State<AddBdmScreen> createState() => _AddBdmScreenState();
// }

// class _AddBdmScreenState extends State<AddBdmScreen> {
//   // form state
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _phoneCtrl = TextEditingController();
//   String? _assignedProject;

//   // sample projects
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _phoneCtrl.dispose();
//     super.dispose();
//   }

//   void _clear() {
//     setState(() {
//       _nameCtrl.clear();
//       _emailCtrl.clear();
//       _phoneCtrl.clear();
//       _assignedProject = null;
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
//     final pad = responsivePadding(context);

//     return MainLayout(
//       title: 'Add BDM',
//       centerTitle: true,
//       // top-right actions (theme toggle + profile), consistent with other pages
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
// onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: ListView(
//         padding: pad.copyWith(top: 12, bottom: 12),
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
//                           'Create BDM',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleLarge?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clear, child: const Text('CLEAR')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // grid-like layout (2 columns on wide, stacked on narrow)
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640;
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
//                           controller: _phoneCtrl,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ];

//                       final right = [
//                         _ROText(
//                           label: 'Role',
//                           value:
//                               'Business Development Manager (BDM)', // read-only
//                         ),
//                         _Dropdown<String>(
//                           label: 'Assign to Projects',
//                           value: _assignedProject,
//                           items: _projects,
//                           onChanged:
//                               (v) => setState(() => _assignedProject = v),
//                         ),
//                         const SizedBox(height: 1),
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
//                             const SnackBar(content: Text('BDM Created'))
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

// /* ---------- small UI helpers (consistent with other screens) ---------- */

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
//   final String value;
//   const _ROText({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: TextEditingController(text: value),
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
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// Bottom-nav targets
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';

// API + session
import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/state/user_session.dart';

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

  // project options + selected
  List<_ProjectOption> _projectOptions = [];
  final List<String> _assignedCodes = [];

  // ui
  bool _busy = false;

  ApiClient get _api => context.read<ApiClient>();
  UserSession get _session => context.read<UserSession>();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final arr = jsonDecode(res.body) as List<dynamic>;
        setState(() {
          _projectOptions = arr.map<_ProjectOption>((p) {
            final m = p as Map<String, dynamic>;
            final code = (m['project_code'] ?? m['id'] ?? '').toString();
            final name = (m['project_name'] ?? '').toString();
            return _ProjectOption(code: code, name: name);
          }).where((e) => e.code.isNotEmpty && e.name.isNotEmpty).toList();
        });
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
      _phoneCtrl.clear();
      _assignedCodes.clear();
    });
  }

  bool get _canSubmit {
    final n = _nameCtrl.text.trim();
    final e = _emailCtrl.text.trim();
    final p = _phoneCtrl.text.trim();
    final emailOk = RegExp(r'^\S+@\S+\.\S+$').hasMatch(e);
    return n.length > 1 && emailOk && p.length >= 7;
  }

  Future<void> _createBDM() async {
    if (!_canSubmit) {
      _toast('Please fill Full Name, valid Email and Contact No.');
      return;
    }

    setState(() => _busy = true);
    try {
      final payload = {
        'full_name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'contact_no': _phoneCtrl.text.trim(),
        'project_codes': _assignedCodes, // multiple selection
      };

      final res = await _api.post('/api/bdms', body: payload);

      if (res.statusCode == 409) {
        _toast('A BDM with that email already exists.');
      } else if (res.statusCode >= 200 && res.statusCode < 300) {
        _toast('BDM created successfully', success: true);
        _clear();
      } else {
        _toast('Failed to create BDM. Please try again.');
      }
    } catch (_) {
      _toast('Failed to create BDM. Please try again.');
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

  // --- Project picker (multi-select) ---
  Future<void> _pickProjects() async {
    final selected = Set<String>.from(_assignedCodes);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              top: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text('Assign to Projects',
                    style: Theme.of(ctx)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.55,
                  child: ListView.builder(
                    itemCount: _projectOptions.length,
                    itemBuilder: (_, i) {
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
                          // trigger rebuild of bottom sheet list
                          (ctx as Element).markNeedsBuild();
                        },
                        title: Text(p.name),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _assignedCodes
                            ..clear()
                            ..addAll(selected);
                        });
                        Navigator.pop(ctx);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Done'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // bottom nav
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
    final pad = responsivePadding(context);

    return MainLayout(
      title: 'Add BDM',
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
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: _handleTabChange,
      safeArea: false,
      reserveBottomPadding: true,
      body: Stack(
        children: [
          ListView(
            padding: pad.copyWith(top: 12, bottom: 12),
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
                              'Create BDM',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w800),
                            ),
                          ),
                          TextButton(onPressed: _clear, child: const Text('CLEAR')),
                        ],
                      ),
                      Divider(color: cs.outlineVariant),

                      // grid layout
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
                            const _ROText(
                              label: 'Role',
                              value: 'Business Development Manager (BDM)',
                            ),
                            _ProjectPickerField(
                              label: 'Assign to Projects',
                              selectedNames: _projectOptions
                                  .where((p) => _assignedCodes.contains(p.code))
                                  .map((p) => p.name)
                                  .toList(),
                              onTap: _projectOptions.isEmpty ? null : _pickProjects,
                            ),
                            const SizedBox(height: 1),
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
                            onPressed: _busy ? null : _createBDM,
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

/* ---------- models & small UI helpers ---------- */

class _ProjectOption {
  final String code;
  final String name;
  const _ProjectOption({required this.code, required this.name});
}

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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}

class _ProjectPickerField extends StatelessWidget {
  final String label;
  final List<String> selectedNames;
  final VoidCallback? onTap;
  const _ProjectPickerField({
    required this.label,
    required this.selectedNames,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = selectedNames.isEmpty ? 'Select' : selectedNames.join(', ');
    final hintColor =
        selectedNames.isEmpty ? cs.onSurfaceVariant : cs.onSurface;

    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: onTap,
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
                child: Text(text, style: TextStyle(color: hintColor)),
              ),
              Icon(Icons.expand_more, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
