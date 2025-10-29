// import 'package:flutter/material.dart';
// import 'dart:math';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// // Root tabs for bottom-nav routing
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';


// import '../modals/update_project_modal.dart';


// class ViewProjectsScreen extends StatefulWidget {
//   const ViewProjectsScreen({super.key});

//   @override
//   State<ViewProjectsScreen> createState() => _ViewProjectsScreenState();
// }

// class _ViewProjectsScreenState extends State<ViewProjectsScreen> {
  
//   final int _selectedTab = 1;

//   // Filter + sample data
//   final List<String> _projectFilter = const ['All', 'NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   String _selectedProject = 'All';
//   String _query = '';

//   final List<_Project> _projects = List.generate(12, (i) {
//     final names = ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//     final types = ['AMC', 'Deployment', 'Rollout'];
//     final customers = ['TCL GSTN', 'ACME Corp', 'Globex'];
//     final bdm = ['Amey', 'Priya', 'Rahul'];

//     final name = names[i % names.length];
//     return _Project(
//       projectName: name,
//       type: types[i % types.length],
//       customerName: customers[i % customers.length],
//       projectCode: 'AUTO-${(i + 1).toString().padLeft(3, '0')}',
//       projectManager: ['Aniket', 'Riya', 'Shreya'][i % 3],
//       bdm: bdm[i % bdm.length],
//       startDate: '01/0${(i % 9) + 1}/2025',
//       endDate: '2${(i % 8) + 1}/12/2025',
//       amcYear: '${2025 + (i % 3)}',
//       amcMonths: ((i % 12) + 1).toString(),
//       subProjects: i % 3 == 0 ? ['SP-${i+1}', 'Child ${i+2}'] : const [],
//     );
//   });


//   void _handleProjectUpdated(ProjectDto updated) {
//   setState(() {
//     // identify by projectCode; adjust if your real key is different
//     final i = _projects.indexWhere((x) => x.projectCode == updated.projectCode);
//     if (i != -1) {
//       _projects[i] = _Project(
//         projectName: updated.projectName,
//         type:        updated.type,
//         customerName:updated.customerName,
//         projectCode:  updated.projectCode,
//         projectManager: updated.projectManager,
//         bdm:           updated.bdm,
//         startDate:     updated.startDate,
//         endDate:       updated.endDate,
//         amcYear:       updated.amcYear,
//         amcMonths:     updated.amcMonths,
//         subProjects:   updated.subProjects,
//       );
//     }
//   });
// }


//   List<_Project> get _filtered {
//     return _projects.where((p) {
//       final okProject = _selectedProject == 'All' || p.projectName == _selectedProject;
//       final q = _query.trim().toLowerCase();
//       final okSearch = q.isEmpty ||
//           p.projectName.toLowerCase().contains(q) ||
//           p.customerName.toLowerCase().contains(q) ||
//           p.projectCode.toLowerCase().contains(q);
//       return okProject && okSearch;
//     }).toList();
//   }

//   // ---- BottomNav routing (keep consistent across pages) ----
//   void _handleTabChange(int i) {
//     if (i == _selectedTab) return;
//     late final Widget target;
//     switch (i) {
//       case 0: target = const DashboardScreen(); break;
//       case 1: target = const AddProjectScreen(); break; // "Projects" root leads to add/create
//       case 2: target = const AddActivityScreen(); break;
//       case 3: target = const AnalyticsScreen(); break;
//       case 4: target = const ViewUsersScreen(); break;
//       default: return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final pad = responsivePadding(context);

//     return MainLayout(
//       title: 'All Projects',
//       centerTitle: true,
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
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: ListView(
//         padding: pad.copyWith(top: 6, bottom: 12),
//         children: [
//           // Search
//           const SizedBox(height: 4),
//           _SearchField(
//             onChanged: (v) => setState(() => _query = v),
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),

//           // Filter row: dropdown + Export
//           Row(
//             children: [
//               Expanded(
//                 child: _CompactDropdown<String>(
//                   value: _selectedProject,
//                   items: _projectFilter,
//                   hint: 'Select Project',
//                   onChanged: (v) => setState(() => _selectedProject = v ?? 'All'),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               SizedBox(
//                 height: 34,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Export starting…')),
//                     );
//                   },
//                   icon: const Icon(Icons.download, color: Colors.black, size: 18),
//                   label: const Text('Export', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.accentColor,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // Project cards
//           // ..._filtered.map((p) => _ProjectCard(p: p)),
//           ..._filtered.map((p) => _ProjectCard(
//   p: p,
//   onUpdated: _handleProjectUpdated,
// )),

