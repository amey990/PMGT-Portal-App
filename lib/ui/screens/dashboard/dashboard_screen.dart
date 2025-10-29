// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';
// import '../modals/update_activity_modal.dart';

// // ===================== API BASE =====================
// const String kApiBase = 'https://pmgt.commedialabs.com';

// // ===================== DATA MODELS ==================
// class Project {
//   final String id;
//   final String name;
//   Project({required this.id, required this.name});
//   factory Project.fromJson(Map<String, dynamic> j) =>
//       Project(id: j['id']?.toString() ?? '', name: j['project_name'] ?? '');
// }

// class SubProject {
//   final String id;
//   final String name;
//   SubProject({required this.id, required this.name});
//   factory SubProject.fromJson(Map<String, dynamic> j) =>
//       SubProject(id: j['id']?.toString() ?? '', name: j['name'] ?? j['sub_project_name'] ?? '');
// }

// class SiteAPI {
//   final String projectId;
//   final String projectName;
//   final String siteId;
//   final String siteName;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String address;
//   final String? subProjectId;
//   final String? subProjectName;

//   SiteAPI({
//     required this.projectId,
//     required this.projectName,
//     required this.siteId,
//     required this.siteName,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.address,
//     this.subProjectId,
//     this.subProjectName,
//   });

//   factory SiteAPI.fromJson(Map<String, dynamic> j) => SiteAPI(
//         projectId: j['project_id']?.toString() ?? '',
//         projectName: j['project_name'] ?? '',
//         siteId: j['site_id']?.toString() ?? '',
//         siteName: j['site_name'] ?? '',
//         country: j['country'] ?? '',
//         state: j['state'] ?? '',
//         district: j['district'] ?? '',
//         city: j['city'] ?? '',
//         address: j['address'] ?? '',
//         subProjectId: j['sub_project_id']?.toString(),
//         subProjectName: j['sub_project_name'],
//       );
// }

// class FieldEngineer {
//   final String id;
//   final String name;
//   final String mobile;
//   final String vendor;
//   FieldEngineer({required this.id, required this.name, required this.mobile, required this.vendor});
//   factory FieldEngineer.fromJson(Map<String, dynamic> j) => FieldEngineer(
//         id: j['id']?.toString() ?? '',
//         name: j['full_name'] ?? '',
//         mobile: j['contact_no'] ?? '',
//         vendor: j['contact_person'] ?? '',
//       );
// }

// class NocEngineer {
//   final String id;
//   final String name;
//   NocEngineer({required this.id, required this.name});
//   factory NocEngineer.fromJson(Map<String, dynamic> j) =>
//       NocEngineer(id: j['id']?.toString() ?? '', name: j['full_name'] ?? '');
// }

// // Row used for UI (aligned to the Web)
// class Activity {
//   final String id;
//   final String tNo;
//   final String date; // yyyy-MM-dd
//   final String completionDate; // yyyy-MM-dd
//   final String projectId;
//   final String project;
//   final String? subProject; // name
//   final String? subProjectId;
//   final String activity;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String address;
//   final String siteId;   // code
//   final String siteName; // name
//   final String pm;
//   final String vendor;
//   final String? fieldEngineerId;
//   final String feName;
//   final String feMobile;
//   final String? nocEngineerId;
//   final String nocEngineer;
//   final String remarks;
//   final String status;

//   Activity({
//     required this.id,
//     required this.tNo,
//     required this.date,
//     required this.completionDate,
//     required this.projectId,
//     required this.project,
//     required this.subProject,
//     required this.subProjectId,
//     required this.activity,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.address,
//     required this.siteId,
//     required this.siteName,
//     required this.pm,
//     required this.vendor,
//     required this.fieldEngineerId,
//     required this.feName,
//     required this.feMobile,
//     required this.nocEngineerId,
//     required this.nocEngineer,
//     required this.remarks,
//     required this.status,
//   });

//   // UI helpers
//   String get scheduledDate =>
//       date.isEmpty ? '' : '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';
//   String get completionDateDmy => completionDate.isEmpty
//       ? ''
//       : '${completionDate.substring(8, 10)}/${completionDate.substring(5, 7)}/${completionDate.substring(0, 4)}';
// }

// // ===================== UI ===========================
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
//   // Toggle state for Project vs Summary
//   final List<bool> _isSelected = [true, false];

//   // -------- Filters ----------
//   int _activityTimeIndex = 4; // All
//   String _selectedProject = 'all';
//   String _selectedSubProject = 'all';
//   String _selectedStatus = 'all';
//   String _search = '';

//   // pagination (client side)
//   int _currentPage = 1;
//   final List<int> _perPageOptions = [10, 20, 30, 50];
//   int _perPage = 20;

//   // -------- Lookups + data ----------
//   bool _loading = false;
//   List<Project> _projects = [];
//   List<SubProject> _subProjects = [];
//   List<SiteAPI> _sites = [];
//   List<FieldEngineer> _feList = [];
//   List<NocEngineer> _nocs = [];
//   List<Activity> _activities = [];

//   @override
//   void initState() {
//     super.initState();
//     _bootstrap();
//   }

//   Future<void> _bootstrap() async {
//     setState(() => _loading = true);
//     try {
//       debugPrint('[BOOT] start — fetching lookups');
//       await Future.wait([
//         _fetchProjects(),
//         _fetchAllSites(),
//         _fetchFEs(),
//         _fetchNOCs(),
//       ]);
//       debugPrint('[BOOT] lookups done; loading activities…');
//       await _loadActivities();
//       debugPrint('[BOOT] complete. activities=${_activities.length}');
//     } catch (e, st) {
//       debugPrint('[BOOT][ERR] $e\n$st');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to load initial data')),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   // ============== API helpers ==================
//   Future<void> _fetchProjects() async {
//     final uri = Uri.parse('$kApiBase/api/projects');
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /projects -> ${r.statusCode} (${r.body.length} bytes)');
//     if (r.statusCode == 200) {
//       final arr = jsonDecode(r.body) as List;
//       _projects = arr.map((e) => Project.fromJson(e)).toList();
//       setState(() {});
//     } else {
//       debugPrint('[GET][projects][ERR] ${r.body}');
//     }
//   }

//   Future<void> _fetchSubProjects(String projectId) async {
//     _selectedSubProject = 'all';
//     _subProjects = [];
//     setState(() {});
//     if (projectId == 'all') {
//       debugPrint('[SKIP] sub-projects — project=all');
//       return;
//     }

//     final uri = Uri.parse('$kApiBase/api/projects/$projectId/sub-projects');
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /sub-projects -> ${r.statusCode} (${r.body.length} bytes)');
//     if (r.statusCode == 200) {
//       final data = jsonDecode(r.body);
//       final list = (data is List) ? data : (data['sub_projects'] ?? data['data'] ?? []);
//       _subProjects = (list as List).map((e) => SubProject.fromJson(e)).toList();
//       debugPrint('[GET] sub-projects count=${_subProjects.length}');
//       setState(() {});
//     } else {
//       debugPrint('[GET][sub-projects][ERR] ${r.body}');
//     }
//   }

//   Future<void> _fetchAllSites() async {
//     final uri = Uri.parse('$kApiBase/api/project-sites');
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /project-sites -> ${r.statusCode} (${r.body.length} bytes)');
//     if (r.statusCode == 200) {
//       final arr = jsonDecode(r.body) as List;
//       _sites = arr.map((e) => SiteAPI.fromJson(e)).toList();
//       debugPrint('[GET] sites count=${_sites.length}');
//       setState(() {});
//     } else {
//       debugPrint('[GET][sites][ERR] ${r.body}');
//     }
//   }

//   Future<void> _fetchFEs() async {
//     final uri = Uri.parse('$kApiBase/api/field-engineers');
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /field-engineers -> ${r.statusCode} (${r.body.length} bytes)');
//     if (r.statusCode == 200) {
//       final data = jsonDecode(r.body);
//       final raw = (data is List) ? data : (data['field_engineers'] ?? []);
//       _feList = (raw as List).map((e) => FieldEngineer.fromJson(e)).toList();
//       debugPrint('[GET] FE count=${_feList.length}');
//       setState(() {});
//     } else {
//       debugPrint('[GET][FEs][ERR] ${r.body}');
//     }
//   }

//   Future<void> _fetchNOCs() async {
//     final uri = Uri.parse('$kApiBase/api/nocs');
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /nocs -> ${r.statusCode} (${r.body.length} bytes)');
//     if (r.statusCode == 200) {
//       final data = jsonDecode(r.body);
//       final list = (data is List) ? data : [];
//       _nocs = (list as List).map((e) => NocEngineer.fromJson(e)).toList();
//       debugPrint('[GET] NOC count=${_nocs.length}');
//       setState(() {});
//     } else {
//       debugPrint('[GET][NOCs][ERR] ${r.body}');
//     }
//   }

