// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';

// /// Your card model from ViewProjectsScreen
// class ProjectDto {
//   final String projectName;
//   final String type;
//   final String customerName;
//   final String projectCode;
//   final String projectManager;
//   final String bdm;
//   final String startDate; // dd/MM/yyyy
//   final String endDate;   // dd/MM/yyyy
//   final String amcYear;
//   final String amcMonths;
//   final List<String> subProjects;

//   const ProjectDto({
//     required this.projectName,
//     required this.type,
//     required this.customerName,
//     required this.projectCode,
//     required this.projectManager,
//     required this.bdm,
//     required this.startDate,
//     required this.endDate,
//     required this.amcYear,
//     required this.amcMonths,
//     this.subProjects = const [],
//   });

//   ProjectDto copyWith({
//     String? projectName,
//     String? type,
//     String? customerName,
//     String? projectCode,
//     String? projectManager,
//     String? bdm,
//     String? startDate,
//     String? endDate,
//     String? amcYear,
//     String? amcMonths,
//     List<String>? subProjects,
//   }) {
//     return ProjectDto(
//       projectName: projectName ?? this.projectName,
//       type: type ?? this.type,
//       customerName: customerName ?? this.customerName,
//       projectCode: projectCode ?? this.projectCode,
//       projectManager: projectManager ?? this.projectManager,
//       bdm: bdm ?? this.bdm,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       amcYear: amcYear ?? this.amcYear,
//       amcMonths: amcMonths ?? this.amcMonths,
//       subProjects: subProjects ?? this.subProjects,
//     );
//   }
// }

// class UpdateProjectModal extends StatefulWidget {
//   final ProjectDto project;
//   const UpdateProjectModal({super.key, required this.project});

//   @override
//   State<UpdateProjectModal> createState() => _UpdateProjectModalState();
// }

// class _UpdateProjectModalState extends State<UpdateProjectModal> {
//   // controllers
//   late final TextEditingController _name = TextEditingController(text: widget.project.projectName);
//   late final TextEditingController _code = TextEditingController(text: widget.project.projectCode);
//   late final TextEditingController _start = TextEditingController(text: widget.project.startDate);
//   late final TextEditingController _end   = TextEditingController(text: widget.project.endDate);

//   // dropdowns
//   late String _customer = widget.project.customerName;
//   late String _manager  = widget.project.projectManager;
//   late String _type     = widget.project.type;
//   late String _bdm      = widget.project.bdm;
//   late String _amcYear  = widget.project.amcYear;
//   late String _amcMonths= widget.project.amcMonths;

//   late final List<String> _subProjects = [...widget.project.subProjects];

//   // demo lists — swap with live data
//   final _customers = const ['TCL GSTN', 'ACME Corp', 'Globex'];
//   final _managers  = const ['Aniket', 'Riya', 'Shreya', 'Amey'];
//   final _types     = const ['AMC', 'Deployment', 'Rollout', 'Implementation', 'POC'];
//   final _bdms      = const ['Amey', 'Priya', 'Rahul'];
//   final _years     = const ['2024','2025','2026','2027','2028'];
//   final _months    = const ['0','1','2','3','6','9','12'];

//   @override
//   void dispose() {
//     _name.dispose();
//     _code.dispose();
//     _start.dispose();
//     _end.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate(TextEditingController ctrl) async {
//     // parse dd/MM/yyyy
//     DateTime? init;
//     try {
//       final p = ctrl.text.split('/');
//       init = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
//     } catch (_) {
//       init = DateTime.now();
//     }
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       final d = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//       ctrl.text = d;
//       setState(() {});
//     }
//   }

//   void _addOrEditSubProject({int? editIndex}) async {
//     final c = TextEditingController(text: editIndex == null ? '' : _subProjects[editIndex]);
//     final res = await showDialog<String>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
//         content: TextField(
//           controller: c,
//           autofocus: true,
//           decoration: const InputDecoration(
//             labelText: 'Sub Project Name',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: AppTheme.accentColor, foregroundColor: Colors.black),
//             onPressed: () => Navigator.pop(context, c.text.trim()),
//             child: Text(editIndex == null ? 'ADD' : 'SAVE'),
//           ),
//         ],
//       ),
//     );
//     if (res != null && res.isNotEmpty) {
//       setState(() {
//         if (editIndex == null) {
//           _subProjects.add(res);
//         } else {
//           _subProjects[editIndex] = res;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     const vgap = SizedBox(height: 10);

