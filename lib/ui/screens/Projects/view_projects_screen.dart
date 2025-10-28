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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

// Bottom nav targets
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

// Update modal (you already have this)
import '../modals/update_project_modal.dart';

// If you already define this globally, keep it. Otherwise set your base URL here.
const String kApiBase = String.fromEnvironment('API_BASE', defaultValue: '');

class ViewProjectsScreen extends StatefulWidget {
  const ViewProjectsScreen({super.key});

  @override
  State<ViewProjectsScreen> createState() => _ViewProjectsScreenState();
}

class _ViewProjectsScreenState extends State<ViewProjectsScreen> {
  final int _selectedTab = 1;

  // Filters
  String _selectedProject = 'All';
  String _selectedChild = 'All (children)';
  String _query = '';

  // Data
  final List<_Project> _projects = []; // filled from API
  bool _loading = false;

  // Project name list for filter dropdown
  List<String> get _projectNames {
    final s = <String>{'All'};
    for (final p in _projects) {
      s.add(p.projectName);
    }
    return s.toList();
  }

  // Child options derived from selected parent
  List<String> get _childOptions {
    if (_selectedProject == 'All') return const ['All (children)'];
    final names = <String>{};
    for (final p in _projects.where((x) => x.projectName == _selectedProject)) {
      names.addAll(p.subProjects);
    }
    return ['All (children)', ...names];
  }