//   String _iso10(dynamic v) {
//     final s = (v ?? '').toString();
//     return s.length >= 10 ? s.substring(0, 10) : '';
//   }

//   Future<void> _loadActivities() async {
//     final params = <String, String>{"page": "1", "limit": "1000"};
//     if (_selectedProject != 'all') params['projectId'] = _selectedProject;
//     if (_selectedSubProject != 'all') params['subProjectId'] = _selectedSubProject;

//     final uri = Uri.parse('$kApiBase/api/activities').replace(queryParameters: params);
//     debugPrint('[GET] $uri');
//     final r = await http.get(uri);
//     debugPrint('[GET] /activities -> ${r.statusCode} (${r.body.length} bytes)');

//     if (r.statusCode != 200) {
//       debugPrint('[GET][activities][ERR] ${r.body}');
//       return;
//     }

//     final data = jsonDecode(r.body);
//     final rawActs = (data is List) ? data : (data['activities'] ?? []);
//     final projectsById = {for (final p in _projects) p.id: p.name};

//     List<Activity> rows = [];
//     for (final a in rawActs) {
//       final site = _sites.firstWhere(
//         (s) =>
//             s.projectId == (a['project_id']?.toString() ?? '') &&
//             s.siteId == (a['site_id']?.toString() ?? '') &&
//             (((a['sub_project_id']?.toString() ?? '').isNotEmpty)
//                 ? s.subProjectId == (a['sub_project_id']?.toString() ?? '')
//                 : (s.subProjectId == null || s.subProjectId!.isEmpty)),
//         orElse: () => SiteAPI.fromJson({
//           'project_id': a['project_id']?.toString(),
//           'project_name': projectsById[a['project_id']?.toString()] ?? '',
//           'site_id': a['site_id']?.toString() ?? '',
//           'site_name': a['site_name'] ?? '',
//           'country': a['country'] ?? '',
//           'state': a['state'] ?? '',
//           'district': a['district'] ?? '',
//           'city': a['city'] ?? '',
//           'address': a['address'] ?? '',
//           'sub_project_id': a['sub_project_id'],
//           'sub_project_name': a['sub_project_name'] ?? a['sub_project'],
//         }),
//       );

//       final fe = _feList.firstWhere(
//         (f) => f.id == (a['field_engineer_id']?.toString() ?? ''),
//         orElse: () => FieldEngineer(id: '', name: '', mobile: a['fe_mobile'] ?? '', vendor: a['vendor'] ?? ''),
//       );
//       final noc = _nocs.firstWhere(
//         (n) => n.id == (a['noc_engineer_id']?.toString() ?? ''),
//         orElse: () => NocEngineer(id: '', name: a['noc_engineer'] ?? ''),
//       );

//       rows.add(
//         Activity(
//           id: a['id']?.toString() ?? '',
//           tNo: a['ticket_no'] ?? '',
//           date: _iso10(a['activity_date']),
//           completionDate: _iso10(a['completion_date']),
//           projectId: a['project_id']?.toString() ?? '',
//           project: projectsById[a['project_id']?.toString()] ?? '',
//           subProject: a['sub_project_name'] ?? a['sub_project'],
//           subProjectId: a['sub_project_id']?.toString(),
//           activity: a['activity_category'] ?? '',
//           country: a['country'] ?? site.country,
//           state: a['state'] ?? site.state,
//           district: a['district'] ?? site.district,
//           city: a['city'] ?? site.city,
//           address: a['address'] ?? site.address,
//           siteId: a['site_id']?.toString() ?? '',
//           siteName: a['site_name'] ?? site.siteName,
//           pm: a['project_manager'] ?? '',
//           vendor: a['vendor'] ?? '',
//           fieldEngineerId: a['field_engineer_id']?.toString(),
//           feName: fe.name.isNotEmpty ? fe.name : (a['vendor'] ?? ''),
//           feMobile: fe.mobile.isNotEmpty ? fe.mobile : (a['fe_mobile'] ?? ''),
//           nocEngineerId: a['noc_engineer_id']?.toString(),
//           nocEngineer: noc.name,
//           remarks: a['remarks'] ?? '',
//           status: a['status'] ?? '',
//         ),
//       );
//     }

//     // sort by numeric part of ticket no
//     rows.sort((a, b) {
//       int num(String s) {
//         final parts = s.split('-');
//         if (parts.length > 1) {
//           return int.tryParse(parts.last.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
//         }
//         return int.tryParse(RegExp(r'\d+').firstMatch(s)?.group(0) ?? '') ?? 0;
//       }

//       return num(a.tNo).compareTo(num(b.tNo));
//     });

//     // de-dup by id
//     final seen = <String>{};
//     _activities = rows.where((e) => seen.add(e.id)).toList();
//     _currentPage = 1;
//     debugPrint('[GET] activities mapped=${_activities.length}');
//     setState(() {});
//   }

//   // ============== FILTERING/PAGING ==================
//   List<Activity> get _dateScoped {
//     DateTime today0() {
//       final n = DateTime.now();
//       return DateTime(n.year, n.month, n.day);
//     }

//     DateTime endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
//     DateTime addDays(DateTime d, int n) => d.add(Duration(days: n));

//     bool inFutureWindow(DateTime d, int days) {
//       final t0 = today0();
//       return (d.isAtSameMomentAs(t0) || d.isAfter(t0)) && d.isBefore(endOfDay(addDays(t0, days)));
//     }

//     return _activities.where((r) {
//       if (r.date.isEmpty) return false;
//       final d = DateTime.tryParse(r.date) ?? DateTime(1970);
//       switch (_activityTimeIndex) {
//         case 0:
//           final t0 = today0();
//           return d.year == t0.year && d.month == t0.month && d.day == t0.day;
//         case 1:
//           final t1 = addDays(today0(), 1);
//           return d.year == t1.year && d.month == t1.month && d.day == t1.day;
//         case 2:
//           return inFutureWindow(d, 7);
//         case 3:
//           return inFutureWindow(d, 30);
//         default:
//           return true;
//       }
//     }).toList();
//   }

//   List<Activity> get _filtered {
//     final byProject = _selectedProject == 'all'
//         ? _dateScoped
//         : _dateScoped.where((r) => r.projectId == _selectedProject).toList();

//     final bySubProject = _selectedSubProject == 'all'
//         ? byProject
//         : byProject
//             .where((r) =>
//                 (r.subProjectId != null && r.subProjectId == _selectedSubProject) ||
//                 (r.subProjectId == null &&
//                     r.subProject != null &&
//                     r.subProject ==
//                         (_subProjects.firstWhere(
//                           (s) => s.id == _selectedSubProject,
//                           orElse: () => SubProject(id: '', name: ''),
//                         ).name)))
//             .toList();

//     final byStatus = _selectedStatus == 'all'
//         ? bySubProject
//         : bySubProject.where((r) {
//             final s = (r.status).toLowerCase();
//             if (_selectedStatus.toLowerCase().startsWith('resched')) return s.startsWith('resched');
//             return s == _selectedStatus.toLowerCase();
//           }).toList();

//     final term = _search.trim().toLowerCase();
//     if (term.isEmpty) return byStatus;

//     return byStatus.where((r) {
//       final blob = jsonEncode({
//         'tNo': r.tNo,
//         'date': r.date,
//         'project': r.project,
//         'subProject': r.subProject,
//         'siteName': r.siteName,
//         'siteId': r.siteId,
//         'activity': r.activity,
//         'pm': r.pm,
//         'vendor': r.vendor,
//         'feName': r.feName,
//         'feMobile': r.feMobile,
//         'nocEngineer': r.nocEngineer,
//         'country': r.country,
//         'state': r.state,
//         'district': r.district,
//         'city': r.city,
//         'address': r.address,
//         'remarks': r.remarks,
//         'status': r.status,
//       }).toLowerCase();
//       return blob.contains(term);
//     }).toList();
//   }

//   int get _totalPages {
//     final len = _filtered.length;
//     if (len == 0) return 1;
//     return (len + _perPage - 1) ~/ _perPage;
//   }

//   List<Activity> get _paged {
//     final list = _filtered;
//     if (list.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, list.length);
//     if (start >= list.length) return const [];
//     return list.sublist(start, end);
//   }

//   void _goToPage(int p) => setState(() => _currentPage = p.clamp(1, _totalPages));

//   // ================== NAV ===========================
//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 0) return;
//     late final Widget target;
//     switch (i) {
//       case 1:
//         target = const AddProjectScreen();
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