//     return SafeArea(
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.92,
//         minChildSize: 0.6,
//         maxChildSize: 0.98,
//         expand: false,
//         builder: (context, scrollCtrl) {
//           return Material(
//             color: Theme.of(context).scaffoldBackgroundColor,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             child: ListView(
//               controller: scrollCtrl,
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
//               children: [
//                 // Header
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text('Update Project',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Customer
//                 _ddl('Customer Name*', _customer, _customers, (v) => setState(()=> _customer = v!)),
//                 vgap,

//                 // Project name
//                 _text('Project Name*', _name),
//                 vgap,

//                 // Code (readonly)
//                 _text('Project Code (read-only)', _code, readOnly: true),
//                 vgap,

//                 // Sub projects
//                 Text('Sub Projects', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 6),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: cs.surfaceContainerHighest,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: cs.outlineVariant),
//                   ),
//                   child: _subProjects.isEmpty
//                       ? Text('No sub projects added.', style: TextStyle(color: cs.onSurfaceVariant))
//                       : Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: [
//                             for (int i = 0; i < _subProjects.length; i++)
//                               _chip(_subProjects[i], onEdit: () => _addOrEditSubProject(editIndex: i), onRemove: () {
//                                 setState(() => _subProjects.removeAt(i));
//                               }),
//                           ],
//                         ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton.icon(
//                     onPressed: () => _addOrEditSubProject(),
//                     icon: const Icon(Icons.add_circle_outline),
//                     label: const Text('Add Sub Project'),
//                   ),
//                 ),
//                 vgap,

//                 // PM, Type, BDM
//                 _ddl('Project Manager*', _manager, _managers, (v) => setState(()=> _manager = v!)),
//                 vgap,
//                 _ddl('Project Type*', _type, _types, (v) => setState(()=> _type = v!)),
//                 vgap,
//                 _ddl('BDM', _bdm, _bdms, (v) => setState(()=> _bdm = v!)),
//                 vgap,

//                 // Dates
//                 _date('Start Date*', _start, () => _pickDate(_start)),
//                 vgap,
//                 _date('End Date*', _end, () => _pickDate(_end)),
//                 vgap,

//                 // AMC
//                 _ddl('AMC Year', _amcYear, _years, (v) => setState(()=> _amcYear = v!)),
//                 vgap,
//                 _ddl('AMC Months', _amcMonths, _months, (v) => setState(()=> _amcMonths = v!)),
//                 const SizedBox(height: 16),

//                 // Actions
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('CANCEL'),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                         ),
//                         onPressed: () {
//                           final updated = ProjectDto(
//                             projectName: _name.text.trim(),
//                             type: _type,
//                             customerName: _customer,
//                             projectCode: _code.text, // readonly
//                             projectManager: _manager,
//                             bdm: _bdm,
//                             startDate: _start.text,
//                             endDate: _end.text,
//                             amcYear: _amcYear,
//                             amcMonths: _amcMonths,
//                             subProjects: _subProjects,
//                           );
//                           Navigator.pop(context, updated);
//                         },
//                         child: const Text('UPDATE', style: TextStyle(fontWeight: FontWeight.w800)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- small field helpers ---
//   Widget _text(String label, TextEditingController c, {bool readOnly = false}) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: c,
//           readOnly: readOnly,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: cs.surfaceContainerHighest,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: cs.outlineVariant)),
//             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppTheme.accentColor)),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _ddl(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: value,
//               items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _date(String label, TextEditingController c, VoidCallback onTap) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             height: 48,
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Row(
//               children: [
//                 Expanded(child: Align(alignment: Alignment.centerLeft, child: Text(c.text.isEmpty ? 'Select date' : c.text))),
//                 Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _chip(String label, {required VoidCallback onEdit, required VoidCallback onRemove}) {
//     final cs = Theme.of(context).colorScheme;
//     return Material(
//       color: cs.surface,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         onTap: onEdit,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Row(mainAxisSize: MainAxisSize.min, children: [
//             Text(label),
//             const SizedBox(width: 6),
//             GestureDetector(onTap: onRemove, child: Icon(Icons.close, size: 14, color: cs.onSurfaceVariant)),
//           ]),
//         ),
//       ),
//     );
//   }
// }


//p2//
// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';

// /// Card model from ViewProjectsScreen
// class ProjectDto {
//   final String projectName;
//   final String type;
//   final String customerName;
//   final String projectCode;
//   final String projectManager;
//   final String bdm;
//   final String startDate; // dd/MM/yyyy
//   final String endDate;   // dd/MM/yyyy
//   final String amcYear;
//   final String amcMonths;
//   final List<String> subProjects;

//   const ProjectDto({
//     required this.projectName,
//     required this.type,
//     required this.customerName,
//     required this.projectCode,
//     required this.projectManager,
//     required this.bdm,
//     required this.startDate,
//     required this.endDate,
//     required this.amcYear,
//     required this.amcMonths,
//     this.subProjects = const [],
//   });

//   ProjectDto copyWith({
//     String? projectName,
//     String? type,
//     String? customerName,
//     String? projectCode,
//     String? projectManager,
//     String? bdm,
//     String? startDate,
//     String? endDate,
//     String? amcYear,
//     String? amcMonths,
//     List<String>? subProjects,
//   }) {
//     return ProjectDto(
//       projectName: projectName ?? this.projectName,
//       type: type ?? this.type,
//       customerName: customerName ?? this.customerName,
//       projectCode: projectCode ?? this.projectCode,
//       projectManager: projectManager ?? this.projectManager,
//       bdm: bdm ?? this.bdm,
//       startDate: startDate ?? this.startDate,
//       endDate: endDate ?? this.endDate,
//       amcYear: amcYear ?? this.amcYear,
//       amcMonths: amcMonths ?? this.amcMonths,
//       subProjects: subProjects ?? this.subProjects,
//     );
//   }
// }

// class UpdateProjectModal extends StatefulWidget {
//   final ProjectDto project;
//   const UpdateProjectModal({super.key, required this.project});

//   @override
//   State<UpdateProjectModal> createState() => _UpdateProjectModalState();
// }

// class _UpdateProjectModalState extends State<UpdateProjectModal> {
//   // controllers
//   late final TextEditingController _name  = TextEditingController(text: widget.project.projectName);
//   late final TextEditingController _code  = TextEditingController(text: widget.project.projectCode);
//   late final TextEditingController _start = TextEditingController(text: widget.project.startDate);
//   late final TextEditingController _end   = TextEditingController(text: widget.project.endDate);

//   // dropdown state
//   late String _customer  = widget.project.customerName;
//   late String _manager   = widget.project.projectManager;
//   late String _type      = widget.project.type;
//   late String _bdm       = widget.project.bdm;
//   late String _amcYear   = widget.project.amcYear;
//   late String _amcMonths = widget.project.amcMonths;

//   // sub projects
//   late final List<String> _subProjects = [...widget.project.subProjects];

//   // demo lists — replace with live data as needed
//   final _customers = const ['TCL GSTN', 'ACME Corp', 'Globex'];
//   final _managers  = const ['Aniket', 'Riya', 'Shreya', 'Amey'];
//   final _types     = const ['AMC', 'Deployment', 'Rollout', 'Implementation', 'POC'];
//   final _bdms      = const ['Amey', 'Priya', 'Rahul'];
//   final _years     = const ['2024','2025','2026','2027','2028'];
//   final _months    = const ['0','1','2','3','6','9','12'];

//   @override
//   void initState() {
//     super.initState();
//     // If any incoming dropdown value isn't present, clear it to avoid DropdownButton assertion
//     if (!_customers.contains(_customer))  _customer  = '';
//     if (!_managers.contains(_manager))    _manager   = '';
//     if (!_types.contains(_type))          _type      = '';
//     if (!_bdms.contains(_bdm))            _bdm       = '';
//     if (!_years.contains(_amcYear))       _amcYear   = '';
//     if (!_months.contains(_amcMonths))    _amcMonths = '';
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     _code.dispose();
//     _start.dispose();
//     _end.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate(TextEditingController ctrl) async {
//     // parse dd/MM/yyyy
//     DateTime init;
//     try {
//       final p = ctrl.text.split('/');
//       init = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
//     } catch (_) {
//       init = DateTime.now();
//     }
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       final d = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//       ctrl.text = d;
//       setState(() {});
//     }
//   }

//   void _addOrEditSubProject({int? editIndex}) async {
//     final c = TextEditingController(text: editIndex == null ? '' : _subProjects[editIndex]);
//     final res = await showDialog<String>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
//         content: TextField(
//           controller: c,
//           autofocus: true,
//           decoration: const InputDecoration(
//             labelText: 'Sub Project Name',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: AppTheme.accentColor, foregroundColor: Colors.black),
//             onPressed: () => Navigator.pop(context, c.text.trim()),
//             child: Text(editIndex == null ? 'ADD' : 'SAVE'),
//           ),
//         ],
//       ),
//     );
//     if (res != null && res.isNotEmpty) {
//       setState(() {
//         if (editIndex == null) {
//           _subProjects.add(res);
//         } else {
//           _subProjects[editIndex] = res;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     const vgap = SizedBox(height: 10);

//     return SafeArea(
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.92,
//         minChildSize: 0.6,
//         maxChildSize: 0.98,
//         expand: false,
//         builder: (context, scrollCtrl) {
//           return Material(
//             color: Theme.of(context).scaffoldBackgroundColor,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             child: ListView(
//               controller: scrollCtrl,
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
//               children: [
//                 // Header
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Update Project',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.w800,
//                             ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Customer
//                 _ddl('Customer Name*', _customer, _customers, (v) => setState(() => _customer = v ?? '')),
//                 vgap,

//                 // Project name
//                 _text('Project Name*', _name),
//                 vgap,

//                 // Code (readonly)
//                 _text('Project Code (read-only)', _code, readOnly: true),
//                 vgap,

//                 // Sub projects
//                 Text('Sub Projects',
//                     style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 6),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: cs.surfaceContainerHighest,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: cs.outlineVariant),
//                   ),
//                   child: _subProjects.isEmpty
//                       ? Text('No sub projects added.', style: TextStyle(color: cs.onSurfaceVariant))
//                       : Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: [
//                             for (int i = 0; i < _subProjects.length; i++)
//                               _chip(
//                                 _subProjects[i],
//                                 onEdit: () => _addOrEditSubProject(editIndex: i),
//                                 onRemove: () => setState(() => _subProjects.removeAt(i)),
//                               ),
//                           ],
//                         ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton.icon(
//                     onPressed: () => _addOrEditSubProject(),
//                     icon: const Icon(Icons.add_circle_outline),
//                     label: const Text('Add Sub Project'),
//                   ),
//                 ),
//                 vgap,

//                 // PM, Type, BDM
//                 _ddl('Project Manager*', _manager, _managers, (v) => setState(() => _manager = v ?? '')),
//                 vgap,
//                 _ddl('Project Type*', _type, _types, (v) => setState(() => _type = v ?? '')),
//                 vgap,
//                 _ddl('BDM', _bdm, _bdms, (v) => setState(() => _bdm = v ?? '')),
//                 vgap,

//                 // Dates
//                 _date('Start Date*', _start, () => _pickDate(_start)),
//                 vgap,
//                 _date('End Date*', _end, () => _pickDate(_end)),
//                 vgap,

//                 // AMC
//                 _ddl('AMC Year', _amcYear, _years, (v) => setState(() => _amcYear = v ?? '')),
//                 vgap,
//                 _ddl('AMC Months', _amcMonths, _months, (v) => setState(() => _amcMonths = v ?? '')),
//                 const SizedBox(height: 16),

//                 // Actions
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text('CANCEL'),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                         ),
//                         onPressed: () {
//                           final updated = ProjectDto(
//                             projectName: _name.text.trim(),
//                             type: _type,
//                             customerName: _customer,
//                             projectCode: _code.text, // readonly
//                             projectManager: _manager,
//                             bdm: _bdm,
//                             startDate: _start.text,
//                             endDate: _end.text,
//                             amcYear: _amcYear,
//                             amcMonths: _amcMonths,
//                             subProjects: _subProjects,
//                           );
//                           Navigator.pop(context, updated);
//                         },
//                         child: const Text('UPDATE', style: TextStyle(fontWeight: FontWeight.w800)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ---- small helpers ----