  // ---- HTTP helpers ----
  Future<Map<String, String>> _authHeaders() async {
    // If you keep the token somewhere, add it here.
    // Example if you use SharedPreferences or any auth provider.
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('pmgt_token');
    const token = null; // replace with your real token look-up
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<void> _loadProjects() async {
    setState(() => _loading = true);
    try {
      final headers = await _authHeaders();
      final res = await http.get(Uri.parse('$kApiBase/api/projects'), headers: headers);
      if (res.statusCode < 200 || res.statusCode >= 300) {
        throw Exception('HTTP ${res.statusCode}');
      }
      final raw = jsonDecode(res.body) as List<dynamic>;
      _projects.clear();
      // Map projects
      for (final m in raw) {
        final id = m['id']?.toString() ?? '';
        final projectName = (m['project_name'] ?? '').toString();
        final projectCode = (m['project_code'] ?? '').toString();

        // Child/ Sub projects fetch (like web)
        final subs = await _fetchSubProjects(id);

        _projects.add(
          _Project(
            id: id,
            projectName: projectName,
            type: (m['project_type'] ?? '').toString(),
            customerName: (m['customer_name'] ?? '').toString(),
            projectCode: projectCode,
            projectManager: (m['project_manager'] ?? '').toString(),
            bdm: (m['bdm'] ?? '').toString(),
            startDate: _isoToDmy(m['start_date']),
            endDate: _isoToDmy(m['end_date']),
            amcYear: m['amc_year'] == null ? '' : m['amc_year'].toString(),
            amcMonths: m['amc_months'] == null ? '' : m['amc_months'].toString(),
            subProjects: subs,
          ),
        );
      }

      // Reset filters if their values are no longer valid
      if (!_projectNames.contains(_selectedProject)) {
        _selectedProject = 'All';
        _selectedChild = 'All (children)';
      } else if (!_childOptions.contains(_selectedChild)) {
        _selectedChild = 'All (children)';
      }

      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load projects: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<List<String>> _fetchSubProjects(String projectId) async {
    try {
      final headers = await _authHeaders();
      final url = '$kApiBase/api/projects/$projectId/sub-projects';
      final r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode < 200 || r.statusCode >= 300) return const [];
      final data = jsonDecode(r.body);

      // Your API sometimes returns {sub_projects:[...]}, sometimes a raw array; guard both.
      final list = (data is List)
          ? data
          : (data is Map && data['sub_projects'] is List)
              ? data['sub_projects']
              : (data is Map && data['data'] is List)
                  ? data['data']
                  : const [];

      return List<String>.from(
        (list as List)
            .map((e) => (e['name'] ?? e['sub_project_name'] ?? '').toString())
            .where((s) => s.isNotEmpty),
      );
    } catch (_) {
      return const [];
    }
  }

  // ---- Filtering ----
  List<_Project> get _filtered {
    final q = _query.trim().toLowerCase();

    return _projects.where((p) {
      final okProject = _selectedProject == 'All' || p.projectName == _selectedProject;
      final okChild = (_selectedProject == 'All') ||
          _selectedChild == 'All (children)' ||
          p.subProjects.contains(_selectedChild);
      final okSearch = q.isEmpty ||
          p.projectName.toLowerCase().contains(q) ||
          p.customerName.toLowerCase().contains(q) ||
          p.projectCode.toLowerCase().contains(q);
      return okProject && okChild && okSearch;
    }).toList();
  }

  // ---- Update propagation from modal ----
  void _handleProjectUpdated(ProjectDto updated) {
    setState(() {
      final i = _projects.indexWhere((x) => x.projectCode == updated.projectCode);
      if (i != -1) {
        _projects[i] = _Project(
          id: _projects[i].id,
          projectName: updated.projectName,
          type: updated.type,
          customerName: updated.customerName,
          projectCode: updated.projectCode,
          projectManager: updated.projectManager,
          bdm: updated.bdm,
          startDate: updated.startDate,
          endDate: updated.endDate,
          amcYear: updated.amcYear,
          amcMonths: updated.amcMonths,
          subProjects: updated.subProjects,
        );
      }
    });
  }

  // ---- Bottom nav routing ----
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
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
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
              // Search
              const SizedBox(height: 4),
              _SearchField(onChanged: (v) => setState(() => _query = v)),
              const SizedBox(height: 8),
              Divider(color: cs.outlineVariant),
              const SizedBox(height: 8),

              // Filter row: Project + Child (labeled) + Export
              Row(
                children: [
                  Expanded(
                    child: _LabeledCompactDropdown<String>(
                      label: 'Project',
                      value: _selectedProject,
                      items: _projectNames,
                      hint: 'Select Project',
                      onChanged: (v) {
                        setState(() {
                          _selectedProject = v ?? 'All';
                          _selectedChild = 'All (children)';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _LabeledCompactDropdown<String>(
                      label: 'Child Project',
                      value: _selectedChild,
                      items: _childOptions,
                      hint: 'All (children)',
                      disabled: _selectedProject == 'All' || _childOptions.length <= 1,
                      onChanged: (v) => setState(() => _selectedChild = v ?? 'All (children)'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 34,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Export starting…')),
                        );
                      },
                      icon: const Icon(Icons.download, color: Colors.black, size: 18),
                      label: const Text(
                        'Export',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                      ),
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

              const SizedBox(height: 12),

              // Cards
              ..._filtered.map(
                (p) => _ProjectCard(
                  p: p,
                  onUpdated: _handleProjectUpdated,
                ),
              ),

              if (!_loading && _filtered.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('No projects found', style: TextStyle(color: cs.onSurfaceVariant)),
                  ),
                ),
            ],
          ),

          if (_loading)
            Positioned.fill(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.35),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  // ---- small utils ----
  String _isoToDmy(dynamic iso) {
    final s = (iso ?? '').toString();
    if (s.isEmpty) return '';
    final d = DateTime.tryParse(s);
    if (d == null) return '';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return '$dd/$mm/$yy';
  }
}

class _ProjectCard extends StatelessWidget {
  final _Project p;
  final void Function(ProjectDto updated)? onUpdated;
  const _ProjectCard({required this.p, this.onUpdated});

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
              Text(
                p.projectName,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                'Type : ${p.type}',
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

          // Two columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Customer Name', p.customerName, labelColor, valueColor),
                    _infoRow('Project Code', p.projectCode, labelColor, valueColor),
                    if (p.subProjects.isEmpty)
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
                              children: p.subProjects
                                  .map(
                                    (s) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                                      ),
                                      child: Text(s, style: TextStyle(color: valueColor, fontSize: 11)),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    _infoRow('Project Manager', p.projectManager, labelColor, valueColor),
                    _infoRow('BDM', p.bdm, labelColor, valueColor),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Start Date', p.startDate, labelColor, valueColor),
                    _infoRow('End Date', p.endDate, labelColor, valueColor),
                    _infoRow('AMC Year', p.amcYear, labelColor, valueColor),
                    _infoRow('AMC Months', p.amcMonths, labelColor, valueColor),
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
                      projectName: p.projectName,
                      type: p.type,
                      customerName: p.customerName,
                      projectCode: p.projectCode,
                      projectManager: p.projectManager,
                      bdm: p.bdm,
                      startDate: p.startDate,
                      endDate: p.endDate,
                      amcYear: p.amcYear,
                      amcMonths: p.amcMonths,
                      subProjects: p.subProjects,
                    ),
                  ),
                );
                if (result != null && onUpdated != null) {
                  onUpdated!(result);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Project updated')),
                  );
                }
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
          children: [
            TextSpan(text: value, style: TextStyle(color: valueColor, fontSize: 11)),
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
          hintText: 'Search...',
          hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

/// Labeled compact dropdown used in the filter row
class _LabeledCompactDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  final bool disabled;
  const _LabeledCompactDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final body = Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: disabled ? cs.surfaceContainerHigh : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          onChanged: disabled ? null : onChanged,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          iconEnabledColor: cs.onSurfaceVariant,
          style: TextStyle(color: cs.onSurface, fontSize: 12),
          hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body,
      ],
    );
  }
}

class _Project {
  final String id;
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

  _Project({
    required this.id,
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
}