//           if (_filtered.isEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Center(
//                 child: Text('No projects found', style: TextStyle(color: cs.onSurfaceVariant)),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _ProjectCard extends StatelessWidget {
//   final _Project p;
//   // const _ProjectCard({required this.p});

//   // final _Project p;
//   final void Function(ProjectDto updated)? onUpdated; // NEW
//   const _ProjectCard({required this.p, this.onUpdated});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 p.projectName,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 'Type : ${p.type}',
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // Two-column details
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow('Customer Name', p.customerName, labelColor, valueColor),
//                     _infoRow('Project Code', p.projectCode, labelColor, valueColor),
//                     if (p.subProjects.isEmpty)
//         _infoRow('Sub Project', '—', labelColor, valueColor)
//       else
//         Padding(
//           padding: const EdgeInsets.only(bottom: 4),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Sub Project:', style: TextStyle(color: labelColor, fontSize: 11)),
//               const SizedBox(height: 4),
//               Wrap(
//                 spacing: 6,
//                 runSpacing: 6,
//                 children: p.subProjects.map((s) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
//                     ),
//                     child: Text(s, style: TextStyle(color: valueColor, fontSize: 11)),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//                     _infoRow('Project Manager', p.projectManager, labelColor, valueColor),
//                     _infoRow('BDM', p.bdm, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Right
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow('Start Date', p.startDate, labelColor, valueColor),
//                     _infoRow('End Date', p.endDate, labelColor, valueColor),
//                     _infoRow('AMC Year', p.amcYear, labelColor, valueColor),
//                     _infoRow('AMC Months', p.amcMonths, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               // onPressed: () {},
//               onPressed: () async {
//         final result = await showModalBottomSheet<ProjectDto>(
//           context: context,
//           isScrollControlled: true,
//           backgroundColor: Colors.transparent,
//           builder: (_) => UpdateProjectModal(
//             project: ProjectDto(
//               projectName: p.projectName,
//               type:        p.type,
//               customerName:p.customerName,
//               projectCode: p.projectCode,
//               projectManager: p.projectManager,
//               bdm:           p.bdm,
//               startDate:     p.startDate,
//               endDate:       p.endDate,
//               amcYear:       p.amcYear,
//               amcMonths:     p.amcMonths,
//               subProjects:   p.subProjects,
//             ),
//           ),
//         );
//         if (result != null && onUpdated != null) {
//           onUpdated!(result);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Project updated')),
//           );
//         }
//       },
//               child: const Text('Update', style: TextStyle(color: Colors.black, fontSize: 12)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, Color labelColor, Color valueColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$label: ',
//           style: TextStyle(color: labelColor, fontSize: 11),
//           children: [
//             TextSpan(text: value, style: TextStyle(color: valueColor, fontSize: 11)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final ValueChanged<String>? onChanged;
//   const _SearchField({this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         onChanged: onChanged,
//         style: TextStyle(color: cs.onSurface, fontSize: 12),
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         ),
//       ),
//     );
//   }
// }

// class _CompactDropdown<T> extends StatelessWidget {
//   final T? value;
//   final List<T> items;
//   final String hint;
//   final ValueChanged<T?> onChanged;
//   const _CompactDropdown({
//     required this.value,
//     required this.items,
//     required this.hint,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       height: 34,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value: value,
//           isExpanded: true,
//           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//           iconEnabledColor: cs.onSurfaceVariant,
//           style: TextStyle(color: cs.onSurface, fontSize: 12),
//           hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
//           items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }

// class _Project {
//   final String projectName;
//   final String type;
//   final String customerName;
//   final String projectCode;
//   final String projectManager;
//   final String bdm;
//   final String startDate;
//   final String endDate;
//   final String amcYear;
//   final String amcMonths;
//   final List<String> subProjects;

//   _Project({
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

// // Bottom-nav roots
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';

// import '../modals/update_project_modal.dart' show UpdateProjectModal, ProjectDto;

// // ===================== API BASE =====================
// const String kApiBase = 'https://pmgt.commedialabs.com';

