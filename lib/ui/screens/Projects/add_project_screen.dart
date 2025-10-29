// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';

// // If you already define this elsewhere, remove this line.
// const String kApiBase = String.fromEnvironment('API_BASE', defaultValue: '');

// class AddProjectScreen extends StatefulWidget {
//   const AddProjectScreen({super.key});

//   @override
//   State<AddProjectScreen> createState() => _AddProjectScreenState();
// }

// class _AddProjectScreenState extends State<AddProjectScreen> {
//   // --- Controllers ---
//   final _projectCodeCtrl = TextEditingController(); // readonly, auto from name
//   final _projectNameCtrl = TextEditingController();

//   DateTime? _startDate;
//   DateTime? _endDate;

//   // dropdown values
//   String? _customer;
//   String? _projectType;
//   String? _projectManager; // store PM full_name (matches web)
//   String? _bdm; // store BDM full_name
//   String? _amcYear;
//   String? _amcMonths;

//   // Sub-projects
//   final List<String> _subProjects = [];

//   // Lookups (loaded from API)
//   List<String> _customers = const [];
//   List<String> _pms = const []; // full_name
//   List<String> _bdms = const []; // full_name

//   // Enums
//   final List<String> _types = const [
//     'Implementation',
//     'Upgrade',
//     'Maintenance',
//   ];
//   final List<String> _years = List<String>.generate(6, (i) => '$i'); // 0..5
//   final List<String> _months = List<String>.generate(12, (i) => '$i'); // 0..11

//   bool _loadingLookups = false;
//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();
//     // Auto project code from name
//     _projectNameCtrl.addListener(_autoCodeFromName);
//     _loadLookups();
//   }

//   @override
//   void dispose() {
//     _projectCodeCtrl.dispose();
//     _projectNameCtrl.removeListener(_autoCodeFromName);
//     _projectNameCtrl.dispose();
//     super.dispose();
//   }

//   // ───────────────────── Networking helpers ─────────────────────
//   Future<http.Response> _get(String path) async {
//     final uri = Uri.parse('$kApiBase$path');
//     return http.get(uri); // add auth header if needed
//   }

//   Future<http.Response> _post(String path, Map<String, dynamic> body) async {
//     final uri = Uri.parse('$kApiBase$path');
//     return http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );
//   }

//   Future<void> _loadLookups() async {
//     setState(() => _loadingLookups = true);
//     try {
//       // Customers
//       try {
//         final r = await _get('/api/customers');
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body) as Map<String, dynamic>;
//           final arr = (j['customers'] as List?) ?? [];
//           _customers =
//               arr
//                   .map((e) => (e['company_name'] ?? '').toString())
//                   .where((s) => s.isNotEmpty)
//                   .cast<String>()
//                   .toList();
//         }
//       } catch (_) {}

//       // Project Managers
//       try {
//         final r = await _get('/api/project-managers');
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body);
//           final list = (j is List ? j : (j['project_managers'] as List?)) ?? [];
//           _pms =
//               list
//                   .map((e) => (e['full_name'] ?? '').toString())
//                   .where((s) => s.isNotEmpty)
//                   .cast<String>()
//                   .toList();
//         }
//       } catch (_) {}

//       // BDMs
//       try {
//         final r = await _get('/api/bdms');
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body);
//           final list = (j is List ? j : (j['bdms'] as List?)) ?? [];
//           _bdms =
//               list
//                   .map((e) => (e['full_name'] ?? '').toString())
//                   .where((s) => s.isNotEmpty)
//                   .cast<String>()
//                   .toList();
//         }
//       } catch (_) {}
//     } finally {
//       if (mounted) setState(() => _loadingLookups = false);
//     }
//   }

//   // ───────────────────── UI helpers ─────────────────────
//   void _autoCodeFromName() {
//     final name = _projectNameCtrl.text.trim();
//     _projectCodeCtrl.text = name.isEmpty ? '' : '$name-CSPL';
//   }

//   void _clearAll() {
//     setState(() {
//       _customer = null;
//       _projectType = null;
//       _projectManager = null;
//       _bdm = null;
//       _amcYear = null;
//       _amcMonths = null;
//       _subProjects.clear();

//       _projectNameCtrl.clear();
//       _projectCodeCtrl.clear();
//       _startDate = null;
//       _endDate = null;
//     });
//   }

//   Future<void> _pickDate({required bool isStart}) async {
//     final now = DateTime.now();
//     final init = isStart ? (_startDate ?? now) : (_endDate ?? now);
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           _startDate = picked;
//           if (_endDate != null && _endDate!.isBefore(_startDate!)) {
//             _endDate = _startDate;
//           }
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }

//   String _fmtIso(DateTime d) =>
//       '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 1) return; // already on Add Project
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 2:
//         target = const AddActivityScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   Future<void> _onSave() async {
//     // Validate required
//     final missing = <String>[];
//     if ((_customer ?? '').isEmpty) missing.add('Customer Name');
//     if (_projectNameCtrl.text.trim().isEmpty) missing.add('Project Name');
//     if (_projectCodeCtrl.text.trim().isEmpty) missing.add('Project Code');
//     if ((_projectType ?? '').isEmpty) missing.add('Project Type');
//     if ((_projectManager ?? '').isEmpty) missing.add('Project Manager');
//     if (_startDate == null) missing.add('Start Date');
//     if (_endDate == null) missing.add('End Date');

