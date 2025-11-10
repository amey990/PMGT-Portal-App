// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
// import 'package:pmgt/ui/screens/accounts/accounts_raise_pa_screen.dart';
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AccountsProjectListScreen extends StatefulWidget {
//   const AccountsProjectListScreen({super.key});

//   @override
//   State<AccountsProjectListScreen> createState() => _AccountsProjectListScreenState();
// }

// class _AccountsProjectListScreenState extends State<AccountsProjectListScreen> {
//   // search + dropdown
//   String _query = '';
//   String _selected = 'All';

//   final List<String> _projectFilter = const [
//     'All',
//     'TCL GSTN',
//     'NDSatcom SAMOFA',
//     'Airtel VC',
//     'NTT HDFC VC',
//     'SES',
//     'Jio AMC',
//   ];

//   // sample data
//   final List<_AccProject> _data = const [
//     _AccProject(
//       customer: 'TCL GSTN',
//       code: 'TCL GSTN-CSPL',
//       name: 'TCL GSTN',
//       type: 'Implementation',
//       manager: 'Aniket Barne',
//       bdm: '—',
//       start: '15/09/2025',
//       end: '14/09/2026',
//     ),
//     _AccProject(
//       customer: 'TCL GSTN',
//       code: 'TCL-CSPL',
//       name: 'TCL',
//       type: 'Implementation',
//       manager: 'Aniket Barne',
//       bdm: '—',
//       start: '15/09/2025',
//       end: '14/09/2026',
//     ),
//     _AccProject(
//       customer: 'NDSatcom SAMOFA',
//       code: 'NDSatcom SAMOFA-CSPL',
//       name: 'NDSatcom SAMOFA',
//       type: 'Maintenance',
//       manager: 'kishor kunal',
//       bdm: '—',
//       start: '01/04/2025',
//       end: '31/03/2026',
//     ),
//     _AccProject(
//       customer: 'Airtel VC',
//       code: 'TCL-CSPL',
//       name: 'Airtel VC',
//       type: 'Implementation',
//       manager: 'kishor kunal',
//       bdm: '—',
//       start: '01/04/2025',
//       end: '31/03/2026',
//     ),
//     _AccProject(
//       customer: 'NTT HDFC VC',
//       code: 'NTT HDFC VC-CSPL',
//       name: 'NTT HDFC VC',
//       type: 'Implementation',
//       manager: 'kishor kunal',
//       bdm: '—',
//       start: '01/04/2025',
//       end: '31/03/2026',
//     ),
//   ];

//   List<_AccProject> get _filtered {
//     final q = _query.trim().toLowerCase();
//     return _data.where((p) {
//       final okDrop = _selected == 'All' || p.customer == _selected;
//       final okSearch = q.isEmpty ||
//           p.customer.toLowerCase().contains(q) ||
//           p.code.toLowerCase().contains(q) ||
//           p.name.toLowerCase().contains(q) ||
//           p.manager.toLowerCase().contains(q);
//       return okDrop && okSearch;
//     }).toList();
//   }

//   void _handleTabChange(BuildContext context, int i) {
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();    break;
//     case 1: target = const AddProjectScreen();   break;
//     case 2: target = const AddActivityScreen();  break; // center “Add”
//     case 3: target = const AnalyticsScreen();    break;
//     case 4: target = const ViewUsersScreen();    break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Atlas Accounting',
//       centerTitle: true,
//       drawerMode: DrawerMode.accounts, // <= use Accounts drawer
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: 0,                          // this page is not a primary tab
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
//           onPressed: () => Navigator.of(context).push(
//             MaterialPageRoute(builder: (_) => const ProfileScreen()),
//           ),
//           // icon: ClipOval(
//           //   child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           // ),
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
//         children: [
//           // Search + dropdown in ONE row
//           Row(
//             children: [
//               Expanded(
//                 child: _SearchField(onChanged: (v) => setState(() => _query = v)),
//               ),
//               const SizedBox(width: 8),
//               SizedBox(
//                 width: 160,
//                 child: _CompactDropdown<String>(
//                   value: _selected,
//                   items: _projectFilter,
//                   hint: 'Project',
//                   onChanged: (v) => setState(() => _selected = v ?? 'All'),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // cards
//           ..._filtered.map(
//             (p) => _AccProjectCard(
//               p: p,
//               onRaisePa: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (_) => const AccountsRaisePaScreen()),
//               ),
//             ),
//           ),

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

// // ---------------- UI Bits ----------------

// class _AccProjectCard extends StatelessWidget {
//   final _AccProject p;
//   final VoidCallback onRaisePa;
//   const _AccProjectCard({required this.p, required this.onRaisePa});

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
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Header: Customer | Code
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   p.customer,
//                   style: TextStyle(
//                     color: valueColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               Text(
//                 p.code,
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

//           // Two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // left
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Project', p.name, labelColor, valueColor),
//                     _kv('Type', p.type, labelColor, valueColor),
//                     _kv('Manager', p.manager, labelColor, valueColor),
//                     _kv('BDM', p.bdm, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // right
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Start', p.start, labelColor, valueColor),
//                     _kv('End', p.end, labelColor, valueColor),
//                     const SizedBox(height: 8),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                         ),
//                         onPressed: onRaisePa,
//                         child: const Text('Raise PA', style: TextStyle(fontWeight: FontWeight.w700)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 12),
//           children: [
//             TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // compact search identical look to Projects screen
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

// // model
// class _AccProject {
//   final String customer;
//   final String code;
//   final String name;
//   final String type;
//   final String manager;
//   final String bdm;
//   final String start;
//   final String end;

//   const _AccProject({
//     required this.customer,
//     required this.code,
//     required this.name,
//     required this.type,
//     required this.manager,
//     required this.bdm,
//     required this.start,
//     required this.end,
//   });
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
import 'package:pmgt/ui/screens/accounts/accounts_raise_pa_screen.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// 🔧 Set this to your server base (same as web VITE_API_BASE)
const String API_BASE = 'https://pmgt.commedialabs.com';


class AccountsProjectListScreen extends StatefulWidget {
  const AccountsProjectListScreen({super.key});

  @override
  State<AccountsProjectListScreen> createState() => _AccountsProjectListScreenState();
}

class _AccountsProjectListScreenState extends State<AccountsProjectListScreen> {
  // search + dropdown
  String _query = '';
  String _selected = 'All';

  // dynamic from API
  List<_AccProject> _data = [];
  bool _loading = true;
  String? _error;

  // project filter options (built from loaded data)
  List<String> get _projectFilter =>
      ['All', ...{for (final r in _data) r.customer}];

  List<_AccProject> get _filtered {
    final q = _query.trim().toLowerCase();
    return _data.where((p) {
      final okDrop = _selected == 'All' || p.customer == _selected;
      final okSearch = q.isEmpty ||
          p.customer.toLowerCase().contains(q) ||
          p.code.toLowerCase().contains(q) ||
          p.name.toLowerCase().contains(q) ||
          p.manager.toLowerCase().contains(q) ||
          (p.subProjectName ?? '').toLowerCase().contains(q);
      return okDrop && okSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // 1) projects
      final pr = await http.get(Uri.parse('$API_BASE/api/projects/'));
      if (pr.statusCode != 200) throw 'Projects ${pr.statusCode}';
      final raw = jsonDecode(pr.body) as List<dynamic>;

      final projects = raw
          .map((p) => _ProjectRow(
                id: '${p['id']}',
                customer: '${p['customer_name']}',
                code: '${p['project_code']}',
                name: '${p['project_name']}',
                type: '${p['project_type']}',
                manager: '${p['project_manager']}',
                bdm: (p['bdm'] ?? '').toString(),
                start: DateTime.parse(p['start_date']).toLocal(),
                end: DateTime.parse(p['end_date']).toLocal(),
              ))
          .toList();

      // 2) sub projects for each
      final List<_AccProject> flat = [];
      for (final p in projects) {
        try {
          final spRes =
              await http.get(Uri.parse('$API_BASE/api/projects/${p.id}/sub-projects'));
          List<dynamic> arr;
          if (spRes.statusCode == 200) {
            final body = jsonDecode(spRes.body);
            if (body is List) {
              arr = body;
            } else if (body is Map && body['sub_projects'] is List) {
              arr = body['sub_projects'];
            } else if (body is Map && body['data'] is List) {
              arr = body['data'];
            } else {
              arr = const [];
            }
          } else {
            arr = const [];
          }

          if (arr.isEmpty) {
            flat.add(_AccProject(
              id: p.id,
              customer: p.customer,
              code: p.code,
              name: p.name,
              type: p.type,
              manager: p.manager,
              bdm: p.bdm,
              start: _fmtDate(p.start),
              end: _fmtDate(p.end),
            ));
          } else {
            for (final s in arr) {
              flat.add(_AccProject(
                id: p.id,
                customer: p.customer,
                code: p.code,
                name: p.name,
                type: p.type,
                manager: p.manager,
                bdm: p.bdm,
                start: _fmtDate(p.start),
                end: _fmtDate(p.end),
                subProjectId: '${s['id']}',
                subProjectName:
                    '${s['name'] ?? s['sub_project_name'] ?? ''}'.trim().isEmpty
                        ? null
                        : '${s['name'] ?? s['sub_project_name']}',
              ));
            }
          }
        } catch (_) {
          // fall back to base row when child fetch fails
          flat.add(_AccProject(
            id: p.id,
            customer: p.customer,
            code: p.code,
            name: p.name,
            type: p.type,
            manager: p.manager,
            bdm: p.bdm,
            start: _fmtDate(p.start),
            end: _fmtDate(p.end),
          ));
        }
      }

      setState(() => _data = flat);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
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
        break; // center “Add”
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
      title: 'Atlas Accounting',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: 0,
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
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text('Failed to load projects\n$_error',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: cs.error)),
                )
              : ListView(
                  padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
                  children: [
                    // Search + dropdown in ONE row
                    Row(
                      children: [
                        Expanded(
                          child: _SearchField(onChanged: (v) => setState(() => _query = v)),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 160,
                          child: _CompactDropdown<String>(
                            value: _selected,
                            items: _projectFilter,
                            hint: 'Project',
                            onChanged: (v) => setState(() => _selected = v ?? 'All'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // cards
                    ..._filtered.map(
                      (p) => _AccProjectCard(
                        p: p,
                        onRaisePa: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AccountsRaisePaScreen(
                              projectId: p.id,
                              subProjectId: p.subProjectId,
                              projectName: p.name,
                              childProjectName: p.subProjectName,
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (_filtered.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('No projects found',
                              style: TextStyle(color: cs.onSurfaceVariant)),
                        ),
                      ),
                  ],
                ),
    );
  }
}

String _fmtDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

// --- small structs for loading and rendering
class _ProjectRow {
  final String id;
  final String customer;
  final String code;
  final String name;
  final String type;
  final String manager;
  final String bdm;
  final DateTime start;
  final DateTime end;
  _ProjectRow({
    required this.id,
    required this.customer,
    required this.code,
    required this.name,
    required this.type,
    required this.manager,
    required this.bdm,
    required this.start,
    required this.end,
  });
}

class _AccProject {
  final String id;
  final String customer;
  final String code;
  final String name;
  final String type;
  final String manager;
  final String bdm;
  final String start;
  final String end;
  final String? subProjectId;
  final String? subProjectName;

  const _AccProject({
    required this.id,
    required this.customer,
    required this.code,
    required this.name,
    required this.type,
    required this.manager,
    required this.bdm,
    required this.start,
    required this.end,
    this.subProjectId,
    this.subProjectName,
  });
}

// ---------------- UI Bits (unchanged except for navigate payload) ----------------
class _AccProjectCard extends StatelessWidget {
  final _AccProject p;
  final VoidCallback onRaisePa;
  const _AccProjectCard({required this.p, required this.onRaisePa});

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  p.customer,
                  style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              Text(
                p.code,
                style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Project', p.name, labelColor, valueColor),
                    _kv('Type', p.type, labelColor, valueColor),
                    _kv('Manager', p.manager, labelColor, valueColor),
                    _kv('BDM', p.bdm, labelColor, valueColor),
                    if ((p.subProjectName ?? '').isNotEmpty)
                      _kv('Sub-Project', p.subProjectName!, labelColor, valueColor),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Start', p.start, labelColor, valueColor),
                    _kv('End', p.end, labelColor, valueColor),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onPressed: onRaisePa,
                        child: const Text('Raise PA', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v, Color kColor, Color vColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$k: ',
          style: TextStyle(color: kColor, fontSize: 12),
          children: [TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12))],
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

class _CompactDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  const _CompactDropdown({
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          iconEnabledColor: cs.onSurfaceVariant,
          style: TextStyle(color: cs.onSurface, fontSize: 12),
          hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}