// // ===================== MODELS =======================
// class ProjectRow {
//   final String id;
//   final String customerName;
//   final String projectCode; // identifier for PUT/DELETE
//   final String projectName;
//   final String projectType;
//   final String projectManager;
//   final String bdm;
//   final String? startDateIso;
//   final String? endDateIso;
//   final int? amcYear;
//   final int? amcMonths;

//   ProjectRow({
//     required this.id,
//     required this.customerName,
//     required this.projectCode,
//     required this.projectName,
//     required this.projectType,
//     required this.projectManager,
//     required this.bdm,
//     required this.startDateIso,
//     required this.endDateIso,
//     required this.amcYear,
//     required this.amcMonths,
//   });

//   factory ProjectRow.fromJson(Map<String, dynamic> j) {
//     return ProjectRow(
//       id:           (j['id'] ?? j['project_id'] ?? '').toString(),
//       customerName: j['customer_name'] ?? '',
//       projectCode:  j['project_code'] ?? '',
//       projectName:  j['project_name'] ?? '',
//       projectType:  j['project_type'] ?? '',
//       projectManager: j['project_manager'] ?? '',
//       bdm:           j['bdm'] ?? '',
//       startDateIso:  (j['start_date'] ?? '') == '' ? null : j['start_date'],
//       endDateIso:    (j['end_date'] ?? '') == '' ? null : j['end_date'],
//       amcYear:       j['amc_year'] is int ? j['amc_year'] : int.tryParse('${j['amc_year'] ?? ''}'),
//       amcMonths:     j['amc_months'] is int ? j['amc_months'] : int.tryParse('${j['amc_months'] ?? ''}'),
//     );
//   }

//   // dd/MM/yyyy helpers
//   String get startDmy => _isoToDmy(startDateIso);
//   String get endDmy   => _isoToDmy(endDateIso);

//   static String _two(int n) => n.toString().padLeft(2, '0');
//   static String _isoToDmy(String? iso) {
//     if (iso == null || iso.isEmpty) return '';
//     try {
//       final d = DateTime.parse(iso);
//       return '${_two(d.day)}/${_two(d.month)}/${d.year}';
//     } catch (_) {
//       return iso;
//     }
//   }
// }

// // ===================== VIEW =========================
// class ViewProjectsScreen extends StatefulWidget {
//   const ViewProjectsScreen({super.key});

//   @override
//   State<ViewProjectsScreen> createState() => _ViewProjectsScreenState();
// }

// class _ViewProjectsScreenState extends State<ViewProjectsScreen> {
//   final int _selectedTab = 1;

//   // Data
//   List<ProjectRow> _rows = [];
//   // projectId -> list of sub-project names
//   final Map<String, List<String>> _subMap = {};

//   // UI state
//   bool _loading = false;
//   String _search = '';
//   String _filterProjectName = ''; // by project_name
//   String _filterChild = '';       // by child name

//   @override
//   void initState() {
//     super.initState();
//     _bootstrap();
//   }

//   Future<void> _bootstrap() async {
//     setState(() => _loading = true);
//     await _fetchProjects();
//     await _preloadAllChildNames(); // ← ensures chips show on first paint
//     if (mounted) setState(() => _loading = false);
//   }

//   Future<void> _logGet(Uri uri, http.Response r, {String tag = ''}) async {
//     debugPrint('[GET] $uri $tag -> ${r.statusCode} (${r.body.length} bytes)');
//   }

//   Future<void> _fetchProjects() async {
//     try {
//       final uri = Uri.parse('$kApiBase/api/projects');
//       final r = await http.get(uri);
//       await _logGet(uri, r, tag: '/projects');
//       if (r.statusCode == 200) {
//         final arr = jsonDecode(r.body) as List;
//         _rows = arr.map((e) => ProjectRow.fromJson(e)).toList();
//         setState(() {});
//       } else {
//         debugPrint('[projects][ERR] ${r.body}');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not load projects')),
//           );
//         }
//       }
//     } catch (e) {
//       debugPrint('[projects][EXC] $e');
//     }
//   }

//   Future<List<String>> _fetchSubNamesFor(String projectId) async {
//     try {
//       final uri = Uri.parse('$kApiBase/api/projects/$projectId/sub-projects');
//       final r = await http.get(uri);
//       await _logGet(uri, r, tag: '/sub-projects');
//       if (r.statusCode == 200) {
//         final data = jsonDecode(r.body);
//         final list = (data is List) ? data : (data['sub_projects'] ?? data['data'] ?? []);
//         return (list as List)
//             .map((e) => (e['name'] ?? '').toString())
//             .where((s) => s.isNotEmpty)
//             .toList();
//       }
//     } catch (_) {}
//     return const [];
//   }