//   Widget _text(String label, TextEditingController c, {bool readOnly = false}) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: c,
//           readOnly: readOnly,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: cs.surfaceContainerHighest,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: cs.outlineVariant),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: AppTheme.accentColor),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Resilient dropdown:
//   /// - Deduplicates items
//   /// - Uses `null` (hint) when current value doesn't exist in items
//   Widget _ddl(String label, String value, List<String> itemsIn, ValueChanged<String?> onChanged) {
//     final cs = Theme.of(context).colorScheme;

//     // dedupe while preserving order
//     final List<String> items = [];
//     for (final it in itemsIn) {
//       if (!items.contains(it)) items.add(it);
//     }

//     final String? effectiveValue = (value.isEmpty || !items.contains(value)) ? null : value;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: effectiveValue,
//               hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               style: TextStyle(color: cs.onSurface, fontSize: 14),
//               items: items.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _date(String label, TextEditingController c, VoidCallback onTap) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             height: 48,
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(c.text.isEmpty ? 'Select date' : c.text),
//                   ),
//                 ),
//                 Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _chip(String label, {required VoidCallback onEdit, required VoidCallback onRemove}) {
//     final cs = Theme.of(context).colorScheme;
//     return Material(
//       color: cs.surface,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         onTap: onEdit,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(label),
//               const SizedBox(width: 6),
//               GestureDetector(onTap: onRemove, child: Icon(Icons.close, size: 14, color: cs.onSurfaceVariant)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//p3//
// lib/src/pages/modals/update_project_modal.dart
import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class ProjectDto {
  final String projectName;
  final String type;
  final String customerName;
  final String projectCode;
  final String projectManager;
  final String bdm;
  final String startDate; // dd/MM/yyyy
  final String endDate;   // dd/MM/yyyy
  final String amcYear;
  final String amcMonths;
  final List<String> subProjects;

  const ProjectDto({
    required this.projectName,
    required this.type,
    required this.customerName,
    required this.projectCode,
    required this.projectManager,
    required this.bdm,
    required this.startDate,
    required this.endDate,
    required this.amcYear,
    required this.amcMonths,
    this.subProjects = const [],
  });

  ProjectDto copyWith({
    String? projectName,
    String? type,
    String? customerName,
    String? projectCode,
    String? projectManager,
    String? bdm,
    String? startDate,
    String? endDate,
    String? amcYear,
    String? amcMonths,
    List<String>? subProjects,
  }) {
    return ProjectDto(
      projectName: projectName ?? this.projectName,
      type: type ?? this.type,
      customerName: customerName ?? this.customerName,
      projectCode: projectCode ?? this.projectCode,
      projectManager: projectManager ?? this.projectManager,
      bdm: bdm ?? this.bdm,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      amcYear: amcYear ?? this.amcYear,
      amcMonths: amcMonths ?? this.amcMonths,
      subProjects: subProjects ?? this.subProjects,
    );
  }
}