//   // ================== UI ============================
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       titleWidget: _buildTopToggle(context),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
//           icon: Icon(
//             Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
//             color: cs.onSurface,
//           ),
//           onPressed: () => ThemeScope.of(context).toggle(),
//         ),
//         IconButton(
//           tooltip: 'Profile',
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover)),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: 0,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: _loading ? const Center(child: CircularProgressIndicator()) : _buildDashboardContent(),
//     );
//   }

//   Widget _buildTopToggle(BuildContext context) {
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final cs = Theme.of(context).colorScheme;

//     final fillColor = isLight ? Colors.black12 : AppTheme.accentColor.withOpacity(0.18);
//     final selBorderColor = isLight ? Colors.black : AppTheme.accentColor;
//     final borderColor = isLight ? Colors.black26 : cs.outlineVariant;
//     final selTextColor = isLight ? Colors.black : AppTheme.accentColor;
//     final unselectedColor = isLight ? Colors.black54 : cs.onSurfaceVariant;

//     return ToggleButtons(
//       isSelected: _isSelected,
//       borderRadius: BorderRadius.circular(8),
//       fillColor: fillColor,
//       selectedBorderColor: selBorderColor,
//       borderColor: borderColor,
//       selectedColor: selTextColor,
//       color: unselectedColor,
//       constraints: const BoxConstraints(minHeight: 32, minWidth: 96),
//       onPressed: (index) {
//         setState(() {
//           for (var i = 0; i < _isSelected.length; i++) {
//             _isSelected[i] = (i == index);
//           }
//         });
//       },
//       children: const [
//         Padding(padding: EdgeInsets.symmetric(horizontal: 14), child: Text('Project')),
//         Padding(padding: EdgeInsets.symmetric(horizontal: 14), child: Text('Summary')),
//       ],
//     );
//   }

//   Widget _buildDashboardContent() {
//     final cs = Theme.of(context).colorScheme;
//     final pad = responsivePadding(context);

//     if (!_isSelected[0]) {
//       return ListView(
//         padding: pad.copyWith(top: 4, bottom: 8 + 58),
//         children: [
//           _SummaryCard(stats: _calcStats(_dateScoped)),
//           const SizedBox(height: 12),
//           _ActivityStatusSection(stats: _calcStats(_dateScoped)),
//         ],
//       );
//     }

//     return Padding(
//       padding: pad.copyWith(top: 2, bottom: 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 4),
//           Row(
//             children: [
//               Text('Activities',
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w700)),
//               const Spacer(),
//               SizedBox(
//                 width: 280,
//                 child: _SearchField(
//                   onChanged: (v) => setState(() {
//                     _search = v;
//                     _currentPage = 1;
//                   }),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 2),