//   Future<void> _preloadAllChildNames() async {
//     // Fetch for all parents in parallel (like web)
//     final futures = <Future<void>>[];
//     for (final p in _rows) {
//       if (_subMap.containsKey(p.id)) continue;
//       futures.add(_fetchSubNamesFor(p.id).then((names) {
//         _subMap[p.id] = names;
//       }));
//     }
//     await Future.wait(futures);
//     if (mounted) setState(() {});
//   }

//   // Filtering
//   List<ProjectRow> get _displayed {
//     List<ProjectRow> list = _rows;

//     if (_filterProjectName.isNotEmpty) {
//       list = list.where((r) => r.projectName == _filterProjectName).toList();
//     }
//     if (_filterChild.isNotEmpty) {
//       list = list.where((r) => (_subMap[r.id] ?? const []).contains(_filterChild)).toList();
//     }

//     final q = _search.trim().toLowerCase();
//     if (q.isNotEmpty) {
//       list = list.where((r) {
//         bool c(String? s) => (s ?? '').toLowerCase().contains(q);
//         final subs = (_subMap[r.id] ?? const []);
//         return c(r.customerName) ||
//                c(r.projectCode)  ||
//                c(r.projectName)  ||
//                subs.any((n) => n.toLowerCase().contains(q)) ||
//                c(r.projectManager) ||
//                c(r.bdm);
//       }).toList();
//     }
//     return list;
//   }

//   // NAV
//   void _handleTabChange(int i) {
//     if (i == _selectedTab) return;
//     late final Widget target;
//     switch (i) {
//       case 0: target = const DashboardScreen(); break;
//       case 1: target = const AddProjectScreen(); break;
//       case 2: target = const AddActivityScreen(); break;
//       case 3: target = const AnalyticsScreen(); break;
//       case 4: target = const ViewUsersScreen(); break;
//       default: return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   // Update (PUT)
//   Future<void> _updateProject(ProjectDto updated) async {
//     try {
//       setState(() => _loading = true);
//       final uri = Uri.parse('$kApiBase/api/projects/${updated.projectCode}');
//       final payload = {
//         'customer_name':   updated.customerName,
//         'project_name':    updated.projectName,
//         'project_type':    updated.type,
//         'project_manager': updated.projectManager,
//         'bdm':             updated.bdm,
//         'start_date':      _toIsoFromDmy(updated.startDate),
//         'end_date':        _toIsoFromDmy(updated.endDate),
//         'amc_year':        updated.amcYear.isEmpty ? null : int.tryParse(updated.amcYear),
//         'amc_months':      updated.amcMonths.isEmpty ? null : int.tryParse(updated.amcMonths),
//       };
//       final res = await http.put(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(payload),
//       );
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         await _fetchProjects();
//         await _preloadAllChildNames();
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project updated')));
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Update failed (${res.statusCode})')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update error: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   String? _toIsoFromDmy(String? v) {
//     if (v == null || v.isEmpty) return null;
//     final p = v.split('/');
//     if (p.length != 3) return v;
//     final d = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
//     return d.toIso8601String();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final pad = responsivePadding(context);

//     // Dropdown data
//     final projectNames = ['All', ...{..._rows.map((r) => r.projectName)}];

//     // If a project is selected, get its children from preloaded map
//     final selectedProject = _rows.firstWhere(
//       (r) => r.projectName == _filterProjectName,
//       orElse: () => ProjectRow(
//         id: '', customerName: '', projectCode: '', projectName: '',
//         projectType: '', projectManager: '', bdm: '',
//         startDateIso: null, endDateIso: null, amcYear: null, amcMonths: null),
//     );
//     final childOptions = _filterProjectName.isEmpty
//         ? const <String>[]
//         : (_subMap[selectedProject.id] ?? const <String>[]);