class UpdateProjectModal extends StatefulWidget {
  final ProjectDto project;
  const UpdateProjectModal({super.key, required this.project});

  @override
  State<UpdateProjectModal> createState() => _UpdateProjectModalState();
}

class _UpdateProjectModalState extends State<UpdateProjectModal> {
  // Read-only values (plain strings)
  late final String _customerRO = widget.project.customerName;
  late final String _nameRO     = widget.project.projectName;
  late final String _codeRO     = widget.project.projectCode;

  // Editable controllers
  late final TextEditingController _start = TextEditingController(text: widget.project.startDate);
  late final TextEditingController _end   = TextEditingController(text: widget.project.endDate);

  // Dropdown state (seeded with incoming)
  late String _manager   = widget.project.projectManager;
  late String _type      = widget.project.type;
  late String _bdm       = widget.project.bdm;
  late String _amcYear   = widget.project.amcYear;
  late String _amcMonths = widget.project.amcMonths;

  // Sub projects
  late final List<String> _subProjects = [...widget.project.subProjects];

  // Base lists (swap with API if needed)
  final List<String> _baseManagers = const ['Aniket', 'Riya', 'Shreya', 'Amey', 'Swapnil Jadhav'];
  final List<String> _baseTypes    = const ['Implementation', 'Upgrade', 'Maintenance', 'Deployment', 'Rollout', 'AMC'];
  final List<String> _baseBdms     = const ['Amey', 'Priya', 'Rahul'];
  final List<String> _baseYears    = const ['0','1','2','3','4','5'];       // matches web select
  final List<String> _baseMonths   = const ['0','1','2','3','4','5','6','7','8','9','10','11'];

