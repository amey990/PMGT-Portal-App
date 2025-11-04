// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
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

// class InventoryScreen extends StatefulWidget {
//   const InventoryScreen({super.key});

//   @override
//   State<InventoryScreen> createState() => _InventoryScreenState();
// }

// class _InventoryScreenState extends State<InventoryScreen> {
//   // int _selectedTab = 0;

//   // toggle: true = Upload Files, false = View Files
//   bool _uploadMode = true;

//   // dropdown data (mock)
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   final _sites = const ['Aastha TV - Noida', 'Site 001', 'Site 002'];
//   final _docTypes = const ['Project Plan', 'HLD', 'LLD', 'SOP', 'Misc'];

//   String? _project;
//   String? _site;
//   String? _docType;

//   // picked files
//   final List<PlatformFile> _files = [];

//   Future<void> _pickFiles() async {
//     final remaining = 4 - _files.length;
//     if (remaining <= 0) return;

//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       withReadStream: false,
//     );
//     if (result == null) return;

//     setState(() {
//       for (final f in result.files) {
//         if (_files.length >= 4) break;
//         final exists = _files.any((e) => e.name == f.name && e.size == f.size);
//         if (!exists) _files.add(f);
//       }
//     });
//   }

//   void _removeAt(int i) => setState(() => _files.removeAt(i));

//   void _clearAll() {
//     setState(() {
//       _project = null;
//       _site = null;
//       _docType = null;
//       _files.clear();
//     });
//   }

//   bool get _canUpload =>
//       _project != null &&
//       _site != null &&
//       _docType != null &&
//       _files.isNotEmpty;

//   // mock rows for View Files
//   final List<_InvItem> _rows = List<_InvItem>.generate(
//     7,
//     (i) => _InvItem(
//       id: i + 1,
//       date: '01/08/2025',
//       project: 'TelstraApari',
//       site: ['Aastha TV - Noida', 'Site 001', 'Site 002'][i % 3],
//       docType: ['Project Plan', 'HLD', 'LLD'][i % 3],
//       fileName:
//           [
//             'Project plan_Telstra_PPT Ver 3.1.xlsx',
//             'HLD INSN Aastha Noida - EDD.pdf',
//             '127111-1 (GMN INSN Aastha Noida New Delhi Wiring)-MAIN.pdf',
//           ][i % 3],
//     ),
//   );

//   void _handleTabChange(BuildContext context, int i) {
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();    break; // Dashboard
//     case 1: target = const AddProjectScreen();   break; // Add Project
//     case 2: target = const AddActivityScreen();  break; // Add Activity
//     case 3: target = const AnalyticsScreen();    break; // Analytics
//     case 4: target = const ViewUsersScreen();    break; // View Users
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }

//   static const double _labelW = 84;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Inventory',
//       centerTitle: true,
//       // currentIndex: _selectedTab,
//       // onTabChanged: (i) => setState(() => _selectedTab = i),
//       currentIndex: -1,                                   // secondary page, no tab highlighted
// onTabChanged: (i) => _handleTabChange(context, i),
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
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // ===== Toggle (matches Reminders style) =====
//           Center(
//             child: ToggleButtons(
//               isSelected: [_uploadMode, !_uploadMode],
//               borderRadius: BorderRadius.circular(8),
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
//               onPressed: (i) => setState(() => _uploadMode = i == 0),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('Upload Files'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('View Files'),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 12),

//           // ===== Upload Files =====
//           if (_uploadMode) _uploadCard(context),

//           // ===== View Files =====
//           if (!_uploadMode)
//             ..._rows
//                 .map((r) => _inventoryItemCard(context, r))
//                 .expand((w) => [w, const SizedBox(height: 12)]),
//         ],
//       ),
//     );
//   }

//   // ---------------- Upload card ----------------
//   Widget _uploadCard(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Upload Files',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: cs.onSurface,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 TextButton(onPressed: _clearAll, child: const Text('Clear')),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),

//             const SizedBox(height: 8),
//             _Dropdown<String>(
//               label: 'Project',
//               value: _project,
//               items: _projects,
//               onChanged: (v) => setState(() => _project = v),
//             ),
//             _Dropdown<String>(
//               label: 'Site',
//               value: _site,
//               items: _sites,
//               onChanged: (v) => setState(() => _site = v),
//             ),
//             _Dropdown<String>(
//               label: 'Document Type',
//               value: _docType,
//               items: _docTypes,
//               onChanged: (v) => setState(() => _docType = v),
//             ),
//             _ActionField(label: 'Choose File', onPressed: _pickFiles),
//             _FilesChips(files: _files, onRemove: _removeAt),
//             Padding(
//               padding: const EdgeInsets.only(top: 4),
//               child: Text(
//                 'Note: You can tap “Choose File” again to add up to 4 files.',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: cs.onSurfaceVariant,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed:
//                     _canUpload
//                         ? () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 'Uploading ${_files.length} file(s) to $_project / $_site ($_docType)…',
//                               ),
//                             ),
//                           );
//                         }
//                         : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Upload',
//                   style: TextStyle(fontWeight: FontWeight.w800),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- View Files row card ----------------
//   Widget _inventoryItemCard(BuildContext context, _InvItem r) {
//     final cs = Theme.of(context).colorScheme;