//     return MainLayout(
//       title: 'All Projects',
//       centerTitle: true,
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
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Stack(
//         children: [
//           ListView(
//             padding: pad.copyWith(top: 6, bottom: 12),
//             children: [
//               // Search row with Export at the end
//               Row(
//                 children: [
//                   Expanded(child: _SearchField(onChanged: (v) => setState(() => _search = v))),
//                   const SizedBox(width: 8),
//                   SizedBox(
//                     height: 34,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Export requested')),
//                         );
//                       },
//                       icon: const Icon(Icons.download, color: Colors.black, size: 18),
//                       label: const Text('Export', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.accentColor,
//                         elevation: 0,
//                         padding: const EdgeInsets.symmetric(horizontal: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Divider(color: cs.outlineVariant),
//               const SizedBox(height: 8),

//               // One row: Project + Sub Project (both labeled)
//               Row(
//                 children: [
//                   Expanded(
//                     child: _LabeledDropdown<String>(
//                       label: 'Project',
//                       value: _filterProjectName.isEmpty ? 'All' : _filterProjectName,
//                       items: projectNames,
//                       displayOf: (s) => s,
//                       onChanged: (v) {
//                         final next = (v ?? 'All');
//                         setState(() {
//                           _filterProjectName = (next == 'All') ? '' : next;
//                           _filterChild = '';
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _LabeledDropdown<String>(
//                       label: 'Sub Project',
//                       value: _filterChild.isEmpty ? 'All' : _filterChild,
//                       items: ['All', ...childOptions],
//                       displayOf: (s) => s,
//                       enabled: _filterProjectName.isNotEmpty && childOptions.isNotEmpty,
//                       onChanged: (v) => setState(() => _filterChild = (v == null || v == 'All') ? '' : v),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               // Cards
//               ..._displayed.map((r) => _ProjectCard(
//                     row: r,
//                     subNames: _subMap[r.id] ?? const [],
//                     onEdit: (dto) => _updateProject(dto),
//                   )),

//               if (_displayed.isEmpty)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 24),
//                   child: Center(child: Text('No projects found', style: TextStyle(color: cs.onSurfaceVariant))),
//                 ),
//               const SizedBox(height: 12),
//             ],
//           ),

//           if (_loading)
//             Positioned.fill(
//               child: Container(
//                 color: cs.surface.withOpacity(0.2),
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ===================== WIDGETS ======================
// class _ProjectCard extends StatelessWidget {
//   final ProjectRow row;
//   final List<String> subNames;
//   final ValueChanged<ProjectDto> onEdit;
//   const _ProjectCard({required this.row, required this.subNames, required this.onEdit});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(row.projectName, style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14)),
//               Text('Type : ${row.projectType}', style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // Two-column details
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow('Customer Name', row.customerName, labelColor, valueColor),
//                     _infoRow('Project Code', row.projectCode, labelColor, valueColor),
//                     if (subNames.isEmpty)
//                       _infoRow('Sub Project', '—', labelColor, valueColor)
//                     else
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 4),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Sub Project:', style: TextStyle(color: labelColor, fontSize: 11)),
//                             const SizedBox(height: 4),
//                             Wrap(
//                               spacing: 6,
//                               runSpacing: 6,
//                               children: subNames
//                                   .map((s) => Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                         decoration: BoxDecoration(
//                                           color: Theme.of(context).colorScheme.surface,
//                                           borderRadius: BorderRadius.circular(12),
//                                           border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
//                                         ),
//                                         child: Text(s, style: TextStyle(color: valueColor, fontSize: 11)),
//                                       ))
//                                   .toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     _infoRow('Project Manager', row.projectManager, labelColor, valueColor),
//                     _infoRow('BDM', row.bdm, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Right
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow('Start Date', row.startDmy, labelColor, valueColor),
//                     _infoRow('End Date', row.endDmy, labelColor, valueColor),
//                     _infoRow('AMC Year', row.amcYear?.toString() ?? '', labelColor, valueColor),
//                     _infoRow('AMC Months', row.amcMonths?.toString() ?? '', labelColor, valueColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onPressed: () async {
//                 final result = await showModalBottomSheet<ProjectDto>(
//                   context: context,
//                   isScrollControlled: true,
//                   backgroundColor: Colors.transparent,
//                   builder: (_) => UpdateProjectModal(
//                     project: ProjectDto(
//                       customerName: row.customerName,
//                       projectName:  row.projectName,
//                       projectCode:  row.projectCode,
//                       type:         row.projectType,
//                       projectManager: row.projectManager,
//                       bdm:            row.bdm,
//                       startDate:      row.startDmy,
//                       endDate:        row.endDmy,
//                       amcYear:        (row.amcYear ?? '').toString(),
//                       amcMonths:      (row.amcMonths ?? '').toString(),
//                       subProjects:    subNames,
//                     ),
//                   ),
//                 );
//                 if (result != null) onEdit(result);
//               },
//               child: const Text('Update', style: TextStyle(color: Colors.black, fontSize: 12)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, Color labelColor, Color valueColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$label: ',
//           style: TextStyle(color: labelColor, fontSize: 11),
//           children: [TextSpan(text: value, style: TextStyle(color: valueColor, fontSize: 11))],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final ValueChanged<String>? onChanged;
//   const _SearchField({this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         onChanged: onChanged,
//         style: TextStyle(color: cs.onSurface, fontSize: 12),
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         ),
//       ),
//     );
//   }
// }