//     if (missing.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill: ${missing.join(', ')}')),
//       );
//       return;
//     }

//     final payload = {
//       'customer_name': _customer,
//       'project_code': _projectCodeCtrl.text.trim(),
//       'project_name': _projectNameCtrl.text.trim(),
//       'project_type': _projectType,
//       'project_manager': _projectManager,
//       'bdm': (_bdm ?? '').isEmpty ? null : _bdm,
//       'start_date': _fmtIso(_startDate!),
//       'end_date': _fmtIso(_endDate!),
//       'amc_year': (_amcYear ?? '').isEmpty ? null : int.tryParse(_amcYear!),
//       'amc_months':
//           (_amcMonths ?? '').isEmpty ? null : int.tryParse(_amcMonths!),
//     };

//     setState(() => _saving = true);
//     try {
//       final res = await _post('/api/projects', payload);
//       if (res.statusCode == 409) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Project code already exists')),
//         );
//         return;
//       }
//       if (res.statusCode < 200 || res.statusCode >= 300) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Save failed (${res.statusCode})')),
//         );
//         return;
//       }

//       final created = jsonDecode(res.body) as Map<String, dynamic>;
//       final String projectId = (created['id'] ?? '').toString();

//       // POST sub-projects (if any)
//       final names =
//           _subProjects.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
//       if (projectId.isNotEmpty && names.isNotEmpty) {
//         for (final name in names) {
//           // ignore failures for individual children, just continue
//           await _post('/api/projects/$projectId/sub-projects', {'name': name});
//         }
//       }

//       if (!mounted) return;
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Project created')));
//       _clearAll();
//       // refresh lookups (so the new project shows elsewhere if you list)
//       // await _loadLookups(); // not required here, but safe if needed
//     } catch (_) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Network error while saving project')),
//       );
//     } finally {
//       if (mounted) setState(() => _saving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Project',
//       centerTitle: true,
//       currentIndex: 1,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
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
//           icon: ClipOval(
//             child: Image.asset(
//               'assets/User_profile.png',
//               width: 36,
//               height: 36,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
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
//                   // Header
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Add New Project',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleLarge?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: _loadingLookups ? null : _clearAll,
//                         child: const Text('Clear'),
//                       ),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   if (_loadingLookups)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 8),
//                           SizedBox(
//                             width: 18,
//                             height: 18,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             'Loading lookups…',
//                             style: TextStyle(color: cs.onSurfaceVariant),
//                           ),
//                         ],
//                       ),
//                     ),

//                   _Dropdown<String>(
//                     label: 'Customer Name*',
//                     value: _customer,
//                     items: _customers,
//                     onChanged: (v) => setState(() => _customer = v),
//                   ),

//                   _TextOneLine(
//                     label: 'Project Name*',
//                     controller: _projectNameCtrl,
//                   ),

//                   _ROText('Project Code*', _projectCodeCtrl),

//                   // ---- Sub Projects section ----
//                   _SubProjectsSection(
//                     projects: _subProjects,
//                     onAdd: _addOrEditSubProject,
//                     onEdit: (i) => _addOrEditSubProject(editIndex: i),
//                     onRemove: (i) => setState(() => _subProjects.removeAt(i)),
//                   ),

//                   _Dropdown<String>(
//                     label: 'Project Type*',
//                     value: _projectType,
//                     items: _types,
//                     onChanged: (v) => setState(() => _projectType = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'Project Manager*',
//                     value: _projectManager,
//                     items: _pms,
//                     onChanged: (v) => setState(() => _projectManager = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'BDM',
//                     value: _bdm,
//                     items: _bdms,
//                     onChanged: (v) => setState(() => _bdm = v),
//                   ),

//                   // Dates side-by-side or stacked
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final wide = c.maxWidth > 560;

//                       final start = _DateField(
//                         label: 'Start Date*',
//                         date: _startDate,
//                         onTap: () => _pickDate(isStart: true),
//                       );
//                       final end = _DateField(
//                         label: 'End Date*',
//                         date: _endDate,
//                         onTap: () => _pickDate(isStart: false),
//                       );

//                       if (wide) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: start),
//                             const SizedBox(width: 12),
//                             Expanded(child: end),
//                           ],
//                         );
//                       }
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [start, const SizedBox(height: 6), end],
//                       );
//                     },
//                   ),

//                   _Dropdown<String>(
//                     label: 'AMC Year',
//                     value: _amcYear,
//                     items: _years,
//                     onChanged: (v) => setState(() => _amcYear = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'AMC Months',
//                     value: _amcMonths,
//                     items: _months,
//                     onChanged: (v) => setState(() => _amcMonths = v),
//                   ),

//                   const SizedBox(height: 12),