//     Widget kv(String label, String value) => Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: _labelW,
//             child: Text(
//               '$label:',
//               style: TextStyle(
//                 color: cs.onSurfaceVariant,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: cs.onSurface, fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '#${r.id.toString().padLeft(2, '0')}  ${r.project}',
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               Text(
//                 r.date,
//                 style: TextStyle(
//                   color: cs.onSurface,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),

//           kv('Project', r.project),
//           kv('Site', r.site),
//           kv('Doc Type', r.docType),
//           kv('File', r.fileName),

//           const SizedBox(height: 6),
//           Row(
//             children: [
//               OutlinedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.download_rounded, size: 18),
//                 label: const Text('Download'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: cs.outlineVariant),
//                   foregroundColor: cs.onSurface,
//                   backgroundColor: cs.surface,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   side: const BorderSide(color: AppTheme.accentColor),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                 ),
//                 child: const Text(
//                   'Update',
//                   style: TextStyle(color: Colors.black, fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---------------- Small UI helpers ----------------

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

// class _ActionField extends StatelessWidget {
//   final String label;
//   final VoidCallback? onPressed;
//   const _ActionField({required this.label, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: SizedBox(
//         height: 44,
//         child: OutlinedButton(
//           onPressed: onPressed,
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: cs.outlineVariant),
//             backgroundColor: cs.surface,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: onPressed == null ? cs.onSurfaceVariant : cs.onSurface,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FilesChips extends StatelessWidget {
//   final List<PlatformFile> files;
//   final void Function(int index) onRemove;
//   const _FilesChips({required this.files, required this.onRemove});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     if (files.isEmpty) {
//       return _FieldShell(
//         label: 'Selected Files',
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: cs.surface,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Text(
//             'No files selected',
//             style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           ),
//         ),
//       );
//     }

//     return _FieldShell(
//       label: 'Selected Files',
//       child: Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: [
//           for (int i = 0; i < files.length; i++)
//             InputChip(
//               label: Text(files[i].name, overflow: TextOverflow.ellipsis),
//               onDeleted: () => onRemove(i),
//               deleteIconColor: cs.onSurfaceVariant,
//               backgroundColor: cs.surface,
//               shape: StadiumBorder(side: BorderSide(color: cs.outlineVariant)),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _InvItem {
//   final int id;
//   final String date;
//   final String project;
//   final String site;
//   final String docType;
//   final String fileName;
//   _InvItem({
//     required this.id,
//     required this.date,
//     required this.project,
//     required this.site,
//     required this.docType,
//     required this.fileName,
//   });
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../../core/api_client.dart';

// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// // Bottom-nav routing
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class InventoryScreen extends StatefulWidget {
//   const InventoryScreen({super.key});

//   @override
//   State<InventoryScreen> createState() => _InventoryScreenState();
// }

// class _InventoryScreenState extends State<InventoryScreen> {
//   // toggle: true = Upload Files, false = View Files
//   bool _uploadMode = true;

//   // Shared lookups
//   final List<_Project> _projects = []; // id + name
//   List<String> _uploadSites = [];
//   List<String> _updateSites = [];

//   // Upload form
//   String? _projectId; // NOTE: id (to match API)
//   String? _site;
//   String? _docType;
//   final List<PlatformFile> _files = [];
//   bool _uploading = false;

//   // Inventory rows
//   final List<InventoryRow> _rows = [];
//   bool _loadingRows = false;

//   // Doc types (kept same as web)
//   static const List<String> _docTypes = [
//     'Signoff Report',
//     'HLD',
//     'LLD',
//     'Project Plan',
//     'Other',
//   ];

//   ApiClient get _api => context.read<ApiClient>();

//   @override
//   void initState() {
//     super.initState();
//     _prime();
//   }

//   Future<void> _prime() async {
//     await _loadProjects();
//     await _fetchRows();
//   }

//   // ───────────────────────────────────────────────────
//   // Data loading
//   // ───────────────────────────────────────────────────
//   Future<void> _loadProjects() async {
//     try {
//       final res = await _api.get('/api/projects');
//       if (res.statusCode < 200 || res.statusCode >= 300) return;
//       final data = jsonDecode(utf8.decode(res.bodyBytes));
//       _projects
//         ..clear()
//         ..addAll(
//           (data as List).map((p) {
//             return _Project(
//               id: (p['id'] ?? p['_id'] ?? '').toString(),
//               name: (p['project_name'] ?? '').toString(),
//             );
//           }),
//         );
//       setState(() {});
//     } catch (_) {
//       // ignore; keep empty
//     }
//   }

//   Future<void> _loadSitesForProjectId(
//     String? pid, {
//     bool forUpload = true,
//   }) async {
//     if (pid == null || pid.isEmpty) {
//       if (forUpload)
//         setState(() => _uploadSites = []);
//       else
//         setState(() => _updateSites = []);
//       return;
//     }
//     final pname =
//         _projects
//             .firstWhere(
//               (p) => p.id == pid,
//               orElse: () => _Project(id: pid, name: pid),
//             )
//             .name;
//     try {
//       final res = await _api.get(
//         '/api/project-sites/by-project-name/${Uri.encodeComponent(pname)}',
//       );
//       if (res.statusCode < 200 || res.statusCode >= 300) {
//         if (forUpload)
//           setState(() => _uploadSites = []);
//         else
//           setState(() => _updateSites = []);
//         return;
//       }
//       final arr = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
//       final sites =
//           arr
//               .map((e) => (e['site_name'] ?? '').toString())
//               .where((s) => s.isNotEmpty)
//               .toList();
//       if (forUpload) {
//         setState(() => _uploadSites = sites);
//       } else {
//         setState(() => _updateSites = sites);
//       }
//     } catch (_) {
//       if (forUpload)
//         setState(() => _uploadSites = []);
//       else
//         setState(() => _updateSites = []);
//     }
//   }

//   Future<void> _fetchRows() async {
//     setState(() => _loadingRows = true);
//     try {
//       final res = await _api.get('/api/inventory');
//       if (res.statusCode < 200 || res.statusCode >= 300)
//         throw Exception('HTTP ${res.statusCode}');
//       final body = jsonDecode(utf8.decode(res.bodyBytes));
//       final apiRows =
//           (body is Map && body['rows'] is List)
//               ? body['rows'] as List
//               : (body is List ? body : const []);
//       _rows
//         ..clear()
//         ..addAll(
//           apiRows.map((item) {
//             return InventoryRow(
//               id:
//                   item['id'] is int
//                       ? item['id'] as int
//                       : int.tryParse('${item['id']}') ?? 0,
//               date: _dateGb(item['uploaded_date'] ?? item['created_at']),
//               project:
//                   _projects
//                       .firstWhere(
//                         (p) => p.id == (item['project_id'] ?? ''),
//                         orElse:
//                             () => _Project(
//                               id: '${item['project_id']}',
//                               name: '${item['project_id']}',
//                             ),
//                       )
//                       .name,
//               site: (item['site'] ?? '').toString(),
//               docType: (item['doc_type'] ?? '').toString(),
//               fileName: (item['file_name'] ?? '').toString(),
//               s3Key: (item['s3_key'] ?? '').toString(),
//               projectId: (item['project_id'] ?? '').toString(),
//             );
//           }),
//         );
//     } catch (e) {
//       // show a toast once
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Failed to load inventory')));
//       }
//     } finally {
//       if (mounted) setState(() => _loadingRows = false);
//     }
//   }

//   String _dateGb(dynamic isoOrNull) {
//     try {
//       final dt = DateTime.tryParse('$isoOrNull') ?? DateTime.now();
//       final d = dt.day.toString().padLeft(2, '0');
//       final m = dt.month.toString().padLeft(2, '0');
//       final y = dt.year.toString();
//       return '$d/$m/$y';
//     } catch (_) {
//       return '';
//     }
//   }

//   // ───────────────────────────────────────────────────
//   // Upload flow
//   // ───────────────────────────────────────────────────
//   Future<void> _pickFiles() async {
//     final remaining = 4 - _files.length;
//     if (remaining <= 0) return;

//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       withReadStream: true,
//     );
//     if (result == null) return;

//     setState(() {
//       for (final f in result.files) {
//         if (_files.length >= 4) break;
//         final exists = _files.any((e) => e.name == f.name && e.size == f.size);
//         if (!exists) _files.add(f);
//       }
//     });
//   }

//   void _removeAt(int i) => setState(() => _files.removeAt(i));

//   void _clearAll() {
//     setState(() {
//       _projectId = null;
//       _site = null;
//       _docType = null;
//       _uploadSites = [];
//       _files.clear();
//     });
//   }

//   bool get _canUpload =>
//       _projectId != null &&
//       _projectId!.isNotEmpty &&
//       _site?.isNotEmpty == true &&
//       _docType?.isNotEmpty == true &&
//       _files.isNotEmpty;

//   Future<void> _doUpload() async {
//     if (!_canUpload) return;
//     setState(() => _uploading = true);
//     try {
//       for (final f in _files) {
//         final name = f.name;
//         final mime = _guessMime(name);
//         final qs = {
//           'filename': name,
//           'contentType': mime,
//           'projectId': _projectId!,
//           'site': _site!,
//           'docType': _docType!,
//         };
//         final presign = await _api.get(
//           '/api/inventory/presigned-put',
//           query: qs,
//         );
//         if (presign.statusCode < 200 || presign.statusCode >= 300)
//           throw Exception('presign failed');
//         final info = jsonDecode(utf8.decode(presign.bodyBytes)) as Map;

//         final uploadURL = info['uploadURL'] as String;
//         final key = info['key'] as String;

//         // PUT to S3 (no auth headers)
//         final bytes = f.bytes ?? await File(f.path!).readAsBytes();
//         final putRes = await http.put(
//           Uri.parse(uploadURL),
//           headers: {'Content-Type': mime},
//           body: bytes,
//         );
//         if (putRes.statusCode < 200 || putRes.statusCode >= 300) {
//           throw Exception('S3 PUT failed: ${putRes.statusCode}');
//         }

//         // POST record
//         final meta = {
//           'projectId': _projectId!,
//           'site': _site!,
//           'docType': _docType!,
//           's3Key': key,
//           'fileName': name,
//         };
//         final post = await _api.post('/api/inventory', body: meta);
//         if (post.statusCode < 200 || post.statusCode >= 300) {
//           throw Exception('POST /inventory failed');
//         }
//       }

//       if (mounted) {
//         _clearAll();
//         await _fetchRows();
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Upload successful')));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Upload failed')));
//       }
//     } finally {
//       if (mounted) setState(() => _uploading = false);
//     }
//   }