// class _LabeledDropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final T Function(T v) displayOf;
//   final ValueChanged<T?> onChanged;
//   final bool enabled;
//   const _LabeledDropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.displayOf,
//     required this.onChanged,
//     this.enabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           height: 34,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: enabled ? cs.surfaceContainerHighest : cs.surface,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               value: value,
//               isExpanded: true,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               iconEnabledColor: enabled ? cs.onSurfaceVariant : cs.outlineVariant,
//               style: TextStyle(color: enabled ? cs.onSurface : cs.onSurfaceVariant, fontSize: 12),
//               items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('${displayOf(e)}'))).toList(),
//               onChanged: enabled ? onChanged : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


//p3//
// lib/src/pages/projects/view_projects_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

// Bottom-nav roots
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

import '../modals/update_project_modal.dart' show UpdateProjectModal, ProjectDto;

// ====== API BASE (match web) =================================================
const String kApiBase = 'https://pmgt.commedialabs.com';

// ====== MODELS ===============================================================
class ProjectRow {
  final String id;
  final String customerName;
  final String projectCode;
  final String projectName;
  final String projectType;
  final String projectManager;
  final String bdm;
  final String? startDateIso;
  final String? endDateIso;
  final int? amcYear;
  final int? amcMonths;

  ProjectRow({
    required this.id,
    required this.customerName,
    required this.projectCode,
    required this.projectName,
    required this.projectType,
    required this.projectManager,
    required this.bdm,
    required this.startDateIso,
    required this.endDateIso,
    required this.amcYear,
    required this.amcMonths,
  });

  factory ProjectRow.fromJson(Map<String, dynamic> j) {
    return ProjectRow(
      id:           (j['id'] ?? j['project_id'] ?? '').toString(),
      customerName: j['customer_name'] ?? '',
      projectCode:  j['project_code'] ?? '',
      projectName:  j['project_name'] ?? '',
      projectType:  j['project_type'] ?? '',
      projectManager: j['project_manager'] ?? '',
      bdm:           j['bdm'] ?? '',
      startDateIso:  (j['start_date'] ?? '') == '' ? null : j['start_date'],
      endDateIso:    (j['end_date'] ?? '') == '' ? null : j['end_date'],
      amcYear:       j['amc_year'] is int ? j['amc_year'] : int.tryParse('${j['amc_year'] ?? ''}'),
      amcMonths:     j['amc_months'] is int ? j['amc_months'] : int.tryParse('${j['amc_months'] ?? ''}'),
    );
  }

  String get startDmy => _isoToDmy(startDateIso);
  String get endDmy   => _isoToDmy(endDateIso);

  static String _two(int n) => n.toString().padLeft(2, '0');
  static String _isoToDmy(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    try {
      final d = DateTime.parse(iso);
      return '${_two(d.day)}/${_two(d.month)}/${d.year}';
    } catch (_) {
      return iso;
    }
  }
}

// ====== VIEW ================================================================
class ViewProjectsScreen extends StatefulWidget {
  const ViewProjectsScreen({super.key});

  @override
  State<ViewProjectsScreen> createState() => _ViewProjectsScreenState();
}

class _ViewProjectsScreenState extends State<ViewProjectsScreen> {
  final int _selectedTab = 1;

  // Data
  List<ProjectRow> _rows = [];
  // projectId -> list of sub-project names
  final Map<String, List<String>> _subMap = {};