//           // Time filter
//           Center(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: ['Today', 'Tomorrow', 'Week', 'Month', 'All'].asMap().entries.map((e) {
//                   final idx = e.key;
//                   final label = e.value;
//                   final selected = idx == _activityTimeIndex;
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: GestureDetector(
//                       onTap: () => setState(() {
//                         _activityTimeIndex = idx;
//                         _currentPage = 1;
//                       }),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: selected ? AppTheme.accentColor : Theme.of(context).colorScheme.surfaceContainerHighest,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           label,
//                           style: TextStyle(
//                             color: selected ? Colors.black : Theme.of(context).colorScheme.onSurfaceVariant,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),

//           // Filters
//           Row(
//             children: [
//               Expanded(
//                 child: _buildDropdown(
//                   'Project',
//                   ['all', ..._projects.map((p) => p.id)],
//                   _selectedProject,
//                   (v) async {
//                     _selectedProject = v ?? 'all';
//                     debugPrint('[UI] project=$_selectedProject');
//                     await _fetchSubProjects(_selectedProject);
//                     await _loadActivities();
//                   },
//                   displayBuilder: (id) {
//                     if (id == 'all') return 'All';
//                     final p = _projects.firstWhere(
//                       (x) => x.id == id,
//                       orElse: () => Project(id: id, name: id),
//                     );
//                     return p.name;
//                   },
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _buildDropdown(
//                   'Sub Project',
//                   ['all', ..._subProjects.map((s) => s.id)],
//                   _selectedSubProject,
//                   (v) async {
//                     _selectedSubProject = v ?? 'all';
//                     debugPrint('[UI] subProject=$_selectedSubProject');
//                     await _loadActivities();
//                   },
//                   enabled: _selectedProject != 'all' && _subProjects.isNotEmpty,
//                   displayBuilder: (id) => id == 'all'
//                       ? 'All'
//                       : (_subProjects.firstWhere(
//                             (s) => s.id == id,
//                             orElse: () => SubProject(id: id, name: id),
//                           ).name),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _buildDropdown(
//                   'Status',
//                   const ['all', 'Open', 'Reschedule', 'Pending', 'In Progress', 'Completed', 'Canceled'],
//                   _selectedStatus,
//                   (v) => setState(() {
//                     _selectedStatus = v ?? 'all';
//                     _currentPage = 1;
//                     debugPrint('[UI] status=$_selectedStatus');
//                   }),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // List
//           Expanded(
//             child: _paged.isEmpty
//                 ? const Center(child: Text('No records found'))
//                 : ListView.separated(
//                     padding: const EdgeInsets.only(bottom: 12 + 58),
//                     separatorBuilder: (_, __) => const SizedBox(height: 12),
//                     itemCount: _paged.length + 1,
//                     itemBuilder: (context, i) {
//                       if (i < _paged.length) {
//                         return _ActivityCard(
//                           a: _paged[i],
//                           onUpdate: () async {
//                             // lists from lookups
//                             final subProjectNames = _subProjects.map((e) => e.name).toList();
//                             final siteNames = _sites
//                                 .where((s) => s.projectId == _paged[i].projectId)
//                                 .map((s) => s.siteName)
//                                 .toSet()
//                                 .toList()
//                               ..sort();
//                             final feNames = _feList.map((e) => e.name).where((e) => e.isNotEmpty).toSet().toList()
//                               ..sort();
//                             final nocNames = _nocs.map((e) => e.name).where((e) => e.isNotEmpty).toSet().toList()
//                               ..sort();

//                             await UpdateActivityModal.show(
//                               context,
//                               activity: _paged[i],
//                               subProjects: subProjectNames,
//                               siteNames: siteNames,
//                               feNames: feNames,
//                               nocEngineers: nocNames,
//                               onSubmit: (updated) async {
//                                 final feId = _feList.firstWhere(
//                                   (f) => f.name == updated.feName,
//                                   orElse: () => FieldEngineer(id: '', name: '', mobile: '', vendor: ''),
//                                 ).id;

//                                 final nocId = _nocs.firstWhere(
//                                   (n) => n.name == updated.nocEngineer,
//                                   orElse: () => NocEngineer(id: '', name: ''),
//                                 ).id;

//                                 final payload = {
//                                   'ticket_no': updated.tNo,
//                                   'project_id': _paged[i].projectId,
//                                   'site_id': updated.siteId,
//                                   'activity_category': updated.activity,
//                                   'activity_date': _paged[i].date.isEmpty ? null : _paged[i].date,
//                                   'completion_date':
//                                       updated.completionDate.isEmpty ? null : updated.completionDate,
//                                   'country': updated.country,
//                                   'state': updated.state,
//                                   'district': updated.district,
//                                   'city': updated.city,
//                                   'address': updated.address,
//                                   'project_manager': updated.pm,
//                                   'vendor': updated.vendor,
//                                   'field_engineer_id': feId.isEmpty ? null : feId,
//                                   'fe_mobile': updated.feMobile,
//                                   'noc_engineer_id': nocId.isEmpty ? null : nocId,
//                                   'remarks': updated.remarks,
//                                   'status': updated.status,
//                                   if (_paged[i].subProjectId != null && _paged[i].subProjectId!.isNotEmpty)
//                                     'sub_project_id': _paged[i].subProjectId,
//                                 };

//                                 final uri = Uri.parse('$kApiBase/api/activities/${_paged[i].id}');
//                                 debugPrint('[PUT] $uri\n${jsonEncode(payload)}');
//                                 final res = await http.put(
//                                   uri,
//                                   headers: {'Content-Type': 'application/json'},
//                                   body: jsonEncode(payload),
//                                 );
//                                 debugPrint('[PUT] -> ${res.statusCode} ${res.reasonPhrase} (${res.body.length} bytes)');

//                                 if (res.statusCode >= 200 && res.statusCode < 300) {
//                                   if (mounted) {
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(const SnackBar(content: Text('Activity updated')));
//                                     await _loadActivities();
//                                   }
//                                 } else {
//                                   if (mounted) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('Update failed (${res.statusCode})')),
//                                     );
//                                   }
//                                 }
//                               },
//                               onDelete: () async {
//                                 final uri = Uri.parse('$kApiBase/api/activities/${_paged[i].id}');
//                                 debugPrint('[DELETE] $uri');
//                                 final res = await http.delete(uri);
//                                 debugPrint('[DELETE] -> ${res.statusCode} ${res.reasonPhrase} (${res.body.length} bytes)');
//                                 if (res.statusCode >= 200 && res.statusCode < 300) {
//                                   if (mounted) {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(const SnackBar(content: Text('Activity deleted')));
//                                     await _loadActivities();
//                                   }
//                                 } else {
//                                   if (mounted) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('Delete failed (${res.statusCode})')),
//                                     );
//                                   }
//                                 }
//                               },
//                             );
//                           },
//                         );
//                       }

//                       // last item = pagination row
//                       return _PaginationInline(
//                         currentPage: _currentPage,
//                         totalPages: _totalPages,
//                         onPageSelected: _goToPage,
//                         onPrev: () => _goToPage(_currentPage - 1),
//                         onNext: () => _goToPage(_currentPage + 1),
//                         perPage: _perPage,
//                         options: _perPageOptions,
//                         onPerPageChanged: (v) => setState(() {
//                           _perPage = v;
//                           _currentPage = 1;
//                         }),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDropdown(
//     String hint,
//     List<String> items,
//     String selected,
//     ValueChanged<String?> onChanged, {
//     bool enabled = true,
//     String Function(String value)? displayBuilder,
//   }) {
//     final cs = Theme.of(context).colorScheme;
//     String labelOf(String v) => displayBuilder != null ? displayBuilder(v) : v;

//     final effectiveSelected = items.contains(selected) ? selected : items.first;

//     return Container(
//       height: 34,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: cs.outlineVariant),
//       ),
//       child: DropdownButton<String>(
//         value: effectiveSelected,
//         isExpanded: true,
//         underline: const SizedBox(),
//         dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//         iconEnabledColor: enabled ? cs.onSurfaceVariant : cs.outlineVariant,
//         style: TextStyle(color: enabled ? cs.onSurface : cs.onSurfaceVariant, fontSize: 12),
//         hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
//         onChanged: enabled ? onChanged : null,
//         items: items
//             .map(
//               (s) => DropdownMenuItem(
//                 value: s,
//                 child: Text(labelOf(s), style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Map<String, int> _calcStats(List<Activity> list) {
//     final m = {'Completed': 0, 'Pending': 0, 'In Progress': 0, 'Open': 0, 'Scheduled': 0, 'Rescheduled': 0};
//     for (final r in list) {
//       final s = r.status.toLowerCase();
//       if (s == 'completed') m['Completed'] = (m['Completed'] ?? 0) + 1;
//       else if (s == 'in progress') m['In Progress'] = (m['In Progress'] ?? 0) + 1;
//       else if (s == 'pending') m['Pending'] = (m['Pending'] ?? 0) + 1;
//       else if (s == 'open') m['Open'] = (m['Open'] ?? 0) + 1;
//       else if (s == 'scheduled') m['Scheduled'] = (m['Scheduled'] ?? 0) + 1;
//       else if (s.startsWith('resched')) m['Rescheduled'] = (m['Rescheduled'] ?? 0) + 1;
//     }
//     return m;
//   }
// }

// // ====== Reusable bits ======

// class _SummaryCard extends StatelessWidget {
//   final Map<String, int> stats;
//   const _SummaryCard({required this.stats});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final items = [
//       {'label': 'Completed', 'count': '${stats['Completed'] ?? 0}'},
//       {'label': 'Pending', 'count': '${stats['Pending'] ?? 0}'},
//       {'label': 'In-Progress', 'count': '${stats['In Progress'] ?? 0}'},
//       {'label': 'Open', 'count': '${stats['Open'] ?? 0}'},
//       {'label': 'Rescheduled', 'count': '${stats['Rescheduled'] ?? 0}'},
//     ];

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//         child: LayoutBuilder(
//           builder: (context, c) {
//             final tileWidth = (c.maxWidth - 24) / 2;
//             return Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: items.map((item) {
//                 return SizedBox(
//                   width: tileWidth,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       color: cs.surfaceContainerHighest,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(item['count']!,
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: isLight ? Colors.black : cs.onSurface)),
//                         const SizedBox(height: 4),
//                         Text(item['label']!, style: TextStyle(fontSize: 13, color: isLight ? Colors.black54 : cs.onSurfaceVariant)),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _ActivityStatusSection extends StatelessWidget {
//   final Map<String, int> stats;
//   const _ActivityStatusSection({required this.stats});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final total = stats.values.fold<int>(0, (a, b) => a + b);
//     double pct(String k) => total == 0 ? 0 : (100.0 * (stats[k] ?? 0) / total);

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Text('Activity Status', textAlign: TextAlign.center, style: TextStyle(color: cs.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 10),
//           ...['Completed', 'In Progress', 'Open', 'Rescheduled', 'Pending'].map((k) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//               child: Row(
//                 children: [
//                   const CircleAvatar(radius: 5),
//                   const SizedBox(width: 8),
//                   Expanded(child: Text(k, style: TextStyle(color: cs.onSurface))),
//                   Text('${pct(k).round()}%', style: TextStyle(color: cs.onSurfaceVariant)),
//                 ],
//               ),
//             );
//           }),
//         ]),
//       ),
//     );
//   }
// }

// class _PaginationBar extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   static const int _windowSize = 5;
//   const _PaginationBar({required this.currentPage, required this.totalPages, required this.onPageSelected});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final int windowStart = ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
//     final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

//     Widget pill({required Widget child, required bool selected, VoidCallback? onTap, double width = 40}) {
//       final bg = selected ? Colors.black : cs.surfaceContainerHighest;
//       final fg = selected ? Colors.white : cs.onSurface;

//       final content = Container(
//         width: width,
//         height: 36,
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
//           child: IconTheme.merge(
//             data: IconThemeData(color: fg, size: 18),
//             child: child,
//           ),
//         ),
//       );

//       return onTap == null ? Opacity(opacity: 0.5, child: content) : InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
//     }

//     final hasPrevWindow = windowStart > 1;
//     final hasNextWindow = windowEnd < totalPages;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         pill(child: const Icon(Icons.chevron_left), selected: false, onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null),
//         for (int p = windowStart; p <= windowEnd; p++) pill(child: Text('$p'), selected: p == currentPage, onTap: () => onPageSelected(p)),
//         pill(child: const Icon(Icons.chevron_right), selected: false, onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null),
//       ],
//     );
//   }
// }

// class _PaginationInline extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   final VoidCallback onPrev;
//   final VoidCallback onNext;
//   final int perPage;
//   final List<int> options;
//   final ValueChanged<int> onPerPageChanged;

//   const _PaginationInline({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//     required this.onPrev,
//     required this.onNext,
//     required this.perPage,
//     required this.options,
//     required this.onPerPageChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: SizedBox(
//         height: 40,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _PaginationBar(currentPage: currentPage, totalPages: totalPages, onPageSelected: onPageSelected),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 36,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: cs.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: cs.outlineVariant),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     value: perPage,
//                     dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                     style: TextStyle(fontSize: 13, color: cs.onSurface),
//                     items: options.map((n) => DropdownMenuItem(value: n, child: Text('$n'))).toList(),
//                     onChanged: (v) {
//                       if (v != null) onPerPageChanged(v);
//                     },
//                   ),
//                 ),
//               ),
//             ),
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
//           hintText: 'Search activities...',
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

// class _ActivityCard extends StatelessWidget {
//   final Activity a;
//   final VoidCallback onUpdate;
//   const _ActivityCard({required this.a, required this.onUpdate});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     String _t(String? v) => (v == null || v.trim().isEmpty) ? '-' : v;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 '${_t(a.tNo)}  ${_t(a.scheduledDate)}',
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Text('Status : ${_t(a.status)}', style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14)),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Divider(color: cs.outlineVariant),
//         const SizedBox(height: 12),
//         Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           // LEFT
//           Expanded(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               _infoRow('Project', a.project, labelColor, valueColor),
//               _infoRow('Sub Project', a.subProject, labelColor, valueColor),
//               // Site Name ellipsis
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Row(
//                   children: [
//                     Text('Site Name: ', style: TextStyle(color: labelColor, fontSize: 11)),
//                     Expanded(
//                       child: Text(a.siteName, style: TextStyle(color: valueColor, fontSize: 11), overflow: TextOverflow.ellipsis),
//                     ),
//                   ],
//                 ),
//               ),
//               _infoRow('Site Code', a.siteId, labelColor, valueColor),
//               _infoRow('Activity', a.activity, labelColor, valueColor),
//               _infoRow('Project Manager', a.pm, labelColor, valueColor),
//               _infoRow('Vendor (FE)', a.vendor, labelColor, valueColor),
//               _infoRow('FE/Vendor Name', a.feName, labelColor, valueColor),
//               _infoRow('FE/Vendor Mobile', a.feMobile, labelColor, valueColor),
//             ]),
//           ),
//           const SizedBox(width: 16),
//           // RIGHT
//           Expanded(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               _infoRow('NOC Engineer', a.nocEngineer, labelColor, valueColor),
//               _infoRow('Country', a.country, labelColor, valueColor),
//               _infoRow('State', a.state, labelColor, valueColor),
//               _infoRow('District', a.district, labelColor, valueColor),
//               _infoRow('City', a.city, labelColor, valueColor),
//               _infoRow('Address', a.address, labelColor, valueColor),
//               _infoRow('Completion Date', a.completionDateDmy, labelColor, valueColor),
//               _infoRow('Remarks', a.remarks, labelColor, valueColor),
//             ]),
//           ),
//         ]),
//         const SizedBox(height: 16),
//         Align(
//           alignment: Alignment.centerRight,
//           child: OutlinedButton(
//             style: OutlinedButton.styleFrom(
//               backgroundColor: AppTheme.accentColor,
//               side: const BorderSide(color: AppTheme.accentColor),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             ),
//             onPressed: onUpdate,
//             child: const Text('Update', style: TextStyle(color: Color(0xFF000000), fontSize: 12)),
//           ),
//         ),
//       ]),
//     );
//   }

//   Widget _infoRow(String label, String? value, Color labelColor, Color valueColor) {
//     String text = (value == null || value.trim().isEmpty) ? '-' : value;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$label: ',
//           style: TextStyle(color: labelColor, fontSize: 11),
//           children: [TextSpan(text: text, style: TextStyle(color: valueColor, fontSize: 11))],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';
import '../modals/update_activity_modal.dart';

// ===================== API BASE =====================
const String kApiBase = 'https://pmgt.commedialabs.com';

// ===================== DATA MODELS ==================
class Project {
  final String id;
  final String name;
  Project({required this.id, required this.name});
  factory Project.fromJson(Map<String, dynamic> j) =>
      Project(id: j['id']?.toString() ?? '', name: j['project_name'] ?? '');
}

class SubProject {
  final String id;
  final String name;
  SubProject({required this.id, required this.name});
  factory SubProject.fromJson(Map<String, dynamic> j) => SubProject(
    id: j['id']?.toString() ?? '',
    name: j['name'] ?? j['sub_project_name'] ?? '',
  );
}

class SiteAPI {
  final String projectId;
  final String projectName;
  final String siteId;
  final String siteName;
  final String country;
  final String state;
  final String district;
  final String city;
  final String address;
  final String? subProjectId;
  final String? subProjectName;

  SiteAPI({
    required this.projectId,
    required this.projectName,
    required this.siteId,
    required this.siteName,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    this.subProjectId,
    this.subProjectName,
  });

  factory SiteAPI.fromJson(Map<String, dynamic> j) => SiteAPI(
    projectId: j['project_id']?.toString() ?? '',
    projectName: j['project_name'] ?? '',
    siteId: j['site_id']?.toString() ?? '',
    siteName: j['site_name'] ?? '',
    country: j['country'] ?? '',
    state: j['state'] ?? '',
    district: j['district'] ?? '',
    city: j['city'] ?? '',
    address: j['address'] ?? '',
    subProjectId: j['sub_project_id']?.toString(),
    subProjectName: j['sub_project_name'],
  );
}

class FieldEngineer {
  final String id;
  final String name;
  final String mobile;
  final String vendor;
  FieldEngineer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.vendor,
  });
  factory FieldEngineer.fromJson(Map<String, dynamic> j) => FieldEngineer(
    id: j['id']?.toString() ?? '',
    name: j['full_name'] ?? '',
    mobile: j['contact_no'] ?? '',
    vendor: j['contact_person'] ?? '',
  );
}