//                   // Save button: right on wide, full-width on narrow
//                   LayoutBuilder(
//                     builder:
//                         (context, c) =>
//                             c.maxWidth >= 640
//                                 ? Align(
//                                   alignment: Alignment.centerRight,
//                                   child: _SaveButton(
//                                     onPressed: _saving ? null : _onSave,
//                                     saving: _saving,
//                                   ),
//                                 )
//                                 : _SaveButton(
//                                   onPressed: _saving ? null : _onSave,
//                                   saving: _saving,
//                                 ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Add/Edit a single sub-project via dialog
//   Future<void> _addOrEditSubProject({int? editIndex}) async {
//     final controller = TextEditingController(
//       text: editIndex != null ? _subProjects[editIndex] : '',
//     );
//     final result = await showDialog<String>(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             backgroundColor: Theme.of(ctx).colorScheme.surface,
//             title: Text(
//               editIndex == null ? 'Add Sub Project' : 'Edit Sub Project',
//             ),
//             content: TextField(
//               controller: controller,
//               autofocus: true,
//               decoration: InputDecoration(
//                 labelText: 'Sub Project Name',
//                 border: const OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppTheme.accentColor),
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(ctx),
//                 child: const Text('CANCEL'),
//               ),
//               FilledButton(
//                 style: FilledButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                 ),
//                 onPressed: () => Navigator.pop(ctx, controller.text.trim()),
//                 child: Text(editIndex == null ? 'ADD' : 'SAVE'),
//               ),
//             ],
//           ),
//     );

//     if (result != null && result.isNotEmpty) {
//       setState(() {
//         if (editIndex == null) {
//           _subProjects.add(result);
//         } else {
//           _subProjects[editIndex] = result;
//         }
//       });
//     }
//   }
// }

// /// ---------- Sub Projects Section ----------
// class _SubProjectsSection extends StatelessWidget {
//   final List<String> projects;
//   final VoidCallback onAdd;
//   final void Function(int index) onEdit;
//   final void Function(int index) onRemove;