//   String _guessMime(String name) {
//     final lower = name.toLowerCase();
//     if (lower.endsWith('.pdf')) return 'application/pdf';
//     if (lower.endsWith('.csv')) return 'text/csv';
//     if (lower.endsWith('.xlsx'))
//       return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
//     if (lower.endsWith('.xls')) return 'application/vnd.ms-excel';
//     if (lower.endsWith('.docx'))
//       return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
//     if (lower.endsWith('.doc')) return 'application/msword';
//     if (lower.endsWith('.pptx'))
//       return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
//     if (lower.endsWith('.ppt')) return 'application/vnd.ms-powerpoint';
//     if (lower.endsWith('.json')) return 'application/json';
//     if (lower.endsWith('.txt')) return 'text/plain';
//     return 'application/octet-stream';
//   }

//   // ───────────────────────────────────────────────────
//   // Download
//   // ───────────────────────────────────────────────────
//   Future<void> _download(InventoryRow r) async {
//     try {
//       final res = await _api.get(
//         '/api/s3-presigned-get',
//         query: {'key': r.s3Key},
//       );
//       if (res.statusCode < 200 || res.statusCode >= 300)
//         throw Exception('HTTP ${res.statusCode}');
//       final data = jsonDecode(utf8.decode(res.bodyBytes));
//       final url = (data['downloadURL'] ?? '').toString();
//       if (url.isEmpty) throw Exception('No URL');
//       await launchUrlString(url, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Download link failed')));
//       }
//     }
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break; // Dashboard
//       case 1:
//         target = const AddProjectScreen();
//         break; // Add Project
//       case 2:
//         target = const AddActivityScreen();
//         break; // Add Activity
//       case 3:
//         target = const AnalyticsScreen();
//         break; // Analytics
//       case 4:
//         target = const ViewUsersScreen();
//         break; // View Users
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   static const double _labelW = 84;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Inventory',
//       centerTitle: true,
//       currentIndex: -1, // secondary page, no tab highlighted
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
//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // ===== Toggle =====
//           Center(
//             child: ToggleButtons(
//               isSelected: [_uploadMode, !_uploadMode],
//               borderRadius: BorderRadius.circular(8),
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
//               onPressed: (i) => setState(() => _uploadMode = i == 0),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('Upload Files'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('View Files'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),

//           // ===== Upload Files =====
//           if (_uploadMode) _uploadCard(context),

//           // ===== View Files =====
//           if (!_uploadMode)
//             if (_loadingRows)
//               const Padding(
//                 padding: EdgeInsets.only(top: 24),
//                 child: Center(child: CircularProgressIndicator()),
//               )
//             else if (_rows.isEmpty)
//               const Padding(
//                 padding: EdgeInsets.only(top: 24),
//                 child: Center(child: Text('No records found')),
//               )
//             else
//               ..._rows
//                   .map((r) => _inventoryItemCard(context, r))
//                   .expand((w) => [w, const SizedBox(height: 12)]),
//         ],
//       ),
//     );
//   }

//   // ---------------- Upload card ----------------
//   Widget _uploadCard(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Upload Files',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: cs.onSurface,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 TextButton(onPressed: _clearAll, child: const Text('Clear')),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),

