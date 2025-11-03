// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/api_client.dart';

// /// Roles this modal supports.
// enum RoleKind { pm, bdm, noc, scm }

// extension _RoleKindX on RoleKind {
//   String get label {
//     switch (this) {
//       case RoleKind.pm:
//         return 'Project Manager';
//       case RoleKind.bdm:
//         return 'BDM';
//       case RoleKind.noc:
//         return 'NOC';
//       case RoleKind.scm:
//         return 'SCM';
//     }
//   }

//   /// API path segment used on web.
//   String get urlKey {
//     switch (this) {
//       case RoleKind.pm:
//         return 'project-managers';
//       case RoleKind.bdm:
//         return 'bdms';
//       case RoleKind.noc:
//         return 'nocs';
//       case RoleKind.scm:
//         return 'scms';
//     }
//   }
// }

// /// Data needed to open the modal (taken from your card)
// class UpdateUserPayload {
//   final RoleKind role;
//   final String name;
//   final String email;
//   final String contact;
//   /// Displayed projects (comma-separated names) as you show in the list.
//   final String projectsDisplay;

//   UpdateUserPayload({
//     required this.role,
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projectsDisplay,
//   });
// }

// class UpdateUserModal extends StatefulWidget {
//   final UpdateUserPayload user;

//   const UpdateUserModal({super.key, required this.user});

//   /// Convenience opener
//   static Future<bool?> show(
//     BuildContext context, {
//     required UpdateUserPayload user,
//   }) {
//     return showModalBottomSheet<bool>(
//       context: context,
//       useSafeArea: true,
//       isScrollControlled: true,
//       showDragHandle: true,
//       builder: (_) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: UpdateUserModal(user: user),
//       ),
//     );
//   }

//   @override
//   State<UpdateUserModal> createState() => _UpdateUserModalState();
// }

// class _UpdateUserModalState extends State<UpdateUserModal> {
//   final _formKey = GlobalKey<FormState>();

//   late final TextEditingController _nameCtrl;
//   late final TextEditingController _emailCtrl;
//   late final TextEditingController _contactCtrl;

//   // projects: code->name map, chosen codes, and easy display names
//   final Map<String, String> _projectMap = {};
//   final Set<String> _selectedCodes = {};
//   bool _loading = false;
//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();
//     _nameCtrl = TextEditingController(text: widget.user.name);
//     _emailCtrl = TextEditingController(text: widget.user.email);
//     _contactCtrl = TextEditingController(text: widget.user.contact);
//     _loadProjectsAndSeed();
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     super.dispose();
//   }

//   ApiClient get _api => context.read<ApiClient>();

//   Future<void> _loadProjectsAndSeed() async {
//     setState(() => _loading = true);
//     try {
//       final res = await _api.get('/api/projects');
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
//         _projectMap
//           ..clear()
//           ..addEntries(list.map((p) => MapEntry(
//                 (p['project_code'] ?? '').toString(),
//                 (p['project_name'] ?? '').toString(),
//               )));
//         // seed selection by matching names we displayed on the list
//         final names = widget.user.projectsDisplay
//             .split(',')
//             .map((s) => s.trim())
//             .where((s) => s.isNotEmpty)
//             .toSet();
//         _selectedCodes
//           ..clear()
//           ..addAll(_projectMap.entries
//               .where((e) => names.contains(e.value))
//               .map((e) => e.key));
//       }
//     } catch (_) {
//       // ignore; user can still select
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   Future<void> _save() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _saving = true);
//     try {
//       final urlKey = widget.user.role.urlKey;
//       final res = await _api.put(
//         '/api/$urlKey/${Uri.encodeComponent(_emailCtrl.text.trim())}',
//         body: {
//           'full_name': _nameCtrl.text.trim(),
//           'contact_no': _contactCtrl.text.trim(),
//           'project_codes': _selectedCodes.toList(),
//         },
//       );
//       if (!mounted) return;
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         Navigator.pop(context, true); // indicate success
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Update failed (${res.statusCode})')));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => _saving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Update ${widget.user.role.label}', style: Theme.of(context).textTheme.titleLarge),
//               const SizedBox(height: 16),

//               // grid-ish form
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _nameCtrl,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                       validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _emailCtrl,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       readOnly: true, // identifier
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _contactCtrl,
//                       decoration: const InputDecoration(labelText: 'Contact No'),
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Projects multiselect (very lightweight—chips-like)
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('Projects', style: Theme.of(context).textTheme.bodySmall),
//               ),
//               const SizedBox(height: 6),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: cs.outlineVariant),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child: _loading && _projectMap.isEmpty
//                     ? const SizedBox(
//                         height: 40, child: Center(child: CircularProgressIndicator(strokeWidth: 2)))
//                     : Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: _projectMap.entries.map((e) {
//                           final selected = _selectedCodes.contains(e.key);
//                           return FilterChip(
//                             label: Text(e.value, overflow: TextOverflow.ellipsis),
//                             selected: selected,
//                             onSelected: (v) {
//                               setState(() {
//                                 if (v) {
//                                   _selectedCodes.add(e.key);
//                                 } else {
//                                   _selectedCodes.remove(e.key);
//                                 }
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//               ),
//               const SizedBox(height: 16),