  // UI state
  bool _loading = false;
  String _search = '';
  String _filterProjectName = ''; // by project_name
  String _filterChild = '';       // by child name

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() => _loading = true);
    await _fetchProjects();
    await _preloadAllChildNames(); // like the web, so chips show on first paint
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _fetchProjects() async {
    try {
      final uri = Uri.parse('$kApiBase/api/projects');
      final r = await http.get(uri);
      if (r.statusCode == 200) {
        final arr = jsonDecode(r.body) as List;
        _rows = arr.map((e) => ProjectRow.fromJson(e)).toList();
        setState(() {});
      } else {
        _snack('Could not load projects');
      }
    } catch (e) {
      _snack('Could not load projects');
    }
  }

  Future<List<String>> _fetchSubNamesFor(String projectId) async {
    try {
      final uri = Uri.parse('$kApiBase/api/projects/$projectId/sub-projects');
      final r = await http.get(uri);
      if (r.statusCode == 200) {
        final data = jsonDecode(r.body);
        final list = (data is List) ? data : (data['sub_projects'] ?? data['data'] ?? []);
        return (list as List)
            .map((e) => (e['name'] ?? e['sub_project_name'] ?? '').toString())
            .where((s) => s.isNotEmpty)
            .toList();
      }
    } catch (_) {}
    return const [];
  }

  Future<void> _preloadAllChildNames() async {
    final futures = <Future<void>>[];
    for (final p in _rows) {
      if (_subMap.containsKey(p.id)) continue;
      futures.add(_fetchSubNamesFor(p.id).then((names) => _subMap[p.id] = names));
    }
    await Future.wait(futures);
    if (mounted) setState(() {});
  }

  // Filtering
  List<ProjectRow> get _displayed {
    List<ProjectRow> list = _rows;

    if (_filterProjectName.isNotEmpty) {
      list = list.where((r) => r.projectName == _filterProjectName).toList();
    }
    if (_filterChild.isNotEmpty) {
      list = list.where((r) => (_subMap[r.id] ?? const []).contains(_filterChild)).toList();
    }

    final q = _search.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((r) {
        bool c(String? s) => (s ?? '').toLowerCase().contains(q);
        final subs = (_subMap[r.id] ?? const []);
        return c(r.customerName) ||
               c(r.projectCode)  ||
               c(r.projectName)  ||
              //  subs.any((n) => n.toLowerCase().includes(q)) ||
              subs.any((n) => n.toLowerCase().contains(q)) ||


               c(r.projectManager) ||
               c(r.bdm);
      }).toList();
    }
    return list;
  }

  // NAV
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

  // Update (PUT)
  Future<void> _updateProject(ProjectDto updated) async {
    try {
      setState(() => _loading = true);
      final uri = Uri.parse('$kApiBase/api/projects/${updated.projectCode}');
      final payload = {
        'customer_name':   updated.customerName,
        'project_name':    updated.projectName,
        'project_type':    updated.type,
        'project_manager': updated.projectManager,
        'bdm':             updated.bdm,
        'start_date':      _toIsoFromDmy(updated.startDate),
        'end_date':        _toIsoFromDmy(updated.endDate),
        'amc_year':        updated.amcYear.isEmpty ? null : int.tryParse(updated.amcYear),
        'amc_months':      updated.amcMonths.isEmpty ? null : int.tryParse(updated.amcMonths),
      };
      final res = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await _fetchProjects();
        await _preloadAllChildNames();
        _snack('Project updated');
      } else {
        _snack('Update failed (${res.statusCode})');
      }
    } catch (e) {
      _snack('Update error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String? _toIsoFromDmy(String? v) {
    if (v == null || v.isEmpty) return null;
    final p = v.split('/');
    if (p.length != 3) return v;
    final d = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
    return d.toIso8601String();
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

    // Dropdown data
    final projectNames = ['All', ...{..._rows.map((r) => r.projectName)}];

    // If a project is selected, get its children (already preloaded).
    final selectedProject = _rows.firstWhere(
      (r) => r.projectName == _filterProjectName,
      orElse: () => ProjectRow(
        id: '', customerName: '', projectCode: '', projectName: '',
        projectType: '', projectManager: '', bdm: '',
        startDateIso: null, endDateIso: null, amcYear: null, amcMonths: null),
    );
    final childOptions = _filterProjectName.isEmpty
        ? const <String>[]
        : (_subMap[selectedProject.id] ?? const <String>[]);

    return MainLayout(
      title: 'All Projects',
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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
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
            padding: pad.copyWith(top: 6, bottom: 12),
            children: [
              // Search row with Export at the end (like your latest UI)
              Row(
                children: [
                  Expanded(child: _SearchField(onChanged: (v) => setState(() => _search = v))),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 34,
                    child: ElevatedButton.icon(
                      onPressed: () => _snack('Export requested'),
                      icon: const Icon(Icons.download, color: Colors.black, size: 18),
                      label: const Text('Export', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: cs.outlineVariant),
              const SizedBox(height: 8),

              // One row: Project + Sub Project (both labeled)
              Row(
                children: [
                  Expanded(
                    child: _LabeledDropdown<String>(
                      label: 'Project',
                      value: _filterProjectName.isEmpty ? 'All' : _filterProjectName,
                      items: projectNames,
                      displayOf: (s) => s,
                      onChanged: (v) {
                        final next = (v ?? 'All');
                        setState(() {
                          _filterProjectName = (next == 'All') ? '' : next;
                          _filterChild = '';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _LabeledDropdown<String>(
                      label: 'Sub Project',
                      value: _filterChild.isEmpty ? 'All' : _filterChild,
                      items: ['All', ...childOptions],
                      displayOf: (s) => s,
                      enabled: _filterProjectName.isNotEmpty && childOptions.isNotEmpty,
                      onChanged: (v) => setState(() => _filterChild = (v == null || v == 'All') ? '' : v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Cards
              ..._displayed.map((r) => _ProjectCard(
                    row: r,
                    subNames: _subMap[r.id] ?? const [],
                    onEdit: (dto) => _updateProject(dto),
                  )),

              if (_displayed.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No projects found', style: TextStyle(color: cs.onSurfaceVariant))),
                ),
              const SizedBox(height: 12),
            ],
          ),

          if (_loading)
            Positioned.fill(
              child: Container(
                color: cs.surface.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

// ====== WIDGETS =============================================================
class _ProjectCard extends StatelessWidget {
  final ProjectRow row;
  final List<String> subNames;
  final ValueChanged<ProjectDto> onEdit;
  const _ProjectCard({required this.row, required this.subNames, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final valueColor = isLight ? Colors.black : cs.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(row.projectName, style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14)),
              Text('Type : ${row.projectType}', style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),

          // Two-column details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Customer Name', row.customerName, labelColor, valueColor),
                    _infoRow('Project Code', row.projectCode, labelColor, valueColor),
                    if (subNames.isEmpty)
                      _infoRow('Sub Project', '—', labelColor, valueColor)
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sub Project:', style: TextStyle(color: labelColor, fontSize: 11)),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: subNames
                                  .map((s) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                                        ),
                                        child: Text(s, style: TextStyle(color: valueColor, fontSize: 11)),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    _infoRow('Project Manager', row.projectManager, labelColor, valueColor),
                    _infoRow('BDM', row.bdm, labelColor, valueColor),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Start Date', row.startDmy, labelColor, valueColor),
                    _infoRow('End Date', row.endDmy, labelColor, valueColor),
                    _infoRow('AMC Year', row.amcYear?.toString() ?? '', labelColor, valueColor),
                    _infoRow('AMC Months', row.amcMonths?.toString() ?? '', labelColor, valueColor),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                side: const BorderSide(color: AppTheme.accentColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () async {
                final result = await showModalBottomSheet<ProjectDto>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => UpdateProjectModal(
                    project: ProjectDto(
                      customerName: row.customerName,
                      projectName:  row.projectName,
                      projectCode:  row.projectCode,
                      type:         row.projectType,
                      projectManager: row.projectManager,
                      bdm:            row.bdm,
                      startDate:      row.startDmy,
                      endDate:        row.endDmy,
                      amcYear:        (row.amcYear ?? '').toString(),
                      amcMonths:      (row.amcMonths ?? '').toString(),
                      subProjects:    subNames,
                    ),
                  ),
                );
                if (result != null) onEdit(result);
              },
              child: const Text('Update', style: TextStyle(color: Colors.black, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, Color labelColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(color: labelColor, fontSize: 11),
          children: [TextSpan(text: value, style: TextStyle(color: valueColor, fontSize: 11))],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const _SearchField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: cs.onSurface, fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

class _LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final T Function(T v) displayOf;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.displayOf,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: enabled ? cs.surfaceContainerHighest : cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              iconEnabledColor: enabled ? cs.onSurfaceVariant : cs.outlineVariant,
              style: TextStyle(color: enabled ? cs.onSurface : cs.onSurfaceVariant, fontSize: 12),
              items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('${displayOf(e)}'))).toList(),
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }
}