//             const SizedBox(height: 8),
//             _Dropdown<_Project>(
//               label: 'Project',
//               value:
//                   _projects
//                       .where((p) => p.id == _projectId)
//                       .cast<_Project?>()
//                       .firstOrNull,
//               items: _projects,
//               onChanged: (p) {
//                 setState(() {
//                   _projectId = p?.id;
//                   _site = null;
//                 });
//                 _loadSitesForProjectId(_projectId, forUpload: true);
//               },
//               display: (p) => p.name,
//             ),
//             _Dropdown<String>(
//               label: 'Site',
//               value: _site,
//               items: _uploadSites,
//               onChanged: (v) => setState(() => _site = v),
//             ),
//             _Dropdown<String>(
//               label: 'Document Type',
//               value: _docType,
//               items: _docTypes,
//               onChanged: (v) => setState(() => _docType = v),
//             ),
//             _ActionField(
//               label: 'Choose File',
//               onPressed: _uploading ? null : _pickFiles,
//             ),
//             _FilesChips(
//               files: _files,
//               onRemove: _uploading ? (_) {} : _removeAt,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 4),
//               child: Text(
//                 'Note: You can tap “Choose File” again to add up to 4 files.',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: cs.onSurfaceVariant,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: _canUpload && !_uploading ? _doUpload : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   _uploading ? 'Uploading…' : 'Upload',
//                   style: const TextStyle(fontWeight: FontWeight.w800),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- View Files row card ----------------
//   Widget _inventoryItemCard(BuildContext context, InventoryRow r) {
//     final cs = Theme.of(context).colorScheme;

//     Widget kv(String label, String value) => Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: _labelW,
//             child: Text(
//               '$label:',
//               style: TextStyle(
//                 color: cs.onSurfaceVariant,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: cs.onSurface, fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '#${r.id.toString().padLeft(2, '0')}  ${r.project}',
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               Text(
//                 r.date,
//                 style: TextStyle(
//                   color: cs.onSurface,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),

//           kv('Project', r.project),
//           kv('Site', r.site),
//           kv('Doc Type', r.docType),
//           kv('File', r.fileName),

//           const SizedBox(height: 6),
//           Row(
//             children: [
//               OutlinedButton.icon(
//                 onPressed: () => _download(r),
//                 icon: const Icon(Icons.download_rounded, size: 18),
//                 label: const Text('Download'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: cs.outlineVariant),
//                   foregroundColor: cs.onSurface,
//                   backgroundColor: cs.surface,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               OutlinedButton(
//                 onPressed: () => _openUpdateSheet(r),
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   side: const BorderSide(color: AppTheme.accentColor),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                 ),
//                 child: const Text(
//                   'Update',
//                   style: TextStyle(color: Colors.black, fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────
//   // Update bottom sheet (mobile modal)
//   // ───────────────────────────────────────────────────
//   Future<void> _openUpdateSheet(InventoryRow row) async {
//     _updateSites = [];
//     await _loadSitesForProjectId(row.projectId, forUpload: false);

//     final nameC = TextEditingController(text: row.fileName);
//     String site = row.site;
//     String docType = row.docType;
//     PlatformFile? newFile;

//     await showModalBottomSheet<void>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) {
//         final cs = Theme.of(ctx).colorScheme;
//         final insets = MediaQuery.of(ctx).viewInsets;
//         return Padding(
//           padding: EdgeInsets.only(bottom: insets.bottom),
//           child: SafeArea(
//             top: false,
//             child: StatefulBuilder(
//               builder: (ctx, setM) {
//                 Future<void> pickReplace() async {
//                   final result = await FilePicker.platform.pickFiles(
//                     withReadStream: true,
//                   );
//                   if (result == null) return;
//                   setM(() {
//                     newFile = result.files.first;
//                     nameC.text = newFile!.name;
//                   });
//                 }

//                 Future<void> clearReplace() async {
//                   setM(() {
//                     newFile = null;
//                     nameC.text = row.fileName;
//                   });
//                 }

//                 Future<void> doDelete() async {
//                   Navigator.of(ctx).pop(); // close first
//                   try {
//                     final res = await _api.delete('/api/inventory/${row.id}');
//                     if (res.statusCode < 200 || res.statusCode >= 300)
//                       throw Exception('delete failed');
//                     _rows.removeWhere((r) => r.id == row.id);
//                     if (mounted) {
//                       setState(() {});
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Deleted successfully')),
//                       );
//                     }
//                   } catch (_) {
//                     if (mounted) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Delete failed')),
//                       );
//                     }
//                   }
//                 }

//                 Future<void> doUpdate() async {
//                   try {
//                     String finalKey = row.s3Key;

//                     if (newFile != null) {
//                       final mime = _guessMime(newFile!.name);
//                       final pres = await _api.get(
//                         '/api/inventory/presigned-put',
//                         query: {
//                           'filename': newFile!.name,
//                           'contentType': mime,
//                           'projectId':
//                               row.projectId, // mirrors web modal behavior
//                           'site': site,
//                           'docType': docType,
//                         },
//                       );
//                       if (pres.statusCode < 200 || pres.statusCode >= 300)
//                         throw Exception('presign failed');
//                       final info =
//                           jsonDecode(utf8.decode(pres.bodyBytes)) as Map;
//                       final uploadURL = info['uploadURL'] as String;
//                       final key = info['key'] as String;

//                       final bytes =
//                           newFile!.bytes ??
//                           await File(newFile!.path!).readAsBytes();
//                       final putRes = await http.put(
//                         Uri.parse(uploadURL),
//                         headers: {'Content-Type': mime},
//                         body: bytes,
//                       );
//                       if (putRes.statusCode < 200 || putRes.statusCode >= 300) {
//                         throw Exception('S3 PUT failed');
//                       }
//                       finalKey = key;
//                     }

//                     final body = {
//                       'site': site,
//                       'docType': docType,
//                       'fileName': nameC.text.trim(),
//                       if (newFile != null) 's3Key': finalKey,
//                     };

//                     final upd = await _api.put(
//                       '/api/inventory/${row.id}',
//                       body: body,
//                     );
//                     if (upd.statusCode < 200 || upd.statusCode >= 300)
//                       throw Exception('update failed');