//               Row(
//                 children: [
//                   Expanded(
//                     child: FilledButton(
//                       onPressed: _saving ? null : _save,
//                       child: _saving
//                           ? const SizedBox(
//                               height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
//                           : const Text('Update'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api_client.dart';

enum RoleKind { pm, bdm, noc, scm }

extension _RoleKindX on RoleKind {
  String get label {
    switch (this) {
      case RoleKind.pm:
        return 'Project Manager';
      case RoleKind.bdm:
        return 'BDM';
      case RoleKind.noc:
        return 'NOC';
      case RoleKind.scm:
        return 'SCM';
    }
  }

  String get urlKey {
    switch (this) {
      case RoleKind.pm:
        return 'project-managers';
      case RoleKind.bdm:
        return 'bdms';
      case RoleKind.noc:
        return 'nocs';
      case RoleKind.scm:
        return 'scms';
    }
  }
}

class UpdateUserPayload {
  final RoleKind role;
  final String name;
  final String email;
  final String contact;
  final String projectsDisplay; // comma-separated names shown in list

  UpdateUserPayload({
    required this.role,
    required this.name,
    required this.email,
    required this.contact,
    required this.projectsDisplay,
  });
}

class UpdateUserModal extends StatefulWidget {
  final UpdateUserPayload user;

  const UpdateUserModal({super.key, required this.user});

  static Future<bool?> show(
    BuildContext context, {
    required UpdateUserPayload user,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      builder:
          (_) => FractionallySizedBox(
            heightFactor: .92,
            child: UpdateUserModal(user: user),
          ),
    );
  }

  @override
  State<UpdateUserModal> createState() => _UpdateUserModalState();
}

class _UpdateUserModalState extends State<UpdateUserModal> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _contactCtrl;

  // projects: code->name map & selected codes
  final Map<String, String> _projectMap = {};
  final Set<String> _selectedCodes = {};

  bool _loading = false;
  bool _saving = false;

  ApiClient get _api => context.read<ApiClient>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _emailCtrl = TextEditingController(text: widget.user.email);
    _contactCtrl = TextEditingController(text: widget.user.contact);
    _loadProjectsAndSeed();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProjectsAndSeed() async {
    setState(() => _loading = true);
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
        _projectMap
          ..clear()
          ..addEntries(
            list.map(
              (p) => MapEntry(
                (p['project_code'] ?? '').toString(),
                (p['project_name'] ?? '').toString(),
              ),
            ),
          );

        // seed selection by matching names we display on the list
        final names =
            widget.user.projectsDisplay
                .split(',')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toSet();

        _selectedCodes
          ..clear()
          ..addAll(
            _projectMap.entries
                .where((e) => names.contains(e.value))
                .map((e) => e.key),
          );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final res = await _api.put(
        '/api/${widget.user.role.urlKey}/${Uri.encodeComponent(_emailCtrl.text.trim())}',
        body: {
          'full_name': _nameCtrl.text.trim(),
          'contact_no': _contactCtrl.text.trim(),
          'project_codes': _selectedCodes.toList(),
        },
      );
      if (!mounted) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed (${res.statusCode})')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _projectsLabel() {
    if (_selectedCodes.isEmpty) return 'Select projects';
    final names =
        _selectedCodes.map((c) => _projectMap[c] ?? c).toList()..sort();
    return names.join(', ');
  }

  Future<void> _openProjectPicker() async {
    if (_loading) return;
    final temp = _selectedCodes.toSet();
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      builder: (_) {
        final entries =
            _projectMap.entries.toList()
              ..sort((a, b) => a.value.compareTo(b.value));
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Text(
                      'Select Projects',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (_, i) {
                    final e = entries[i];
                    final checked = temp.contains(e.key);
                    return CheckboxListTile(
                      value: checked,
                      onChanged: (v) {
                        setState(() {
                          if (v == true)
                            temp.add(e.key);
                          else
                            temp.remove(e.key);
                        });
                      },
                      title: Text(e.value),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
    setState(() {
      _selectedCodes
        ..clear()
        ..addAll(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          top: 8,
        ),
        child: Column(
          children: [
            Text(
              'Update ${widget.user.role.label}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),

            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              validator:
                                  (v) =>
                                      (v == null || v.trim().isEmpty)
                                          ? 'Required'
                                          : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _emailCtrl,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _contactCtrl,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Contact No',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              initialValue: widget.user.role.label,
                              decoration: const InputDecoration(
                                labelText: 'Role',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Multi-select dropdown (projects)
                      GestureDetector(
                        onTap: _openProjectPicker,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Projects',
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                            ),
                            controller: TextEditingController(
                              text: _projectsLabel(),
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child:
                    _saving
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