class NocEngineer {
  final String id;
  final String name;
  NocEngineer({required this.id, required this.name});
  factory NocEngineer.fromJson(Map<String, dynamic> j) =>
      NocEngineer(id: j['id']?.toString() ?? '', name: j['full_name'] ?? '');
}

// Row used for UI (aligned to the Web)
class Activity {
  final String id;
  final String tNo;
  final String date; // yyyy-MM-dd
  final String completionDate; // yyyy-MM-dd
  final String projectId;
  final String project;
  final String? subProject; // name
  final String? subProjectId;
  final String activity;
  final String country;
  final String state;
  final String district;
  final String city;
  final String address;
  final String siteId; // code
  final String siteName; // name
  final String pm;
  final String vendor;
  final String? fieldEngineerId;
  final String feName;
  final String feMobile;
  final String? nocEngineerId;
  final String nocEngineer;
  final String remarks;
  final String status;

  Activity({
    required this.id,
    required this.tNo,
    required this.date,
    required this.completionDate,
    required this.projectId,
    required this.project,
    required this.subProject,
    required this.subProjectId,
    required this.activity,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    required this.siteId,
    required this.siteName,
    required this.pm,
    required this.vendor,
    required this.fieldEngineerId,
    required this.feName,
    required this.feMobile,
    required this.nocEngineerId,
    required this.nocEngineer,
    required this.remarks,
    required this.status,
  });

  String get scheduledDate =>
      date.isEmpty
          ? ''
          : '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';
  String get completionDateDmy =>
      completionDate.isEmpty
          ? ''
          : '${completionDate.substring(8, 10)}/${completionDate.substring(5, 7)}/${completionDate.substring(0, 4)}';
}