//   const _SubProjectsSection({
//     required this.projects,
//     required this.onAdd,
//     required this.onEdit,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Row header
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Sub Projects (optional)',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: cs.onSurfaceVariant,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: onAdd,
//                 icon: const Icon(Icons.add_circle_outline),
//                 label: const Text('Add Sub Project'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             child:
//                 projects.isEmpty
//                     ? Text(
//                       'No sub projects added.',
//                       style: TextStyle(color: cs.onSurfaceVariant),
//                     )
//                     : Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         for (int i = 0; i < projects.length; i++)
//                           _SubProjectChip(
//                             label: projects[i],
//                             onEdit: () => onEdit(i),
//                             onRemove: () => onRemove(i),
//                           ),
//                       ],
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SubProjectChip extends StatelessWidget {
//   final String label;
//   final VoidCallback onEdit;
//   final VoidCallback onRemove;
//   const _SubProjectChip({
//     required this.label,
//     required this.onEdit,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Material(
//       color: cs.surface,
//       borderRadius: BorderRadius.circular(20),
//       child: InkWell(
//         onTap: onEdit,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(label, style: TextStyle(color: cs.onSurface)),
//               const SizedBox(width: 6),
//               InkWell(
//                 onTap: onRemove,
//                 borderRadius: BorderRadius.circular(16),
//                 child: Icon(Icons.close, size: 16, color: cs.onSurfaceVariant),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ---------- Small UI helpers ----------
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

// class _TextOneLine extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _TextOneLine({required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           hintText: 'Enter $label',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: AppTheme.accentColor),
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
//           hintText: 'Read-only',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
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
//           color: cs.surfaceContainerHighest,
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

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   const _DateField({
//     required this.label,
//     required this.date,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final text =
//         date == null
//             ? 'Select date'
//             : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     color: date == null ? cs.onSurfaceVariant : cs.onSurface,
//                   ),
//                 ),
//               ),
//               Icon(
//                 Icons.calendar_today_rounded,
//                 size: 18,
//                 color: cs.onSurfaceVariant,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SaveButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final bool saving;
//   const _SaveButton({required this.onPressed, this.saving = false});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppTheme.accentColor,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(
//         saving ? 'SAVING…' : 'SAVE',
//         style: const TextStyle(fontWeight: FontWeight.w800),
//       ),
//     );
//   }
// }





//p2//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';

// /// =========================== CONFIG ===========================
// /// If your app hasn’t implemented auth yet, keep this true so the
// /// dropdowns are populated with realistic dev data whenever the API
// /// rejects unauthenticated requests (401/403) or fails.
// const bool kAllowMockLookups = true;

// /// Point this to your backend base URL (same as web .env VITE_API_BASE).
// /// Example: const kApiBase = 'https://pmgt.commedialabs.com';
// const String kApiBase = String.fromEnvironment('API_BASE', defaultValue: '');

// /// Dev-time fallback lists (used only when kAllowMockLookups == true)
// const List<String> kMockCustomers = [
//   'TCL GSTN',
//   'ACME Corp',
//   'Globex',
//   'Initech',
// ];
// const List<String> kMockPMs = [
//   'Swapnil Jadhav',
//   'Aniket',
//   'Riya',
//   'Shreya',
//   'Amey',
// ];
// const List<String> kMockBDMs = [
//   'Amey',
//   'Priya',
//   'Rahul',
// ];

// class AddProjectScreen extends StatefulWidget {
//   const AddProjectScreen({super.key});

//   @override
//   State<AddProjectScreen> createState() => _AddProjectScreenState();
// }

// class _AddProjectScreenState extends State<AddProjectScreen> {
//   // --- Controllers ---
//   final _projectCodeCtrl = TextEditingController(); // readonly, auto from name
//   final _projectNameCtrl = TextEditingController();

//   DateTime? _startDate;
//   DateTime? _endDate;

//   // dropdown values
//   String? _customer;
//   String? _projectType;
//   String? _projectManager; // store PM full_name (matches web)
//   String? _bdm; // store BDM full_name
//   String? _amcYear;
//   String? _amcMonths;

//   // Sub-projects
//   final List<String> _subProjects = [];

//   // Lookups (loaded from API)
//   List<String> _customers = const [];
//   List<String> _pms = const []; // full_name
//   List<String> _bdms = const []; // full_name

//   // Enums
//   final List<String> _types = const [
//     'Implementation',
//     'Upgrade',
//     'Maintenance',
//   ];
//   final List<String> _years = List<String>.generate(6, (i) => '$i'); // 0..5
//   final List<String> _months = List<String>.generate(12, (i) => '$i'); // 0..11

//   bool _loadingLookups = false;
//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();
//     // Auto project code from name
//     _projectNameCtrl.addListener(_autoCodeFromName);
//     _loadLookups();
//   }

//   @override
//   void dispose() {
//     _projectCodeCtrl.dispose();
//     _projectNameCtrl.removeListener(_autoCodeFromName);
//     _projectNameCtrl.dispose();
//     super.dispose();
//   }

//   // ───────────────────── Networking helpers ─────────────────────
//   Future<http.Response> _get(String path) async {
//     final uri = Uri.parse('$kApiBase$path');
//     // No auth headers yet; add headers here once you wire auth.
//     return http.get(uri);
//   }

//   Future<http.Response> _post(String path, Map<String, dynamic> body) async {
//     final uri = Uri.parse('$kApiBase$path');
//     return http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );
//   }

//   Future<void> _loadLookups() async {
//     if (!mounted) return;
//     setState(() => _loadingLookups = true);

//     // helpers to apply fallbacks
//     void useMockIfAllowed() {
//       if (!kAllowMockLookups) return;
//       _customers = kMockCustomers;
//       _pms = kMockPMs;
//       _bdms = kMockBDMs;
//     }

//     try {
//       // ------- Customers -------
//       try {
//         final r = await _get('/api/customers'); // may 401 without auth
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body) as Map<String, dynamic>;
//           final arr = (j['customers'] as List?) ?? [];
//           _customers = arr
//               .map((e) => (e['company_name'] ?? '').toString())
//               .where((s) => s.isNotEmpty)
//               .cast<String>()
//               .toList();
//         } else {
//           _customers = const [];
//         }
//       } catch (_) {
//         _customers = const [];
//       }

//       // ------- Project Managers -------
//       try {
//         final r = await _get('/api/project-managers');
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body);
//           final list = (j is List ? j : (j['project_managers'] as List?)) ?? [];
//           _pms = list
//               .map((e) => (e['full_name'] ?? '').toString())
//               .where((s) => s.isNotEmpty)
//               .cast<String>()
//               .toList();
//         } else {
//           _pms = const [];
//         }
//       } catch (_) {
//         _pms = const [];
//       }

//       // ------- BDMs -------
//       try {
//         final r = await _get('/api/bdms');
//         if (r.statusCode >= 200 && r.statusCode < 300) {
//           final j = jsonDecode(r.body);
//           final list = (j is List ? j : (j['bdms'] as List?)) ?? [];
//           _bdms = list
//               .map((e) => (e['full_name'] ?? '').toString())
//               .where((s) => s.isNotEmpty)
//               .cast<String>()
//               .toList();
//         } else {
//           _bdms = const [];
//         }
//       } catch (_) {
//         _bdms = const [];
//       }

//       // If any list is still empty (likely unauthorized), fill from mocks in dev
//       if ((_customers.isEmpty || _pms.isEmpty) && kAllowMockLookups) {
//         useMockIfAllowed();
//       }
//       if (mounted) setState(() {});
//     } finally {
//       if (mounted) setState(() => _loadingLookups = false);
//     }
//   }

//   // ───────────────────── UI helpers ─────────────────────
//   void _autoCodeFromName() {
//     final name = _projectNameCtrl.text.trim();
//     _projectCodeCtrl.text = name.isEmpty ? '' : '$name-CSPL';
//   }

//   void _clearAll() {
//     setState(() {
//       _customer = null;
//       _projectType = null;
//       _projectManager = null;
//       _bdm = null;
//       _amcYear = null;
//       _amcMonths = null;
//       _subProjects.clear();

//       _projectNameCtrl.clear();
//       _projectCodeCtrl.clear();
//       _startDate = null;
//       _endDate = null;
//     });
//   }

//   Future<void> _pickDate({required bool isStart}) async {
//     final now = DateTime.now();
//     final init = isStart ? (_startDate ?? now) : (_endDate ?? now);
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           _startDate = picked;
//           if (_endDate != null && _endDate!.isBefore(_startDate!)) {
//             _endDate = _startDate;
//           }
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }

//   String _fmtIso(DateTime d) =>
//       '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 1) return; // already on Add Project
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 2:
//         target = const AddActivityScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   Future<void> _onSave() async {
//     // Validate required
//     final missing = <String>[];
//     if ((_customer ?? '').isEmpty) missing.add('Customer Name');
//     if (_projectNameCtrl.text.trim().isEmpty) missing.add('Project Name');
//     if (_projectCodeCtrl.text.trim().isEmpty) missing.add('Project Code');
//     if ((_projectType ?? '').isEmpty) missing.add('Project Type');
//     if ((_projectManager ?? '').isEmpty) missing.add('Project Manager');
//     if (_startDate == null) missing.add('Start Date');
//     if (_endDate == null) missing.add('End Date');

//     if (missing.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill: ${missing.join(', ')}')),
//       );
//       return;
//     }

//     final payload = {
//       'customer_name': _customer,
//       'project_code': _projectCodeCtrl.text.trim(),
//       'project_name': _projectNameCtrl.text.trim(),
//       'project_type': _projectType,
//       'project_manager': _projectManager,
//       'bdm': (_bdm ?? '').isEmpty ? null : _bdm,
//       'start_date': _fmtIso(_startDate!),
//       'end_date': _fmtIso(_endDate!),
//       'amc_year': (_amcYear ?? '').isEmpty ? null : int.tryParse(_amcYear!),
//       'amc_months': (_amcMonths ?? '').isEmpty ? null : int.tryParse(_amcMonths!),
//     };

//     setState(() => _saving = true);
//     try {
//       final res = await _post('/api/projects', payload);
//       if (res.statusCode == 409) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Project code already exists')),
//         );
//         return;
//       }
//       if (res.statusCode < 200 || res.statusCode >= 300) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Save failed (${res.statusCode})')),
//         );
//         return;
//       }

//       final created = jsonDecode(res.body) as Map<String, dynamic>;
//       final String projectId = (created['id'] ?? '').toString();

//       // POST sub-projects (if any)
//       final names = _subProjects.map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
//       if (projectId.isNotEmpty && names.isNotEmpty) {
//         for (final name in names) {
//           // ignore failures for individual children, just continue
//           await _post('/api/projects/$projectId/sub-projects', {'name': name});
//         }
//       }

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Project created')),
//       );
//       _clearAll();
//     } catch (_) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Network error while saving project')),
//       );
//     } finally {
//       if (mounted) setState(() => _saving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Project',
//       centerTitle: true,
//       currentIndex: 1,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
//           onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           Card(
//             color: cs.surfaceContainerHighest,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Header
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Add New Project',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: _loadingLookups ? null : _clearAll,
//                         child: const Text('Clear'),
//                       ),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   if (_loadingLookups)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 8),
//                           SizedBox(
//                             width: 18,
//                             height: 18,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                           const SizedBox(width: 10),
//                           Text('Loading lookups…', style: TextStyle(color: cs.onSurfaceVariant)),
//                         ],
//                       ),
//                     ),

//                   _Dropdown<String>(
//                     label: 'Customer Name*',
//                     value: _customer,
//                     items: _customers,
//                     onChanged: (v) => setState(() => _customer = v),
//                   ),

//                   _TextOneLine(label: 'Project Name*', controller: _projectNameCtrl),

//                   _ROText('Project Code*', _projectCodeCtrl),

//                   // ---- Sub Projects section ----
//                   _SubProjectsSection(
//                     projects: _subProjects,
//                     onAdd: _addOrEditSubProject,
//                     onEdit: (i) => _addOrEditSubProject(editIndex: i),
//                     onRemove: (i) => setState(() => _subProjects.removeAt(i)),
//                   ),

//                   _Dropdown<String>(
//                     label: 'Project Type*',
//                     value: _projectType,
//                     items: _types,
//                     onChanged: (v) => setState(() => _projectType = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'Project Manager*',
//                     value: _projectManager,
//                     items: _pms,
//                     onChanged: (v) => setState(() => _projectManager = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'BDM',
//                     value: _bdm,
//                     items: _bdms,
//                     onChanged: (v) => setState(() => _bdm = v),
//                   ),

//                   // Dates (responsive row/stack)
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final wide = c.maxWidth > 560;

//                       final start = _DateField(
//                         label: 'Start Date*',
//                         date: _startDate,
//                         onTap: () => _pickDate(isStart: true),
//                       );
//                       final end = _DateField(
//                         label: 'End Date*',
//                         date: _endDate,
//                         onTap: () => _pickDate(isStart: false),
//                       );

//                       if (wide) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: start),
//                             const SizedBox(width: 12),
//                             Expanded(child: end),
//                           ],
//                         );
//                       }
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [start, const SizedBox(height: 6), end],
//                       );
//                     },
//                   ),

//                   _Dropdown<String>(
//                     label: 'AMC Year',
//                     value: _amcYear,
//                     items: _years,
//                     onChanged: (v) => setState(() => _amcYear = v),
//                   ),