//                     // Update local row
//                     setState(() {
//                       row.site = site;
//                       row.docType = docType;
//                       row.fileName = nameC.text.trim();
//                       row.s3Key = finalKey;
//                     });
//                     if (mounted) {
//                       Navigator.of(ctx).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Updated successfully')),
//                       );
//                     }
//                   } catch (_) {
//                     if (mounted) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Update failed')),
//                       );
//                     }
//                   }
//                 }

//                 return Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 44,
//                         height: 4,
//                         margin: const EdgeInsets.only(bottom: 12),
//                         decoration: BoxDecoration(
//                           color: cs.outlineVariant,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                       Text(
//                         'Update Inventory',
//                         style: TextStyle(
//                           color: cs.onSurface,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Read-only row: Date + Project
//                       Row(
//                         children: [
//                           Expanded(child: _roField(ctx, 'Date', row.date)),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: _roField(ctx, 'Project', row.project),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),

//                       // Site + DocType
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _Dropdown<String>(
//                               label: 'Site',
//                               value: site,
//                               items: _updateSites,
//                               onChanged: (v) => setM(() => site = v ?? site),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: _Dropdown<String>(
//                               label: 'Doc Type',
//                               value: docType,
//                               items: _docTypes,
//                               onChanged:
//                                   (v) => setM(() => docType = v ?? docType),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 10),
//                       _FieldShell(
//                         label: 'File',
//                         child: SizedBox(
//                           height: 44,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: OutlinedButton(
//                                   onPressed: pickReplace,
//                                   style: OutlinedButton.styleFrom(
//                                     side: BorderSide(color: cs.outlineVariant),
//                                     backgroundColor: cs.surface,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       nameC.text,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(color: cs.onSurface),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 onPressed: clearReplace,
//                                 icon: const Icon(Icons.close_rounded, size: 18),
//                                 color: cs.onSurfaceVariant,
//                                 style: IconButton.styleFrom(
//                                   backgroundColor: cs.surface,
//                                   side: BorderSide(color: cs.outlineVariant),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           OutlinedButton(
//                             onPressed: doDelete,
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.red.shade300,
//                               side: BorderSide(color: Colors.red.shade300),
//                             ),
//                             child: const Text('Delete'),
//                           ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => Navigator.of(ctx).pop(),
//                             child: const Text('Cancel'),
//                           ),
//                           const SizedBox(width: 6),
//                           ElevatedButton(
//                             onPressed: doUpdate,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green.shade600,
//                               foregroundColor: Colors.white,
//                             ),
//                             child: const Text('Update'),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _roField(BuildContext ctx, String label, String value) {
//     final cs = Theme.of(ctx).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: Container(
//         height: 44,
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: cs.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 value,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(color: cs.onSurface),
//               ),
//             ),
//             Text(
//               'Read-only',
//               style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------------- Small UI helpers ----------------

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

// class _Dropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   final String Function(T item)? display;
//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.display,
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
//                       (e) => DropdownMenuItem<T>(
//                         value: e,
//                         child: Text(
//                           display != null ? display!(e) : '$e',
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
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

// class _ActionField extends StatelessWidget {
//   final String label;
//   final VoidCallback? onPressed;
//   const _ActionField({required this.label, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: SizedBox(
//         height: 44,
//         child: OutlinedButton(
//           onPressed: onPressed,
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: cs.outlineVariant),
//             backgroundColor: cs.surface,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: onPressed == null ? cs.onSurfaceVariant : cs.onSurface,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FilesChips extends StatelessWidget {
//   final List<PlatformFile> files;
//   final void Function(int index) onRemove;
//   const _FilesChips({required this.files, required this.onRemove});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     if (files.isEmpty) {
//       return _FieldShell(
//         label: 'Selected Files',
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: cs.surface,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Text(
//             'No files selected',
//             style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           ),
//         ),
//       );
//     }

//     return _FieldShell(
//       label: 'Selected Files',
//       child: Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: [
//           for (int i = 0; i < files.length; i++)
//             InputChip(
//               label: Text(files[i].name, overflow: TextOverflow.ellipsis),
//               onDeleted: () => onRemove(i),
//               deleteIconColor: cs.onSurfaceVariant,
//               backgroundColor: cs.surface,
//               shape: StadiumBorder(side: BorderSide(color: cs.outlineVariant)),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ───────────────────────────────────────────────────
// // Models
// // ───────────────────────────────────────────────────
// class _Project {
//   final String id;
//   final String name;
//   const _Project({required this.id, required this.name});
// }

// class InventoryRow {
//   final int id;
//   final String projectId; // so we can fetch sites in modal
//   String date; // dd/mm/yyyy
//   String project; // project_name
//   String site;
//   String docType;
//   String fileName;
//   String s3Key;

//   InventoryRow({
//     required this.id,
//     required this.date,
//     required this.project,
//     required this.site,
//     required this.docType,
//     required this.fileName,
//     required this.s3Key,
//     required this.projectId,
//   });
// }

// // Nice helper for optional .firstOrNull
// extension _FirstOrNull<E> on Iterable<E> {
//   E? get firstOrNull => isEmpty ? null : first;
// }

////
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../../core/api_client.dart';

import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

// Bottom-nav routing
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // toggle: true = Upload Files, false = View Files
  bool _uploadMode = true;

  // Shared lookups
  final List<_Project> _projects = []; // id + name
  List<String> _uploadSites = [];
  List<String> _updateSites = [];

  // Upload form
  String? _projectId; // NOTE: id (to match API)
  String? _site;
  String? _docType;
  final List<PlatformFile> _files = [];
  bool _uploading = false;

  // Inventory rows
  final List<InventoryRow> _rows = [];
  bool _loadingRows = false;

  // Doc types (kept same as web)
  static const List<String> _docTypes = [
    'Signoff Report',
    'HLD',
    'LLD',
    'Project Plan',
    'Other',
  ];

  ApiClient get _api => context.read<ApiClient>();

  @override
  void initState() {
    super.initState();
    _prime();
  }

  Future<void> _prime() async {
    await _loadProjects();
    await _fetchRows();
  }

  // ───────────────────────────────────────────────────
  // Data loading
  // ───────────────────────────────────────────────────
  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode < 200 || res.statusCode >= 300) return;
      final data = jsonDecode(utf8.decode(res.bodyBytes));
      _projects
        ..clear()
        ..addAll(
          (data as List).map((p) {
            return _Project(
              id: (p['id'] ?? p['_id'] ?? '').toString(),
              name: (p['project_name'] ?? '').toString(),
            );
          }),
        );
      setState(() {});
    } catch (_) {
      // ignore; keep empty
    }
  }

  Future<void> _loadSitesForProjectId(
    String? pid, {
    bool forUpload = true,
  }) async {
    if (pid == null || pid.isEmpty) {
      if (forUpload)
        setState(() => _uploadSites = []);
      else
        setState(() => _updateSites = []);
      return;
    }
    final pname =
        _projects
            .firstWhere(
              (p) => p.id == pid,
              orElse: () => _Project(id: pid, name: pid),
            )
            .name;
    try {
      final res = await _api.get(
        '/api/project-sites/by-project-name/${Uri.encodeComponent(pname)}',
      );
      if (res.statusCode < 200 || res.statusCode >= 300) {
        if (forUpload)
          setState(() => _uploadSites = []);
        else
          setState(() => _updateSites = []);
        return;
      }
      final arr = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
      final sites =
          arr
              .map((e) => (e['site_name'] ?? '').toString())
              .where((s) => s.isNotEmpty)
              .toList();
      if (forUpload) {
        setState(() => _uploadSites = sites);
      } else {
        setState(() => _updateSites = sites);
      }
    } catch (_) {
      if (forUpload)
        setState(() => _uploadSites = []);
      else
        setState(() => _updateSites = []);
    }
  }

  Future<void> _fetchRows() async {
    setState(() => _loadingRows = true);
    try {
      final res = await _api.get('/api/inventory');
      if (res.statusCode < 200 || res.statusCode >= 300)
        throw Exception('HTTP ${res.statusCode}');
      final body = jsonDecode(utf8.decode(res.bodyBytes));
      final apiRows =
          (body is Map && body['rows'] is List)
              ? body['rows'] as List
              : (body is List ? body : const []);
      _rows
        ..clear()
        ..addAll(
          apiRows.map((item) {
            return InventoryRow(
              id:
                  item['id'] is int
                      ? item['id'] as int
                      : int.tryParse('${item['id']}') ?? 0,
              date: _dateGb(item['uploaded_date'] ?? item['created_at']),
              project:
                  _projects
                      .firstWhere(
                        (p) => p.id == (item['project_id'] ?? ''),
                        orElse:
                            () => _Project(
                              id: '${item['project_id']}',
                              name: '${item['project_id']}',
                            ),
                      )
                      .name,
              site: (item['site'] ?? '').toString(),
              docType: (item['doc_type'] ?? '').toString(),
              fileName: (item['file_name'] ?? '').toString(),
              s3Key: (item['s3_key'] ?? '').toString(),
              projectId: (item['project_id'] ?? '').toString(),
            );
          }),
        );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load inventory')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingRows = false);
    }
  }

  String _dateGb(dynamic isoOrNull) {
    try {
      final dt = DateTime.tryParse('$isoOrNull') ?? DateTime.now();
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year.toString();
      return '$d/$m/$y';
    } catch (_) {
      return '';
    }
  }

  // ───────────────────────────────────────────────────
  // Upload flow
  // ───────────────────────────────────────────────────
  Future<void> _pickFiles() async {
    final remaining = 4 - _files.length;
    if (remaining <= 0) return;

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: true,
    );
    if (result == null) return;

    setState(() {
      for (final f in result.files) {
        if (_files.length >= 4) break;
        final exists = _files.any((e) => e.name == f.name && e.size == f.size);
        if (!exists) _files.add(f);
      }
    });
  }

  void _removeAt(int i) => setState(() => _files.removeAt(i));

  void _clearAll() {
    setState(() {
      _projectId = null;
      _site = null;
      _docType = null;
      _uploadSites = [];
      _files.clear();
    });
  }

  bool get _canUpload =>
      _projectId != null &&
      _projectId!.isNotEmpty &&
      _site?.isNotEmpty == true &&
      _docType?.isNotEmpty == true &&
      _files.isNotEmpty;

  Future<void> _doUpload() async {
    if (!_canUpload) return;
    setState(() => _uploading = true);
    try {
      for (final f in _files) {
        final name = f.name;
        final mime = _guessMime(name);
        final qs = {
          'filename': name,
          'contentType': mime,
          'projectId': _projectId!,
          'site': _site!,
          'docType': _docType!,
        };
        final presign = await _api.get(
          '/api/inventory/presigned-put',
          query: qs,
        );
        if (presign.statusCode < 200 || presign.statusCode >= 300) {
          throw Exception('presign failed');
        }
        final info = jsonDecode(utf8.decode(presign.bodyBytes)) as Map;

        final uploadURL = info['uploadURL'] as String;
        final key = info['key'] as String;

        // PUT to S3 (no auth headers)
        final bytes = f.bytes ?? await File(f.path!).readAsBytes();
        final putRes = await http.put(
          Uri.parse(uploadURL),
          headers: {'Content-Type': mime},
          body: bytes,
        );
        if (putRes.statusCode < 200 || putRes.statusCode >= 300) {
          throw Exception('S3 PUT failed: ${putRes.statusCode}');
        }

        // POST record
        final meta = {
          'projectId': _projectId!,
          'site': _site!,
          'docType': _docType!,
          's3Key': key,
          'fileName': name,
        };
        final post = await _api.post('/api/inventory', body: meta);
        if (post.statusCode < 200 || post.statusCode >= 300) {
          throw Exception('POST /inventory failed');
        }
      }

      if (mounted) {
        _clearAll();
        await _fetchRows();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Upload successful')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Upload failed')));
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  String _guessMime(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.pdf')) return 'application/pdf';
    if (lower.endsWith('.csv')) return 'text/csv';
    if (lower.endsWith('.xlsx'))
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    if (lower.endsWith('.xls')) return 'application/vnd.ms-excel';
    if (lower.endsWith('.docx'))
      return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    if (lower.endsWith('.doc')) return 'application/msword';
    if (lower.endsWith('.pptx'))
      return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
    if (lower.endsWith('.ppt')) return 'application/vnd.ms-powerpoint';
    if (lower.endsWith('.json')) return 'application/json';
    if (lower.endsWith('.txt')) return 'text/plain';
    return 'application/octet-stream';
  }

  // ───────────────────────────────────────────────────
  // Download
  // ───────────────────────────────────────────────────
  Future<void> _download(InventoryRow r) async {
    try {
      final res = await _api.get(
        '/api/s3-presigned-get',
        query: {'key': r.s3Key},
      );
      if (res.statusCode < 200 || res.statusCode >= 300) {
        throw Exception('HTTP ${res.statusCode}');
      }
      final data = jsonDecode(utf8.decode(res.bodyBytes));
      final url = (data['downloadURL'] ?? '').toString();
      if (url.isEmpty) throw Exception('No URL');
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Download link failed')));
      }
    }
  }

  void _handleTabChange(BuildContext context, int i) {
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
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  static const double _labelW = 84;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Inventory',
      centerTitle: true,
      currentIndex: -1,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
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
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // ===== Toggle =====
          Center(
            child: ToggleButtons(
              isSelected: [_uploadMode, !_uploadMode],
              borderRadius: BorderRadius.circular(8),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
              onPressed: (i) async {
                // Switch view
                setState(() => _uploadMode = i == 0);
                // ✅ Auto-refresh when going to "View Files"
                if (i == 1) {
                  await _fetchRows();
                }
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Upload Files'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('View Files'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ===== Upload Files =====
          if (_uploadMode) _uploadCard(context),

          // ===== View Files =====
          if (!_uploadMode)
            if (_loadingRows)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_rows.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: Text('No records found')),
              )
            else
              ..._rows
                  .map((r) => _inventoryItemCard(context, r))
                  .expand((w) => [w, const SizedBox(height: 12)]),
        ],
      ),
    );
  }

  // ---------------- Upload card ----------------
  Widget _uploadCard(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Upload Files',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(onPressed: _clearAll, child: const Text('Clear')),
              ],
            ),
            Divider(color: cs.outlineVariant),

            const SizedBox(height: 8),
            _Dropdown<_Project>(
              label: 'Project',
              value:
                  _projects
                      .where((p) => p.id == _projectId)
                      .cast<_Project?>()
                      .firstOrNull,
              items: _projects,
              onChanged: (p) {
                setState(() {
                  _projectId = p?.id;
                  _site = null;
                });
                _loadSitesForProjectId(_projectId, forUpload: true);
              },
              display: (p) => p.name,
            ),

            // ✅ Searchable Site picker
            _SearchableSelect(
              label: 'Site',
              value: _site,
              items: _uploadSites,
              hintText: 'Search site name or ID',
              onChanged: (v) => setState(() => _site = v),
              enabled: _uploadSites.isNotEmpty,
            ),

            _Dropdown<String>(
              label: 'Document Type',
              value: _docType,
              items: _docTypes,
              onChanged: (v) => setState(() => _docType = v),
            ),
            _ActionField(
              label: 'Choose File',
              onPressed: _uploading ? null : _pickFiles,
            ),
            _FilesChips(
              files: _files,
              onRemove: _uploading ? (_) {} : _removeAt,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Note: You can tap “Choose File” again to add up to 4 files.',
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _canUpload && !_uploading ? _doUpload : null,
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
                child: Text(
                  _uploading ? 'Uploading…' : 'Upload',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- View Files row card ----------------
  Widget _inventoryItemCard(BuildContext context, InventoryRow r) {
    final cs = Theme.of(context).colorScheme;

    Widget kv(String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelW,
            child: Text(
              '$label:',
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: cs.onSurface, fontSize: 12),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '#${r.id.toString().padLeft(2, '0')}  ${r.project}',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                r.date,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 8),

          kv('Project', r.project),
          kv('Site', r.site),
          kv('Doc Type', r.docType),
          kv('File', r.fileName),

          const SizedBox(height: 6),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _download(r),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.outlineVariant),
                  foregroundColor: cs.onSurface,
                  backgroundColor: cs.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () => _openUpdateSheet(r),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  side: const BorderSide(color: AppTheme.accentColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────
  // Update bottom sheet (mobile modal)
  // ───────────────────────────────────────────────────
  Future<void> _openUpdateSheet(InventoryRow row) async {
    _updateSites = [];
    await _loadSitesForProjectId(row.projectId, forUpload: false);

    final nameC = TextEditingController(text: row.fileName);
    String site = row.site;
    String docType = row.docType;
    PlatformFile? newFile;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        final insets = MediaQuery.of(ctx).viewInsets;
        return Padding(
          padding: EdgeInsets.only(bottom: insets.bottom),
          child: SafeArea(
            top: false,
            child: StatefulBuilder(
              builder: (ctx, setM) {
                Future<void> pickReplace() async {
                  final result = await FilePicker.platform.pickFiles(
                    withReadStream: true,
                  );
                  if (result == null) return;
                  setM(() {
                    newFile = result.files.first;
                    nameC.text = newFile!.name;
                  });
                }

                Future<void> clearReplace() async {
                  setM(() {
                    newFile = null;
                    nameC.text = row.fileName;
                  });
                }

                Future<void> doDelete() async {
                  Navigator.of(ctx).pop(); // close first
                  try {
                    final res = await _api.delete('/api/inventory/${row.id}');
                    if (res.statusCode < 200 || res.statusCode >= 300) {
                      throw Exception('delete failed');
                    }
                    _rows.removeWhere((r) => r.id == row.id);
                    if (mounted) {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deleted successfully')),
                      );
                    }
                  } catch (_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Delete failed')),
                      );
                    }
                  }
                }

                Future<void> doUpdate() async {
                  try {
                    String finalKey = row.s3Key;

                    if (newFile != null) {
                      final mime = _guessMime(newFile!.name);
                      final pres = await _api.get(
                        '/api/inventory/presigned-put',
                        query: {
                          'filename': newFile!.name,
                          'contentType': mime,
                          'projectId': row.projectId,
                          'site': site,
                          'docType': docType,
                        },
                      );
                      if (pres.statusCode < 200 || pres.statusCode >= 300) {
                        throw Exception('presign failed');
                      }
                      final info =
                          jsonDecode(utf8.decode(pres.bodyBytes)) as Map;
                      final uploadURL = info['uploadURL'] as String;
                      final key = info['key'] as String;

                      final bytes =
                          newFile!.bytes ??
                          await File(newFile!.path!).readAsBytes();
                      final putRes = await http.put(
                        Uri.parse(uploadURL),
                        headers: {'Content-Type': mime},
                        body: bytes,
                      );
                      if (putRes.statusCode < 200 || putRes.statusCode >= 300) {
                        throw Exception('S3 PUT failed');
                      }
                      finalKey = key;
                    }

                    final body = {
                      'site': site,
                      'docType': docType,
                      'fileName': nameC.text.trim(),
                      if (newFile != null) 's3Key': finalKey,
                    };

                    final upd = await _api.put(
                      '/api/inventory/${row.id}',
                      body: body,
                    );
                    if (upd.statusCode < 200 || upd.statusCode >= 300) {
                      throw Exception('update failed');
                    }

                    // Update local row
                    setState(() {
                      row.site = site;
                      row.docType = docType;
                      row.fileName = nameC.text.trim();
                      row.s3Key = finalKey;
                    });
                    if (mounted) {
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Updated successfully')),
                      );
                    }
                  } catch (_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Update failed')),
                      );
                    }
                  }
                }

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: cs.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        'Update Inventory',
                        style: TextStyle(
                          color: cs.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Read-only row: Date + Project
                      Row(
                        children: [
                          Expanded(child: _roField(ctx, 'Date', row.date)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _roField(ctx, 'Project', row.project),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Site + DocType
                      Row(
                        children: [
                          Expanded(
                            // (kept simple here; upload has the searchable picker)
                            child: _Dropdown<String>(
                              label: 'Site',
                              value: site,
                              items: _updateSites,
                              onChanged: (v) => setM(() => site = v ?? site),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _Dropdown<String>(
                              label: 'Doc Type',
                              value: docType,
                              items: _docTypes,
                              onChanged:
                                  (v) => setM(() => docType = v ?? docType),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      _FieldShell(
                        label: 'File',
                        child: SizedBox(
                          height: 44,
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: pickReplace,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: cs.outlineVariant),
                                    backgroundColor: cs.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      nameC.text,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: cs.onSurface),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: clearReplace,
                                icon: const Icon(Icons.close_rounded, size: 18),
                                color: cs.onSurfaceVariant,
                                style: IconButton.styleFrom(
                                  backgroundColor: cs.surface,
                                  side: BorderSide(color: cs.outlineVariant),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: doDelete,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red.shade300,
                              side: BorderSide(color: Colors.red.shade300),
                            ),
                            child: const Text('Delete'),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 6),
                          ElevatedButton(
                            onPressed: doUpdate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _roField(BuildContext ctx, String label, String value) {
    final cs = Theme.of(ctx).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        height: 44,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: cs.onSurface),
              ),
            ),
            Text(
              'Read-only',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Small UI helpers ----------------

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

class _Dropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T item)? display;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.display,
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
                      (e) => DropdownMenuItem<T>(
                        value: e,
                        child: Text(
                          display != null ? display!(e) : '$e',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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

class _ActionField extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _ActionField({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: cs.outlineVariant),
            backgroundColor: cs.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: onPressed == null ? cs.onSurfaceVariant : cs.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilesChips extends StatelessWidget {
  final List<PlatformFile> files;
  final void Function(int index) onRemove;
  const _FilesChips({required this.files, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (files.isEmpty) {
      return _FieldShell(
        label: 'Selected Files',
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Text(
            'No files selected',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          ),
        ),
      );
    }

    return _FieldShell(
      label: 'Selected Files',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (int i = 0; i < files.length; i++)
            InputChip(
              label: Text(files[i].name, overflow: TextOverflow.ellipsis),
              onDeleted: () => onRemove(i),
              deleteIconColor: cs.onSurfaceVariant,
              backgroundColor: cs.surface,
              shape: StadiumBorder(side: BorderSide(color: cs.outlineVariant)),
            ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────
/// Searchable single-select (bottom sheet)
/// ─────────────────────────────────────────────────────────
class _SearchableSelect extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool enabled;
  final String hintText;

  const _SearchableSelect({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    this.hintText = 'Search…',
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Future<void> openPicker() async {
      if (!enabled) return;
      final controller = TextEditingController();
      String? selected = value;

      // await showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      //   ),
      //   builder: (ctx) {
      //     final viewInsets = MediaQuery.of(ctx).viewInsets;
      //     return Padding(
      //       padding: EdgeInsets.only(bottom: viewInsets.bottom),
      //       child: StatefulBuilder(
      //         builder: (ctx, setS) {

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true, // <-- add this
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (ctx) {
          final viewInsets = MediaQuery.of(ctx).viewInsets;
          return Padding(
            padding: EdgeInsets.only(
              bottom: viewInsets.bottom,
              top: 12, // <-- add a little breathing room from the top
            ),
            child: StatefulBuilder(
              builder: (ctx, setS) {
                final q = controller.text.trim().toLowerCase();
                final filtered =
                    q.isEmpty
                        ? items
                        : items
                            .where((s) => s.toLowerCase().contains(q))
                            .toList();

                return SafeArea(
                  top: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 4,
                        margin: const EdgeInsets.only(top: 8, bottom: 12),
                        decoration: BoxDecoration(
                          color: cs.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: controller,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: hintText,
                            prefixIcon: const Icon(Icons.search_rounded),
                            filled: true,
                            fillColor: cs.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (_) => setS(() {}),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (ctx, i) {
                            final s = filtered[i];
                            final isSel = s == selected;
                            return ListTile(
                              title: Text(s, overflow: TextOverflow.ellipsis),
                              trailing:
                                  isSel
                                      ? const Icon(Icons.check_rounded)
                                      : null,
                              onTap: () {
                                selected = s;
                                onChanged(s);
                                Navigator.of(ctx).pop();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return _FieldShell(
      label: label,
      child: GestureDetector(
        onTap: openPicker,
        child: Container(
          height: 44,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value?.isNotEmpty == true ? value! : 'Select',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        value?.isNotEmpty == true
                            ? cs.onSurface
                            : cs.onSurfaceVariant,
                  ),
                ),
              ),
              Icon(Icons.search_rounded, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────
// Models
// ───────────────────────────────────────────────────
class _Project {
  final String id;
  final String name;
  const _Project({required this.id, required this.name});
}

class InventoryRow {
  final int id;
  final String projectId; // so we can fetch sites in modal
  String date; // dd/mm/yyyy
  String project; // project_name
  String site;
  String docType;
  String fileName;
  String s3Key;

  InventoryRow({
    required this.id,
    required this.date,
    required this.project,
    required this.site,
    required this.docType,
    required this.fileName,
    required this.s3Key,
    required this.projectId,
  });
}

// Nice helper for optional .firstOrNull
extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