// ===================== UI ===========================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  // Toggle state for Project vs Summary
  final List<bool> _isSelected = [true, false];

  // -------- Filters ----------
  // 0=today, 1=tomorrow, 2=week, 3=month, 4=all   (web has year too; keep mobile concise)
  int _activityTimeIndex = 4;
  String _selectedProject = 'all';
  String _selectedSubProject = 'all';
  String _selectedStatus = 'all';
  String _search = '';

  // pagination (client side)
  int _currentPage = 1;
  final List<int> _perPageOptions = [10, 20, 30, 50];
  int _perPage = 20;

  // -------- Lookups + data ----------
  bool _loading = false;
  List<Project> _projects = [];
  List<SubProject> _subProjects = [];
  List<SiteAPI> _sites = [];
  List<FieldEngineer> _feList = [];
  List<NocEngineer> _nocs = [];
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() => _loading = true);
    try {
      debugPrint('[BOOT] start — fetching lookups');
      await Future.wait([
        _fetchProjects(),
        _fetchAllSites(),
        _fetchFEs(),
        _fetchNOCs(),
      ]);
      debugPrint('[BOOT] lookups done; loading activities…');
      await _loadActivities();
      debugPrint('[BOOT] complete. activities=${_activities.length}');
    } catch (e, st) {
      debugPrint('[BOOT][ERR] $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load initial data')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ============== API helpers ==================
  Future<void> _logGet(Uri uri, http.Response r, {String tag = ''}) async {
    debugPrint('[GET] $uri $tag -> ${r.statusCode} (${r.body.length} bytes)');
  }

  Future<void> _fetchProjects() async {
    final uri = Uri.parse('$kApiBase/api/projects');
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/projects');
    if (r.statusCode == 200) {
      final arr = jsonDecode(r.body) as List;
      _projects = arr.map((e) => Project.fromJson(e)).toList();
      setState(() {});
    } else {
      debugPrint('[GET][projects][ERR] ${r.body}');
    }
  }

  Future<void> _fetchSubProjects(String projectId) async {
    _selectedSubProject = 'all';
    _subProjects = [];
    setState(() {});
    if (projectId == 'all') {
      debugPrint('[SKIP] sub-projects — project=all');
      return;
    }

    final uri = Uri.parse('$kApiBase/api/projects/$projectId/sub-projects');
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/sub-projects');
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body);
      final list =
          (data is List) ? data : (data['sub_projects'] ?? data['data'] ?? []);
      _subProjects = (list as List).map((e) => SubProject.fromJson(e)).toList();
      debugPrint('[GET] sub-projects count=${_subProjects.length}');
      setState(() {});
    } else {
      debugPrint('[GET][sub-projects][ERR] ${r.body}');
    }
  }

  Future<void> _fetchAllSites() async {
    final uri = Uri.parse('$kApiBase/api/project-sites');
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/project-sites');
    if (r.statusCode == 200) {
      final arr = jsonDecode(r.body) as List;
      _sites = arr.map((e) => SiteAPI.fromJson(e)).toList();
      debugPrint('[GET] sites count=${_sites.length}');
      setState(() {});
    } else {
      debugPrint('[GET][sites][ERR] ${r.body}');
    }
  }

  Future<void> _fetchFEs() async {
    final uri = Uri.parse('$kApiBase/api/field-engineers');
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/field-engineers');
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body);
      final raw = (data is List) ? data : (data['field_engineers'] ?? []);
      _feList = (raw as List).map((e) => FieldEngineer.fromJson(e)).toList();
      debugPrint('[GET] FE count=${_feList.length}');
      setState(() {});
    } else {
      debugPrint('[GET][FEs][ERR] ${r.body}');
    }
  }

  Future<void> _fetchNOCs() async {
    final uri = Uri.parse('$kApiBase/api/nocs');
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/nocs');
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body);
      final list = (data is List) ? data : [];
      _nocs = (list).map((e) => NocEngineer.fromJson(e)).toList();
      debugPrint('[GET] NOC count=${_nocs.length}');
      setState(() {});
    } else {
      debugPrint('[GET][NOCs][ERR] ${r.body}');
    }
  }

  String _iso10(dynamic v) {
    final s = (v ?? '').toString();
    return s.length >= 10 ? s.substring(0, 10) : '';
  }

  Future<void> _loadActivities() async {
    final params = <String, String>{"page": "1", "limit": "1000"};
    if (_selectedProject != 'all') params['projectId'] = _selectedProject;
    if (_selectedSubProject != 'all') {
      params['subProjectId'] = _selectedSubProject;
    }

    final uri = Uri.parse(
      '$kApiBase/api/activities',
    ).replace(queryParameters: params);
    debugPrint('[GET] $uri');
    final r = await http.get(uri);
    await _logGet(uri, r, tag: '/activities');

    if (r.statusCode != 200) {
      debugPrint('[GET][activities][ERR] ${r.body}');
      return;
    }

    final data = jsonDecode(r.body);
    final rawActs = (data is List) ? data : (data['activities'] ?? []);
    final projectsById = {for (final p in _projects) p.id: p.name};

    List<Activity> rows = [];
    for (final a in rawActs) {
      final aPid = a['project_id']?.toString() ?? '';
      final aSid = a['site_id']?.toString() ?? '';
      final aSpid = a['sub_project_id']?.toString() ?? '';

      // Composite (site_id + sub_project_id) matching (same as web)
      final site = _sites.firstWhere(
        (s) =>
            s.projectId == aPid &&
            s.siteId == aSid &&
            ((aSpid.isNotEmpty)
                ? (s.subProjectId ?? '') == aSpid
                : ((s.subProjectId ?? '').isEmpty)),
        orElse:
            () => SiteAPI.fromJson({
              'project_id': aPid,
              'project_name': projectsById[aPid] ?? '',
              'site_id': aSid,
              'site_name': a['site_name'] ?? '',
              'country': a['country'] ?? '',
              'state': a['state'] ?? '',
              'district': a['district'] ?? '',
              'city': a['city'] ?? '',
              'address': a['address'] ?? '',
              'sub_project_id': aSpid.isEmpty ? null : aSpid,
              'sub_project_name': a['sub_project_name'] ?? a['sub_project'],
            }),
      );

      final fe = _feList.firstWhere(
        (f) => f.id == (a['field_engineer_id']?.toString() ?? ''),
        orElse:
            () => FieldEngineer(
              id: '',
              name: '',
              mobile: a['fe_mobile'] ?? '',
              vendor: a['vendor'] ?? '',
            ),
      );
      final noc = _nocs.firstWhere(
        (n) => n.id == (a['noc_engineer_id']?.toString() ?? ''),
        orElse: () => NocEngineer(id: '', name: a['noc_engineer'] ?? ''),
      );

      rows.add(
        Activity(
          id: a['id']?.toString() ?? '',
          tNo: a['ticket_no'] ?? '',
          date: _iso10(a['activity_date']),
          completionDate: _iso10(a['completion_date']),
          projectId: aPid,
          project: projectsById[aPid] ?? '',
          subProject: a['sub_project_name'] ?? a['sub_project'],
          subProjectId: aSpid.isEmpty ? null : aSpid,
          activity: a['activity_category'] ?? '',
          country: a['country'] ?? site.country,
          state: a['state'] ?? site.state,
          district: a['district'] ?? site.district,
          city: a['city'] ?? site.city,
          address: a['address'] ?? site.address,
          siteId: aSid,
          siteName: a['site_name'] ?? site.siteName,
          pm: a['project_manager'] ?? '',
          vendor: a['vendor'] ?? '',
          fieldEngineerId: a['field_engineer_id']?.toString(),
          feName: fe.name.isNotEmpty ? fe.name : (a['vendor'] ?? ''),
          feMobile: fe.mobile.isNotEmpty ? fe.mobile : (a['fe_mobile'] ?? ''),
          nocEngineerId: a['noc_engineer_id']?.toString(),
          nocEngineer: noc.name,
          remarks: a['remarks'] ?? '',
          status: a['status'] ?? '',
        ),
      );
    }

    // sort by numeric part of ticket no
    rows.sort((a, b) {
      int num(String s) {
        final parts = s.split('-');
        if (parts.length > 1) {
          return int.tryParse(parts.last.replaceAll(RegExp(r'[^0-9]'), '')) ??
              0;
        }
        return int.tryParse(RegExp(r'\d+').firstMatch(s)?.group(0) ?? '') ?? 0;
      }

      return num(a.tNo).compareTo(num(b.tNo));
    });

    // de-dup by id
    final seen = <String>{};
    _activities = rows.where((e) => seen.add(e.id)).toList();
    _currentPage = 1;
    debugPrint('[MAP] activities=${_activities.length}');
    setState(() {});
  }

  // ============== FILTERING/PAGING ==================
  List<Activity> get _dateScoped {
    DateTime today0() {
      final n = DateTime.now();
      return DateTime(n.year, n.month, n.day);
    }

    DateTime endOfDay(DateTime d) =>
        DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
    DateTime addDays(DateTime d, int n) => d.add(Duration(days: n));

    bool inFutureWindow(DateTime d, int days) {
      final t0 = today0();
      return (d.isAtSameMomentAs(t0) || d.isAfter(t0)) &&
          d.isBefore(endOfDay(addDays(t0, days)));
    }

    return _activities.where((r) {
      if (r.date.isEmpty) return false;
      final d = DateTime.tryParse(r.date) ?? DateTime(1970);
      switch (_activityTimeIndex) {
        case 0:
          final t0 = today0();
          return d.year == t0.year && d.month == t0.month && d.day == t0.day;
        case 1:
          final t1 = addDays(today0(), 1);
          return d.year == t1.year && d.month == t1.month && d.day == t1.day;
        case 2:
          return inFutureWindow(d, 7);
        case 3:
          return inFutureWindow(d, 30);
        default:
          return true;
      }
    }).toList();
  }

  List<Activity> get _filtered {
    final byProject =
        _selectedProject == 'all'
            ? _dateScoped
            : _dateScoped
                .where((r) => r.projectId == _selectedProject)
                .toList();

    final bySubProject =
        _selectedSubProject == 'all'
            ? byProject
            : byProject.where((r) {
              // Accepts either exact subProjectId match OR name match when id is absent
              final spName =
                  _subProjects
                      .firstWhere(
                        (s) => s.id == _selectedSubProject,
                        orElse: () => SubProject(id: '', name: ''),
                      )
                      .name;
              return (r.subProjectId != null &&
                      r.subProjectId == _selectedSubProject) ||
                  (r.subProjectId == null && (r.subProject ?? '') == spName);
            }).toList();

    final byStatus =
        _selectedStatus == 'all'
            ? bySubProject
            : bySubProject.where((r) {
              final s = (r.status).toLowerCase();
              if (_selectedStatus.toLowerCase().startsWith('resched')) {
                return s.startsWith('resched');
              }
              return s == _selectedStatus.toLowerCase();
            }).toList();

    final term = _search.trim().toLowerCase();
    if (term.isEmpty) return byStatus;

    return byStatus.where((r) {
      final blob =
          jsonEncode({
            'tNo': r.tNo,
            'date': r.date,
            'project': r.project,
            'subProject': r.subProject,
            'siteName': r.siteName,
            'siteId': r.siteId,
            'activity': r.activity,
            'pm': r.pm,
            'vendor': r.vendor,
            'feName': r.feName,
            'feMobile': r.feMobile,
            'nocEngineer': r.nocEngineer,
            'country': r.country,
            'state': r.state,
            'district': r.district,
            'city': r.city,
            'address': r.address,
            'remarks': r.remarks,
            'status': r.status,
          }).toLowerCase();
      return blob.contains(term);
    }).toList();
  }

  int get _totalPages {
    final len = _filtered.length;
    if (len == 0) return 1;
    return (len + _perPage - 1) ~/ _perPage;
  }

  List<Activity> get _paged {
    final list = _filtered;
    if (list.isEmpty) return const [];
    final start = (_currentPage - 1) * _perPage;
    final end = min(start + _perPage, list.length);
    if (start >= list.length) return const [];
    return list.sublist(start, end);
  }

  void _goToPage(int p) =>
      setState(() => _currentPage = p.clamp(1, _totalPages));

  // ================== NAV ===========================
  void _handleTabChange(BuildContext context, int i) {
    if (i == 0) return;
    late final Widget target;
    switch (i) {
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

  // ================== UI ============================
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      titleWidget: _buildTopToggle(context),
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
      currentIndex: 0,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _buildDashboardContent(),
    );
  }

  Widget _buildTopToggle(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final cs = Theme.of(context).colorScheme;

    final fillColor =
        isLight ? Colors.black12 : AppTheme.accentColor.withOpacity(0.18);
    final selBorderColor = isLight ? Colors.black : AppTheme.accentColor;
    final borderColor = isLight ? Colors.black26 : cs.outlineVariant;
    final selTextColor = isLight ? Colors.black : AppTheme.accentColor;
    final unselectedColor = isLight ? Colors.black54 : cs.onSurfaceVariant;

    return ToggleButtons(
      isSelected: _isSelected,
      borderRadius: BorderRadius.circular(8),
      fillColor: fillColor,
      selectedBorderColor: selBorderColor,
      borderColor: borderColor,
      selectedColor: selTextColor,
      color: unselectedColor,
      constraints: const BoxConstraints(minHeight: 32, minWidth: 96),
      onPressed: (index) {
        setState(() {
          for (var i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = (i == index);
          }
        });
      },
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text('Project'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text('Summary'),
        ),
      ],
    );
  }

  Widget _buildDashboardContent() {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

    if (!_isSelected[0]) {
      return ListView(
        padding: pad.copyWith(top: 4, bottom: 8 + 58),
        children: [
          _SummaryCard(stats: _calcStats(_dateScoped)),
          const SizedBox(height: 12),
          _ActivityStatusSection(stats: _calcStats(_dateScoped)),
        ],
      );
    }

    return Padding(
      padding: pad.copyWith(top: 2, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Activities',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 280,
                child: _SearchField(
                  onChanged:
                      (v) => setState(() {
                        _search = v;
                        _currentPage = 1;
                      }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 2),

          // Time filter
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:
                    [
                      'Today',
                      'Tomorrow',
                      'Week',
                      'Month',
                      'All',
                    ].asMap().entries.map((e) {
                      final idx = e.key;
                      final label = e.value;
                      final selected = idx == _activityTimeIndex;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap:
                              () => setState(() {
                                _activityTimeIndex = idx;
                                _currentPage = 1;
                              }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selected
                                      ? AppTheme.accentColor
                                      : Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                color:
                                    selected
                                        ? Colors.black
                                        : Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Filters
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  'Project',
                  ['all', ..._projects.map((p) => p.id)],
                  _selectedProject,
                  (v) async {
                    _selectedProject = v ?? 'all';
                    debugPrint('[UI] project=$_selectedProject');
                    await _fetchSubProjects(_selectedProject);
                    await _loadActivities();
                  },
                  displayBuilder: (id) {
                    if (id == 'all') return 'All';
                    final p = _projects.firstWhere(
                      (x) => x.id == id,
                      orElse: () => Project(id: id, name: id),
                    );
                    return p.name;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdown(
                  'Sub Project',
                  ['all', ..._subProjects.map((s) => s.id)],
                  _selectedSubProject,
                  (v) async {
                    _selectedSubProject = v ?? 'all';
                    debugPrint('[UI] subProject=$_selectedSubProject');
                    await _loadActivities();
                  },
                  enabled: _selectedProject != 'all' && _subProjects.isNotEmpty,
                  displayBuilder:
                      (id) =>
                          id == 'all'
                              ? 'All'
                              : (_subProjects
                                  .firstWhere(
                                    (s) => s.id == id,
                                    orElse: () => SubProject(id: id, name: id),
                                  )
                                  .name),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdown(
                  'Status',
                  const [
                    'all',
                    'Open',
                    'Reschedule',
                    'Pending',
                    'In Progress',
                    'Completed',
                    'Canceled',
                  ],
                  _selectedStatus,
                  (v) => setState(() {
                    _selectedStatus = v ?? 'all';
                    _currentPage = 1;
                    debugPrint('[UI] status=$_selectedStatus');
                  }),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // List
          Expanded(
            child:
                _paged.isEmpty
                    ? const Center(child: Text('No records found'))
                    : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 12 + 58),
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemCount: _paged.length + 1,
                      itemBuilder: (context, i) {
                        if (i < _paged.length) {
                          return _ActivityCard(
                            a: _paged[i],
                            onUpdate: () async {
                              // lists from lookups (for modal choices)
                              final subProjectNames =
                                  _subProjects.map((e) => e.name).toList();

                              final siteNames =
                                  _sites
                                      .where(
                                        (s) =>
                                            s.projectId == _paged[i].projectId,
                                      )
                                      .map((s) => s.siteName)
                                      .toSet()
                                      .toList()
                                    ..sort();

                              final feNames =
                                  _feList
                                      .map((e) => e.name)
                                      .where((e) => e.isNotEmpty)
                                      .toSet()
                                      .toList()
                                    ..sort();

                              final nocNames =
                                  _nocs
                                      .map((e) => e.name)
                                      .where((e) => e.isNotEmpty)
                                      .toSet()
                                      .toList()
                                    ..sort();


                              final projId = _paged[i].projectId;

// Build sub-project options from sites of this project (id + name, unique by id)
final Map<String, String> spMap = {};
for (final s in _sites.where((s) => s.projectId == projId)) {
  final id = (s.subProjectId ?? '').trim();
  final name = (s.subProjectName ?? '').trim();
  if (id.isNotEmpty && name.isNotEmpty) spMap[id] = name;
}
final subProjectsForRow = spMap.entries
    .map((e) => SubProject(id: e.key, name: e.value))
    .toList();

// FE/NOC lists you already have:
final fes = _feList;
final nocs = _nocs;

                              await UpdateActivityModal.show(
                                context,
                                activity: _paged[i],
                                // subProjects: _subProjects, 
                                subProjects: subProjectsForRow, 
                             
                                sites: _sites, // List<SiteAPI>
                                
                                fes: fes,
                                nocs: nocs,
                                onSubmit: (updated) async {
                                  final feId =
                                      _feList
                                          .firstWhere(
                                            (f) =>
                                                f.name.trim().toLowerCase() ==
                                                updated.feName
                                                    .trim()
                                                    .toLowerCase(),
                                            orElse:
                                                () => FieldEngineer(
                                                  id: '',
                                                  name: '',
                                                  mobile: '',
                                                  vendor: '',
                                                ),
                                          )
                                          .id;

                                  final nocId =
                                      _nocs
                                          .firstWhere(
                                            (n) =>
                                                n.name.trim().toLowerCase() ==
                                                updated.nocEngineer
                                                    .trim()
                                                    .toLowerCase(),
                                            orElse:
                                                () => NocEngineer(
                                                  id: '',
                                                  name: '',
                                                ),
                                          )
                                          .id;

                                  final payload = {
                                    'ticket_no': updated.tNo,
                                    'project_id': _paged[i].projectId,
                                    'site_id':
                                        updated
                                            .siteId, // from composite Site ID picker
                                    'activity_category': updated.activity,
                                    'activity_date':
                                        _paged[i].date.isEmpty
                                            ? null
                                            : _paged[i].date,
                                    'completion_date':
                                        updated.completionDate.isEmpty
                                            ? null
                                            : updated.completionDate,
                                    'country': updated.country,
                                    'state': updated.state,
                                    'district': updated.district,
                                    'city': updated.city,
                                    'address': updated.address,
                                    'project_manager': updated.pm,
                                    'vendor': updated.vendor,
                                    'field_engineer_id':
                                        feId.isEmpty ? null : feId,
                                    'fe_mobile': updated.feMobile,
                                    'noc_engineer_id':
                                        nocId.isEmpty ? null : nocId,
                                    'remarks': updated.remarks,
                                    'status': updated.status,
                                    // include for disambiguation like web
                                    if ((updated.subProjectId ?? '').isNotEmpty)
                                      'sub_project_id': updated.subProjectId,
                                  };

                                  final uri = Uri.parse(
                                    '$kApiBase/api/activities/${_paged[i].id}',
                                  );
                                  debugPrint(
                                    '[PUT] $uri\n${jsonEncode(payload)}',
                                  );
                                  final res = await http.put(
                                    uri,
                                    headers: {
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode(payload),
                                  );
                                  debugPrint(
                                    '[PUT] -> ${res.statusCode} ${res.reasonPhrase} (${res.body.length} bytes)',
                                  );

                                  if (res.statusCode >= 200 &&
                                      res.statusCode < 300) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Activity updated'),
                                        ),
                                      );
                                      await _loadActivities();
                                    }
                                  } else {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Update failed (${res.statusCode})',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                onDelete: () async {
                                  final uri = Uri.parse(
                                    '$kApiBase/api/activities/${_paged[i].id}',
                                  );
                                  debugPrint('[DELETE] $uri');
                                  final res = await http.delete(uri);
                                  debugPrint(
                                    '[DELETE] -> ${res.statusCode} ${res.reasonPhrase} (${res.body.length} bytes)',
                                  );
                                  if (res.statusCode >= 200 &&
                                      res.statusCode < 300) {
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Activity deleted'),
                                        ),
                                      );
                                      await _loadActivities();
                                    }
                                  } else {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Delete failed (${res.statusCode})',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          );
                        }

                        // last item = pagination row
                        return _PaginationInline(
                          currentPage: _currentPage,
                          totalPages: _totalPages,
                          onPageSelected: _goToPage,
                          onPrev: () => _goToPage(_currentPage - 1),
                          onNext: () => _goToPage(_currentPage + 1),
                          perPage: _perPage,
                          options: _perPageOptions,
                          onPerPageChanged:
                              (v) => setState(() {
                                _perPage = v;
                                _currentPage = 1;
                              }),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String selected,
    ValueChanged<String?> onChanged, {
    bool enabled = true,
    String Function(String value)? displayBuilder,
  }) {
    final cs = Theme.of(context).colorScheme;
    String labelOf(String v) => displayBuilder != null ? displayBuilder(v) : v;

    final effectiveSelected = items.contains(selected) ? selected : items.first;

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: DropdownButton<String>(
        value: effectiveSelected,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        iconEnabledColor: enabled ? cs.onSurfaceVariant : cs.outlineVariant,
        style: TextStyle(
          color: enabled ? cs.onSurface : cs.onSurfaceVariant,
          fontSize: 12,
        ),
        hint: Text(
          hint,
          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
        ),
        onChanged: enabled ? onChanged : null,
        items:
            items
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      labelOf(s),
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Map<String, int> _calcStats(List<Activity> list) {
    final m = {
      'Completed': 0,
      'Pending': 0,
      'In Progress': 0,
      'Open': 0,
      'Scheduled': 0,
      'Rescheduled': 0,
    };
    for (final r in list) {
      final s = r.status.toLowerCase();
      if (s == 'completed') {
        m['Completed'] = (m['Completed'] ?? 0) + 1;
      } else if (s == 'in progress') {
        m['In Progress'] = (m['In Progress'] ?? 0) + 1;
      } else if (s == 'pending') {
        m['Pending'] = (m['Pending'] ?? 0) + 1;
      } else if (s == 'open') {
        m['Open'] = (m['Open'] ?? 0) + 1;
      } else if (s == 'scheduled') {
        m['Scheduled'] = (m['Scheduled'] ?? 0) + 1;
      } else if (s.startsWith('resched')) {
        m['Rescheduled'] = (m['Rescheduled'] ?? 0) + 1;
      }
    }
    return m;
  }
}

// ====== Reusable bits ======

class _SummaryCard extends StatelessWidget {
  final Map<String, int> stats;
  const _SummaryCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final items = [
      {'label': 'Completed', 'count': '${stats['Completed'] ?? 0}'},
      {'label': 'Pending', 'count': '${stats['Pending'] ?? 0}'},
      {'label': 'In-Progress', 'count': '${stats['In Progress'] ?? 0}'},
      {'label': 'Open', 'count': '${stats['Open'] ?? 0}'},
      {'label': 'Rescheduled', 'count': '${stats['Rescheduled'] ?? 0}'},
    ];

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: LayoutBuilder(
          builder: (context, c) {
            final tileWidth = (c.maxWidth - 24) / 2;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  items.map((item) {
                    return SizedBox(
                      width: tileWidth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item['count']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isLight ? Colors.black : cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['label']!,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    isLight
                                        ? Colors.black54
                                        : cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Activity a;
  final VoidCallback onUpdate;
  const _ActivityCard({required this.a, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final valueColor = isLight ? Colors.black : cs.onSurface;

    String t(String? v) => (v == null || v.trim().isEmpty) ? '-' : v;

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
          Row(
            children: [
              Expanded(
                child: Text(
                  '${t(a.tNo)}  ${t(a.scheduledDate)}',
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Status : ${t(a.status)}',
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Project', a.project, labelColor, valueColor),
                    _infoRow(
                      'Sub Project',
                      a.subProject,
                      labelColor,
                      valueColor,
                    ),
                    // Site Name ellipsis
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text(
                            'Site Name: ',
                            style: TextStyle(color: labelColor, fontSize: 11),
                          ),
                          Expanded(
                            child: Text(
                              a.siteName,
                              style: TextStyle(color: valueColor, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _infoRow('Site Code', a.siteId, labelColor, valueColor),
                    _infoRow('Activity', a.activity, labelColor, valueColor),
                    _infoRow('Project Manager', a.pm, labelColor, valueColor),
                    _infoRow('Vendor (FE)', a.vendor, labelColor, valueColor),
                    _infoRow(
                      'FE/Vendor Name',
                      a.feName,
                      labelColor,
                      valueColor,
                    ),
                    _infoRow(
                      'FE/Vendor Mobile',
                      a.feMobile,
                      labelColor,
                      valueColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // RIGHT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(
                      'NOC Engineer',
                      a.nocEngineer,
                      labelColor,
                      valueColor,
                    ),
                    _infoRow('Country', a.country, labelColor, valueColor),
                    _infoRow('State', a.state, labelColor, valueColor),
                    _infoRow('District', a.district, labelColor, valueColor),
                    _infoRow('City', a.city, labelColor, valueColor),
                    _infoRow('Address', a.address, labelColor, valueColor),
                    _infoRow(
                      'Completion Date',
                      a.completionDateDmy,
                      labelColor,
                      valueColor,
                    ),
                    _infoRow('Remarks', a.remarks, labelColor, valueColor),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onPressed: onUpdate,
              child: const Text(
                'Update',
                style: TextStyle(color: Color(0xFF000000), fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    String? value,
    Color labelColor,
    Color valueColor,
  ) {
    String text = (value == null || value.trim().isEmpty) ? '-' : value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(color: labelColor, fontSize: 11),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(color: valueColor, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityStatusSection extends StatelessWidget {
  final Map<String, int> stats;
  const _ActivityStatusSection({required this.stats});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final total = stats.values.fold<int>(0, (a, b) => a + b);
    double pct(String k) => total == 0 ? 0 : (100.0 * (stats[k] ?? 0) / total);

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Activity Status',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 10),
            ...[
              'Completed',
              'In Progress',
              'Open',
              'Rescheduled',
              'Pending',
            ].map((k) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 5),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(k, style: TextStyle(color: cs.onSurface)),
                    ),
                    Text(
                      '${pct(k).round()}%',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;
  static const int _windowSize = 5;
  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final int windowStart =
        ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
    final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

    Widget pill({
      required Widget child,
      required bool selected,
      VoidCallback? onTap,
      double width = 40,
    }) {
      final bg = selected ? Colors.black : cs.surfaceContainerHighest;
      final fg = selected ? Colors.white : cs.onSurface;

      final content = Container(
        width: width,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          child: IconTheme.merge(
            data: IconThemeData(color: fg, size: 18),
            child: child,
          ),
        ),
      );

      return onTap == null
          ? Opacity(opacity: 0.5, child: content)
          : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: content,
          );
    }

    final hasPrevWindow = windowStart > 1;
    final hasNextWindow = windowEnd < totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        pill(
          child: const Icon(Icons.chevron_left),
          selected: false,
          onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null,
        ),
        for (int p = windowStart; p <= windowEnd; p++)
          pill(
            child: Text('$p'),
            selected: p == currentPage,
            onTap: () => onPageSelected(p),
          ),
        pill(
          child: const Icon(Icons.chevron_right),
          selected: false,
          onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null,
        ),
      ],
    );
  }
}

class _PaginationInline extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final int perPage;
  final List<int> options;
  final ValueChanged<int> onPerPageChanged;

  const _PaginationInline({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    required this.onPrev,
    required this.onNext,
    required this.perPage,
    required this.options,
    required this.onPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _PaginationBar(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageSelected: onPageSelected,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: perPage,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(fontSize: 13, color: cs.onSurface),
                    items:
                        options
                            .map(
                              (n) =>
                                  DropdownMenuItem(value: n, child: Text('$n')),
                            )
                            .toList(),
                    onChanged: (v) {
                      if (v != null) onPerPageChanged(v);
                    },
                  ),
                ),
              ),
            ),
          ],
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
          hintText: 'Search activities...',
          hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}