//                   _Dropdown<String>(
//                     label: 'AMC Months',
//                     value: _amcMonths,
//                     items: _months,
//                     onChanged: (v) => setState(() => _amcMonths = v),
//                   ),

//                   const SizedBox(height: 12),

//                   // Save button: right on wide, full-width on narrow
//                   LayoutBuilder(
//                     builder: (context, c) => c.maxWidth >= 640
//                         ? Align(
//                             alignment: Alignment.centerRight,
//                             child: _SaveButton(onPressed: _saving ? null : _onSave, saving: _saving),
//                           )
//                         : _SaveButton(onPressed: _saving ? null : _onSave, saving: _saving),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Add/Edit a single sub-project via dialog
//   Future<void> _addOrEditSubProject({int? editIndex}) async {
//     final controller = TextEditingController(text: editIndex != null ? _subProjects[editIndex] : '');
//     final result = await showDialog<String>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: Theme.of(ctx).colorScheme.surface,
//         title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
//         content: TextField(
//           controller: controller,
//           autofocus: true,
//           decoration: InputDecoration(
//             labelText: 'Sub Project Name',
//             border: const OutlineInputBorder(),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: AppTheme.accentColor),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: AppTheme.accentColor, foregroundColor: Colors.black),
//             onPressed: () => Navigator.pop(ctx, controller.text.trim()),
//             child: Text(editIndex == null ? 'ADD' : 'SAVE'),
//           ),
//         ],
//       ),
//     );

//     if (result != null && result.isNotEmpty) {
//       setState(() {
//         if (editIndex == null) {
//           _subProjects.add(result);
//         } else {
//           _subProjects[editIndex] = result;
//         }
//       });
//     }
//   }
// }

// /// ---------- Sub Projects Section ----------
// class _SubProjectsSection extends StatelessWidget {
//   final List<String> projects;
//   final VoidCallback onAdd;
//   final void Function(int index) onEdit;
//   final void Function(int index) onRemove;

//   const _SubProjectsSection({
//     required this.projects,
//     required this.onAdd,
//     required this.onEdit,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Row header
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Sub Projects (optional)',
//                   style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: onAdd,
//                 icon: const Icon(Icons.add_circle_outline),
//                 label: const Text('Add Sub Project'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             child: projects.isEmpty
//                 ? Text('No sub projects added.', style: TextStyle(color: cs.onSurfaceVariant))
//                 : Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       for (int i = 0; i < projects.length; i++)
//                         _SubProjectChip(
//                           label: projects[i],
//                           onEdit: () => onEdit(i),
//                           onRemove: () => onRemove(i),
//                         ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SubProjectChip extends StatelessWidget {
//   final String label;
//   final VoidCallback onEdit;
//   final VoidCallback onRemove;
//   const _SubProjectChip({required this.label, required this.onEdit, required this.onRemove});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Material(
//       color: cs.surface,
//       borderRadius: BorderRadius.circular(20),
//       child: InkWell(
//         onTap: onEdit,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(label, style: TextStyle(color: cs.onSurface)),
//               const SizedBox(width: 6),
//               InkWell(
//                 onTap: onRemove,
//                 borderRadius: BorderRadius.circular(16),
//                 child: Icon(Icons.close, size: 16, color: cs.onSurfaceVariant),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ---------- Small UI helpers ----------
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
//           Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 6),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _TextOneLine extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _TextOneLine({required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           hintText: 'Enter $label',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
//           hintText: 'Read-only',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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

//     // ensure the menu opens even if empty (show a disabled "No data" item)
//     final List<DropdownMenuItem<T>> menuItems = items.isEmpty
//         ? [
//             DropdownMenuItem<T>(
//               enabled: false,
//               value: null,
//               child: Text('No data', style: TextStyle(color: cs.onSurfaceVariant)),
//             )
//           ]
//         : items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList();

//     // dedupe items while preserving order (defensive)
//     final seen = <String>{};
//     final deduped = <DropdownMenuItem<T>>[];
//     for (final mi in menuItems) {
//       final label = (mi.child as Text).data ?? '';
//       if (seen.add(label)) deduped.add(mi);
//     }

//     final T? effectiveValue = (value != null && items.contains(value)) ? value : null;