  late List<String> _pmList, _typeList, _bdmList, _yearList, _monthList;

  @override
  void initState() {
    super.initState();
    List<String> seed(List<String> base, String current) {
      final out = [...base];
      if (current.isNotEmpty && !out.contains(current)) out.insert(0, current);
      return out;
    }
    _pmList    = seed(_baseManagers, _manager);
    _typeList  = seed(_baseTypes, _type);
    _bdmList   = seed(_baseBdms, _bdm);
    _yearList  = seed(_baseYears, _amcYear);
    _monthList = seed(_baseMonths, _amcMonths);
  }

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    DateTime init;
    try {
      final p = ctrl.text.split('/');
      init = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
    } catch (_) {
      init = DateTime.now();
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final d = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      ctrl.text = d;
      setState(() {});
    }
  }

  void _addOrEditSubProject({int? editIndex}) async {
    final c = TextEditingController(text: editIndex == null ? '' : _subProjects[editIndex]);
    final res = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
        content: TextField(
          controller: c,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Sub Project Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.accentColor, foregroundColor: Colors.black),
            onPressed: () => Navigator.pop(context, c.text.trim()),
            child: Text(editIndex == null ? 'ADD' : 'SAVE'),
          ),
        ],
      ),
    );
    if (res != null && res.isNotEmpty) {
      setState(() {
        if (editIndex == null) {
          _subProjects.add(res);
        } else {
          _subProjects[editIndex] = res;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const vgap = SizedBox(height: 10);

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.6,
        maxChildSize: 0.98,
        expand: false,
        builder: (context, scrollCtrl) {
          return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: ListView(
              controller: scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text('Update Project',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    ),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 8),

                // ---- Read-only (simple custom row, never blank) ----
                _readOnlyField('Customer Name*', _customerRO),
                vgap,
                _readOnlyField('Project Name*', _nameRO),
                vgap,
                _readOnlyField('Project Code (read-only)', _codeRO),
                vgap,

                // Sub projects
                Text('Sub Projects',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: _subProjects.isEmpty
                      ? Text('No sub projects added.', style: TextStyle(color: cs.onSurfaceVariant))
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (int i = 0; i < _subProjects.length; i++)
                              _chip(
                                _subProjects[i],
                                onEdit: () => _addOrEditSubProject(editIndex: i),
                                onRemove: () => setState(() => _subProjects.removeAt(i)),
                              ),
                          ],
                        ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => _addOrEditSubProject(),
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Add Sub Project'),
                  ),
                ),
                vgap,

                // PM, Type, BDM
                _ddl('Project Manager*', _manager, _pmList, (v) => setState(() => _manager = v ?? '')),
                vgap,
                _ddl('Project Type*', _type, _typeList, (v) => setState(() => _type = v ?? '')),
                vgap,
                _ddl('BDM', _bdm, _bdmList, (v) => setState(() => _bdm = v ?? '')),
                vgap,

                // Dates
                _date('Start Date*', _start, () => _pickDate(_start)),
                vgap,
                _date('End Date*', _end, () => _pickDate(_end)),
                vgap,

                // AMC
                _ddl('AMC Year', _amcYear, _yearList, (v) => setState(() => _amcYear = v ?? '')),
                vgap,
                _ddl('AMC Months', _amcMonths, _monthList, (v) => setState(() => _amcMonths = v ?? '')),
                const SizedBox(height: 16),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          final updated = ProjectDto(
                            customerName: _customerRO,
                            projectName:  _nameRO,
                            projectCode:  _codeRO,
                            type:         _type,
                            projectManager: _manager,
                            bdm: _bdm,
                            startDate: _start.text,
                            endDate:   _end.text,
                            amcYear:   _amcYear,
                            amcMonths: _amcMonths,
                            subProjects: _subProjects,
                          );
                          Navigator.pop(context, updated);
                        },
                        child: const Text('UPDATE', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---- UI helpers -----------------------------------------------------------

  Widget _readOnlyField(String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(child: Text(value, style: TextStyle(color: cs.onSurface))),
              Text('Read-only', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ],
    );
  }

  // Resilient dropdown (dedup + keeps current value present)
  Widget _ddl(String label, String value, List<String> itemsIn, ValueChanged<String?> onChanged) {
    final cs = Theme.of(context).colorScheme;

    final List<String> items = [];
    for (final it in itemsIn) {
      if (!items.contains(it)) items.add(it);
    }
    final String? effectiveValue = (value.isEmpty || !items.contains(value)) ? null : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: effectiveValue,
              hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              style: TextStyle(color: cs.onSurface, fontSize: 14),
              items: items.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _date(String label, TextEditingController c, VoidCallback onTap) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        InkWell(
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
                Expanded(child: Align(alignment: Alignment.centerLeft, child: Text(c.text.isEmpty ? 'Select date' : c.text))),
                Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, {required VoidCallback onEdit, required VoidCallback onRemove}) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              const SizedBox(width: 6),
              GestureDetector(onTap: onRemove, child: Icon(Icons.close, size: 14, color: cs.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
