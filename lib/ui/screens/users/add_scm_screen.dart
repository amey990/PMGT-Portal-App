// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../../../core/theme_controller.dart';
// import '../profile/profile_screen.dart';
// // Add after existing imports
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AddScmScreen extends StatefulWidget {
//   const AddScmScreen({super.key});

//   @override
//   State<AddScmScreen> createState() => _AddScmScreenState();
// }

// class _AddScmScreenState extends State<AddScmScreen> {
//   // sample projects list
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

//   // form state
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _contactCtrl = TextEditingController();
//   String? _assignProject;

//   static const String _roleLabel = 'Supply Chain Manager (SCM)';

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
//       _assignProject = null;
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
//       title: 'Add SCM',
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
//                           'Create SCM',
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

//                   // form grid
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
//                           controller: _contactCtrl,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ];

//                       final right = [
//                         _ROText('Role', _roleLabel),
//                         _Dropdown<String>(
//                           label: 'Assign to Projects',
//                           value: _assignProject,
//                           items: _projects,
//                           onChanged: (v) => setState(() => _assignProject = v),
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

// /// ---------- small UI helpers (consistent with other pages) ----------

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
//   const _ROText(this.label, this.value);

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
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../../../core/theme_controller.dart';
import '../profile/profile_screen.dart';

// bottom-nav targets
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// API & session
import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/state/user_session.dart';

class AddScmScreen extends StatefulWidget {
  const AddScmScreen({super.key});

  @override
  State<AddScmScreen> createState() => _AddScmScreenState();
}

class _AddScmScreenState extends State<AddScmScreen> {
  // form state
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  static const String _roleLabel = 'Supply Chain Manager (SCM)';

  // projects (code + name) and selected codes
  List<_ProjectOpt> _projectOptions = [];
  List<String> _assignedCodes = [];

  bool _submitting = false;
  bool _loadingProjects = false;

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
    _contactCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    setState(() => _loadingProjects = true);
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final arr = jsonDecode(res.body) as List;
        final mapped = <_ProjectOpt>[
          for (final p in arr)
            _ProjectOpt(
              code: (p['project_code'] ?? p['id'] ?? '').toString(),
              name: (p['project_name'] ?? '').toString(),
            ),
        ]..removeWhere((e) => e.code.isEmpty || e.name.isEmpty);
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

  Future<void> _createScm() async {
    if (!_canSubmit) {
      _toast('Please fill Full Name, valid Email and Contact No.');
      return;
    }

    setState(() => _submitting = true);
    try {
      final res = await _api.post('/api/scms', body: {
        'full_name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'contact_no': _contactCtrl.text.trim(),
        'project_codes': _assignedCodes, // codes (or ids) accepted by backend
      });

      if (res.statusCode == 409) {
        _toast('An SCM with that email already exists');
        return;
      }

      if (res.statusCode >= 200 && res.statusCode < 300) {
        _toast('SCM created successfully', success: true);
        _clear();
      } else {
        _toast('Failed to create SCM');
      }
    } catch (_) {
      _toast('Failed to create SCM');
    } finally {
      if (mounted) setState(() => _submitting = false);
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

  // bottom-nav
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
      title: 'Add SCM',
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
                              'Create SCM',
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

                      // form grid
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
                            _ROText('Role', _roleLabel),
                            _ProjectMultiPicker(
                              label: 'Assign to Projects',
                              options: _projectOptions,
                              selectedCodes: _assignedCodes,
                              loading: _loadingProjects,
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

                      // submit
                      Align(
                        alignment: Alignment.centerRight,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 220),
                          child: ElevatedButton(
                            onPressed: _submitting ? null : _createScm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.black,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: _submitting
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Create',
                                    style: TextStyle(fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_submitting)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.15),
              ),
            ),
        ],
      ),
    );
  }
}

/* ---------------------- small UI & models ---------------------- */

class _ProjectOpt {
  final String code;
  final String name;
  _ProjectOpt({required this.code, required this.name});
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
          Text(
            label,
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600),
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
  const _ROText(this.label, this.value);

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

class _ProjectMultiPicker extends StatelessWidget {
  final String label;
  final List<_ProjectOpt> options;
  final List<String> selectedCodes;
  final bool loading;
  final ValueChanged<List<String>> onChanged;

  const _ProjectMultiPicker({
    required this.label,
    required this.options,
    required this.selectedCodes,
    required this.onChanged,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final selectedNames = [
      for (final c in selectedCodes)
        options.firstWhere((o) => o.code == c, orElse: () => _ProjectOpt(code: c, name: c)).name
    ];

    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: loading ? null : () => _openPicker(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  loading
                      ? 'Loading projects…'
                      : (selectedCodes.isEmpty ? 'Assign to Projects' : selectedNames.join(', ')),
                  style: TextStyle(
                    color: loading
                        ? cs.onSurfaceVariant
                        : (selectedCodes.isEmpty ? cs.onSurfaceVariant : cs.onSurface),
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

  Future<void> _openPicker(BuildContext context) async {
    final next = List<String>.from(selectedCodes);

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
                Row(
                  children: [
                    const Expanded(
                      child: Text('Select Projects', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (_, i) {
                      final opt = options[i];
                      final checked = next.contains(opt.code);
                      return CheckboxListTile(
                        value: checked,
                        title: Text(opt.name),
                        onChanged: (v) {
                          if (v == true) {
                            if (!next.contains(opt.code)) next.add(opt.code);
                          } else {
                            next.remove(opt.code);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onChanged(next);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