//     return _FieldShell(
//       label: label,
//       child: Container(
//         decoration: BoxDecoration(
//           color: cs.surfaceContainerHighest,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<T>(
//             value: effectiveValue,
//             isExpanded: true,
//             iconEnabledColor: cs.onSurfaceVariant,
//             dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//             style: TextStyle(color: cs.onSurface, fontSize: 14),
//             items: deduped,
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: (items.isEmpty) ? null : onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   const _DateField({required this.label, required this.date, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final text = date == null
//         ? 'Select date'
//         : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(color: date == null ? cs.onSurfaceVariant : cs.onSurface),
//                 ),
//               ),
//               Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SaveButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final bool saving;
//   const _SaveButton({required this.onPressed, this.saving = false});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppTheme.accentColor,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(saving ? 'SAVING…' : 'SAVE', style: const TextStyle(fontWeight: FontWeight.w800)),
//     );
//   }
// }



//p3//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';

import '../../../core/api_client.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  // Controllers
  final _projectNameCtrl = TextEditingController();
  final _projectCodeCtrl = TextEditingController(); // read-only (auto)
  DateTime? _startDate;
  DateTime? _endDate;

  // drop-downs (values)
  String? _customer;
  String? _projectType;
  String? _projectManager;
  String? _bdm;
  String? _amcYear;
  String? _amcMonths;

  // Sub-projects
  final List<String> _subProjects = [];

  // Lookups
  List<String> _customers = const [];
  List<String> _pms = const [];
  List<String> _bdms = const [];

  // enums
  final List<String> _types = const ['Implementation', 'Upgrade', 'Maintenance'];
  final List<String> _years = List<String>.generate(6, (i) => '$i');  // 0..5
  final List<String> _months = List<String>.generate(12, (i) => '$i'); // 0..11

  bool _loadingLookups = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _projectNameCtrl.addListener(_autoCodeFromName);
    _loadLookups();
  }

  @override
  void dispose() {
    _projectNameCtrl.removeListener(_autoCodeFromName);
    _projectNameCtrl.dispose();
    _projectCodeCtrl.dispose();
    super.dispose();
  }

  // ---------- Helpers ----------
  void _autoCodeFromName() {
    final name = _projectNameCtrl.text.trim();
    _projectCodeCtrl.text = name.isEmpty ? '' : '$name-CSPL';
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final init = isStart ? (_startDate ?? now) : (_endDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(data: Theme.of(ctx), child: child!),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _fmtIso(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _toast(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : null,
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _customer = null;
      _projectType = null;
      _projectManager = null;
      _bdm = null;
      _amcYear = null;
      _amcMonths = null;
      _subProjects.clear();
      _projectNameCtrl.clear();
      _projectCodeCtrl.clear();
      _startDate = null;
      _endDate = null;
    });
  }

  // ---------- Networking ----------
  Future<void> _loadLookups() async {
    final api = context.read<ApiClient>();
    setState(() => _loadingLookups = true);

    Future<List<String>> _fetchList(
      String path,
      String field,
      String subfield,
    ) async {
      try {
        final r = await api.get(path);
        if (r.statusCode < 200 || r.statusCode >= 300) return [];
        final j = jsonDecode(r.body);
        // list can be top-level or under a key
        final list = (j is List ? j : (j[field] as List?)) ?? [];
        return list
            .map((e) => (e[subfield] ?? '').toString())
            .where((s) => s.isNotEmpty)
            .cast<String>()
            .toList();
      } catch (_) {
        return [];
      }
    }

    try {
      final results = await Future.wait([
        _fetchList('/api/customers', 'customers', 'company_name'), // customers
        _fetchList('/api/project-managers', 'project_managers', 'full_name'),
        _fetchList('/api/bdms', 'bdms', 'full_name'),
      ]);

      if (!mounted) return;
      setState(() {
        _customers = results[0];
        _pms = results[1];
        _bdms = results[2];
      });
    } finally {
      if (mounted) setState(() => _loadingLookups = false);
    }
  }

  Future<void> _onSave() async {
    if ((_customer ?? '').isEmpty ||
        _projectNameCtrl.text.trim().isEmpty ||
        _projectCodeCtrl.text.trim().isEmpty ||
        (_projectType ?? '').isEmpty ||
        (_projectManager ?? '').isEmpty ||
        _startDate == null ||
        _endDate == null) {
      _toast('Please complete all required fields');
      return;
    }

    final api = context.read<ApiClient>();

    final payload = {
      'customer_name': _customer,
      'project_code': _projectCodeCtrl.text.trim(),
      'project_name': _projectNameCtrl.text.trim(),
      'project_type': _projectType,
      'project_manager': _projectManager,
      'bdm': (_bdm ?? '').isEmpty ? null : _bdm,
      'start_date': _fmtIso(_startDate!),
      'end_date': _fmtIso(_endDate!),
      'amc_year': (_amcYear ?? '').isEmpty ? null : int.tryParse(_amcYear!),
      'amc_months': (_amcMonths ?? '').isEmpty ? null : int.tryParse(_amcMonths!),
    };

    setState(() => _saving = true);
    try {
      final r = await api.post('/api/projects', body: payload);
      Map<String, dynamic> j = {};
      try {
        j = (jsonDecode(r.body) as Map).cast<String, dynamic>();
      } catch (_) {}

      if (r.statusCode == 409) {
        _toast('Project code already exists');
        return;
      }
      if (r.statusCode < 200 || r.statusCode >= 300) {
        _toast(j['error']?.toString() ?? 'Save failed (${r.statusCode})');
        return;
      }

      final createdId = (j['id'] ?? '').toString();
      final names = _subProjects
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      // best-effort subprojects
      if (createdId.isNotEmpty && names.isNotEmpty) {
        for (final name in names) {
          try {
            await api.post('/api/projects/$createdId/sub-projects', body: {'name': name});
          } catch (_) {/* ignore per-item errors */}
        }
      }

      if (!mounted) return;
      _toast('Project created', success: true);
      _clearAll();
    } catch (e) {
      if (!mounted) return;
      _toast('Network error while saving project');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // ---------- Navigation tabs ----------
  void _handleTabChange(BuildContext context, int i) {
    if (i == 1) return; // already here
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
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

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Project',
      centerTitle: true,
      currentIndex: 1,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
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
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
      ],
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
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add New Project',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: _loadingLookups ? null : _clearAll,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  if (_loadingLookups)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                          const SizedBox(width: 10),
                          Text('Loading lookups…', style: TextStyle(color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),

                  _Dropdown<String>(
                    label: 'Customer Name*',
                    value: _customer,
                    items: _customers,
                    onChanged: (v) => setState(() => _customer = v),
                  ),

                  _TextOneLine(label: 'Project Name*', controller: _projectNameCtrl),

                  _ROText('Project Code*', _projectCodeCtrl),

                  _SubProjectsSection(
                    projects: _subProjects,
                    onAdd: _addOrEditSubProject,
                    onEdit: (i) => _addOrEditSubProject(editIndex: i),
                    onRemove: (i) => setState(() => _subProjects.removeAt(i)),
                  ),

                  _Dropdown<String>(
                    label: 'Project Type*',
                    value: _projectType,
                    items: _types,
                    onChanged: (v) => setState(() => _projectType = v),
                  ),

                  _Dropdown<String>(
                    label: 'Project Manager*',
                    value: _projectManager,
                    items: _pms,
                    onChanged: (v) => setState(() => _projectManager = v),
                  ),

                  _Dropdown<String>(
                    label: 'BDM',
                    value: _bdm,
                    items: _bdms,
                    onChanged: (v) => setState(() => _bdm = v),
                  ),

                  // dates
                  LayoutBuilder(
                    builder: (context, c) {
                      final wide = c.maxWidth > 560;
                      final start = _DateField(label: 'Start Date*', date: _startDate, onTap: () => _pickDate(isStart: true));
                      final end = _DateField(label: 'End Date*', date: _endDate, onTap: () => _pickDate(isStart: false));
                      return wide
                          ? Row(children: [Expanded(child: start), const SizedBox(width: 12), Expanded(child: end)])
                          : Column(children: [start, const SizedBox(height: 6), end]);
                    },
                  ),

                  _Dropdown<String>(
                    label: 'AMC Year',
                    value: _amcYear,
                    items: _years,
                    onChanged: (v) => setState(() => _amcYear = v),
                  ),

                  _Dropdown<String>(
                    label: 'AMC Months',
                    value: _amcMonths,
                    items: _months,
                    onChanged: (v) => setState(() => _amcMonths = v),
                  ),

                  const SizedBox(height: 12),

                  LayoutBuilder(
                    builder: (context, c) => c.maxWidth >= 640
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: _SaveButton(onPressed: _saving ? null : _onSave, saving: _saving),
                          )
                        : _SaveButton(onPressed: _saving ? null : _onSave, saving: _saving),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add/Edit single sub-project via dialog
  Future<void> _addOrEditSubProject({int? editIndex}) async {
    final controller = TextEditingController(text: editIndex != null ? _subProjects[editIndex] : '');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(ctx).colorScheme.surface,
        title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Sub Project Name',
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.accentColor),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: Colors.black,
            ),
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(editIndex == null ? 'ADD' : 'SAVE'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        if (editIndex == null) {
          _subProjects.add(result);
        } else {
          _subProjects[editIndex] = result;
        }
      });
    }
  }
}

// ---------- Small UI helpers ----------
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
          Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _TextOneLine extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _TextOneLine({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          hintText: 'Enter $label',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: cs.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.accentColor),
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
          hintText: 'Read-only',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: cs.outlineVariant),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
  const _Dropdown({required this.label, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
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
            items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  const _DateField({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = date == null
        ? 'Select date'
        : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(child: Text(text, style: TextStyle(color: date == null ? cs.onSurfaceVariant : cs.onSurface))),
              Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool saving;
  const _SaveButton({required this.onPressed, this.saving = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.accentColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(saving ? 'SAVING…' : 'SAVE', style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

/// ---------- Sub Projects ----------
class _SubProjectsSection extends StatelessWidget {
  final List<String> projects;
  final VoidCallback onAdd;
  final void Function(int index) onEdit;
  final void Function(int index) onRemove;

  const _SubProjectsSection({
    required this.projects,
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Sub Projects (optional)',
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
              ),
              TextButton.icon(onPressed: onAdd, icon: const Icon(Icons.add_circle_outline), label: const Text('Add Sub Project')),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: projects.isEmpty
                ? Text('No sub projects added.', style: TextStyle(color: cs.onSurfaceVariant))
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (int i = 0; i < projects.length; i++)
                        _SubProjectChip(label: projects[i], onEdit: () => onEdit(i), onRemove: () => onRemove(i)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _SubProjectChip extends StatelessWidget {
  final String label;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  const _SubProjectChip({required this.label, required this.onEdit, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(color: cs.onSurface)),
              const SizedBox(width: 6),
              InkWell(onTap: onRemove, borderRadius: BorderRadius.circular(16), child: Icon(Icons.close, size: 16, color: cs.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
