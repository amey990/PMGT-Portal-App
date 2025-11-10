// import 'package:flutter/material.dart';
// import '../../../core/theme_controller.dart';
// import '../../../core/theme.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../../utils/responsive.dart';
// import '../profile/profile_screen.dart';
// import '../../widgets/app_drawer.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AccountsPaListScreen extends StatefulWidget {
//   const AccountsPaListScreen({super.key});

//   @override
//   State<AccountsPaListScreen> createState() => _AccountsPaListScreenState();
// }

// class _AccountsPaListScreenState extends State<AccountsPaListScreen> {
//   // int _tab = 0;

//   // Search + project filter
//   String _query = '';
//   String _selectedProject = 'All';

//   final List<String> _projectFilter = const [
//     'All',
//     'Airtel CEDGE NAC',
//     'TCL GSTN',
//     'NDSatcom SAMOFA',
//   ];

//   // Demo PA rows
//   final List<_PaRow> _rows = const [
//     _PaRow(
//       paNo: 'Airtel CEDGE NAC-PA-005',
//       project: 'Airtel CEDGE NAC',
//       paDate: '2025-09-16',
//       siteName: 'GARREPALLI',
//       siteCode: '101',
//       paStatus: 'Pending',
//       paymentStatus: 'Unpaid',
//     ),
//     _PaRow(
//       paNo: 'Airtel CEDGE NAC-PA-004',
//       project: 'Airtel CEDGE NAC',
//       paDate: '2025-07-15',
//       siteName: 'UPPUNUTHALA',
//       siteCode: '7123',
//       paStatus: 'Pending',
//       paymentStatus: 'Unpaid',
//     ),
//     _PaRow(
//       paNo: 'TCL GSTN-PA-001',
//       project: 'TCL GSTN',
//       paDate: '2025-07-11',
//       siteName: 'DILSUKHNAGAR',
//       siteCode: '151',
//       paStatus: 'Approved',
//       paymentStatus: 'Paid',
//     ),
//     _PaRow(
//       paNo: 'NDS SAMOFA-PA-003',
//       project: 'NDSatcom SAMOFA',
//       paDate: '2025-07-13',
//       siteName: 'DILSUKHNAGAR',
//       siteCode: '151',
//       paStatus: 'Pending',
//       paymentStatus: 'Unpaid',
//     ),
//   ];

//   void _handleTabChange(BuildContext context, int i) {
//   // This screen isn’t one of the 5 primary tabs, so we always navigate.
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();    break;
//     case 1: target = const AddProjectScreen();   break;
//     case 2: target = const AddActivityScreen();  break; // “Add” (center)
//     case 3: target = const AnalyticsScreen();    break;
//     case 4: target = const ViewUsersScreen();    break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }

//   List<_PaRow> get _filtered {
//     final q = _query.trim().toLowerCase();
//     return _rows.where((r) {
//       final okProject = _selectedProject == 'All' || r.project == _selectedProject;
//       final okSearch = q.isEmpty ||
//           r.paNo.toLowerCase().contains(q) ||
//           r.project.toLowerCase().contains(q) ||
//           r.siteName.toLowerCase().contains(q) ||
//           r.siteCode.toLowerCase().contains(q) ||
//           r.paStatus.toLowerCase().contains(q) ||
//           r.paymentStatus.toLowerCase().contains(q);
//       return okProject && okSearch;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       // title: 'Accounts – PA List',
//       // centerTitle: true,
//       // drawerMode: DrawerMode.accounts, // show Accounts drawer
//       // currentIndex: _tab,
//       // onTabChanged: (i) => setState(() => _tab = i),
//       // safeArea: false,
//       // reserveBottomPadding: true,
//       title: 'Accounts – PA List',
//   centerTitle: true,
//   drawerMode: DrawerMode.accounts,
//   currentIndex: 0,                              // Not a primary tab; use 0 (or 1) just to render the bar
//   onTabChanged: (i) => _handleTabChange(context, i),
//   safeArea: false,
//   reserveBottomPadding: true,
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
//           // icon: ClipOval(
//           //   child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           // ),
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // Search + Project dropdown in a single row
//           Row(
//             children: [
//               Expanded(child: _SearchField(onChanged: (v) => setState(() => _query = v))),
//               const SizedBox(width: 8),
//               SizedBox(
//                 width: 160,
//                 child: _CompactDropdown<String>(
//                   value: _selectedProject,
//                   items: _projectFilter,
//                   hint: 'Project',
//                   onChanged: (v) => setState(() => _selectedProject = v ?? 'All'),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // Cards
//           ..._filtered.map((r) => _PaCard(r: r)),

//           if (_filtered.isEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Center(
//                 child: Text('No PA found', style: TextStyle(color: cs.onSurfaceVariant)),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// /* ---------- Card ---------- */

// class _PaCard extends StatelessWidget {
//   final _PaRow r;
//   const _PaCard({required this.r});

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
//           // Header: PA No | PA Status
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   r.paNo,
//                   style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
//                 ),
//               ),
//               Text(
//                 r.paStatus,
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 10),

//           // Details (left-aligned column)
//           _kv('Project', r.project, labelColor, valueColor),
//           _kv('PA Date', r.paDate, labelColor, valueColor),
//           _kv('Site Name', r.siteName, labelColor, valueColor),
//           _kv('Site Code', r.siteCode, labelColor, valueColor),
//           _kv('Payment Status', r.paymentStatus, labelColor, valueColor),

//           const SizedBox(height: 12),

//           // Buttons row (aligned to the end)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               OutlinedButton.icon(
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: cs.outlineVariant),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 ),
//                 onPressed: () {
//                   // TODO: implement download logic
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Downloading PA…')),
//                   );
//                 },
//                 icon: const Icon(Icons.download),
//                 label: const Text('Download'),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 onPressed: () {
//                   // TODO: implement update route
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Open Update PA…')),
//                   );
//                 },
//                 child: const Text('Update', style: TextStyle(fontWeight: FontWeight.w700)),
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
//           children: [TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12))],
//         ),
//       ),
//     );
//   }
// }

// /* ---------- Small UI helpers (same compact style used elsewhere) ---------- */

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
//           hintText: 'Search…',
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

// /* ---------- Model ---------- */

// class _PaRow {
//   final String paNo;
//   final String project;
//   final String paDate;
//   final String siteName;
//   final String siteCode;
//   final String paStatus;
//   final String paymentStatus;

//   const _PaRow({
//     required this.paNo,
//     required this.project,
//     required this.paDate,
//     required this.siteName,
//     required this.siteCode,
//     required this.paStatus,
//     required this.paymentStatus,
//   });
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/theme_controller.dart';
import '../../../core/theme.dart';
import '../../widgets/layout/main_layout.dart';
import '../../utils/responsive.dart';
import '../profile/profile_screen.dart';
import '../../widgets/app_drawer.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

const String API_BASE = 'https://pmgt.commedialabs.com';

class AccountsPaListScreen extends StatefulWidget {
  const AccountsPaListScreen({super.key});

  @override
  State<AccountsPaListScreen> createState() => _AccountsPaListScreenState();
}

class _AccountsPaListScreenState extends State<AccountsPaListScreen> {
  // search + filter
  String _query = '';
  String _selectedProject = ''; // '' means All

  bool _loading = false;
  String? _error;
  List<_PaRecord> _rows = [];

  // pagination (client-side)
  int _rowsPerPage = 10;
  int _page = 0;

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
      final r = await http.get(Uri.parse('$API_BASE/api/payment_advices'));
      if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
      final data = jsonDecode(r.body);
      final list = <_PaRecord>[];
      if (data is List) {
        for (final e in data) {
          if (e is Map) list.add(_PaRecord.fromJson(e));
        }
      }
      setState(() {
        _rows = list;
        _page = 0; // reset on reload
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // Build project options from data
  List<String> get _projectOptions {
    final s = {..._rows.map((e) => e.project)};
    final list = s.toList()..sort();
    list.insert(0, 'All');
    return list;
  }

  List<_PaRecord> get _filtered {
    final q = _query.trim().toLowerCase();
    return _rows.where((r) {
      final okProject = _selectedProject.isEmpty || _selectedProject == 'All'
          ? true
          : r.project == _selectedProject;
      final okSearch = q.isEmpty ||
          [
            r.paNo,
            r.project,
            r.siteName,
            r.siteCode,
            r.paStatus,
            r.paymentStatus,
            r.paDateOnly
          ].join(' ').toLowerCase().contains(q);
      return okProject && okSearch;
    }).toList();
  }

  List<_PaRecord> get _paginated {
    final start = _page * _rowsPerPage;
    final end = (start + _rowsPerPage).clamp(0, _filtered.length);
    if (start >= _filtered.length) return const [];
    return _filtered.sublist(start, end);
  }

  int get _totalPages =>
      _filtered.isEmpty ? 1 : ((_filtered.length - 1) ~/ _rowsPerPage) + 1;

  Future<void> _download(String url) async {
    if (url.isEmpty) return;
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _export() async {
    await launchUrlString('$API_BASE/api/payment_advices/export',
        mode: LaunchMode.externalApplication);
  }

  void _openUpdate(_PaRecord r) async {
    final updated = await showModalBottomSheet<_PaRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _EditPaSheet(record: r),
    );
    if (updated != null) {
      if (updated.paStatus == 'DELETED') {
        _load(); // after delete, reload from server
      } else {
        setState(() {
          _rows = _rows.map((e) => e.id == updated.id ? updated : e).toList();
        });
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_page > _totalPages - 1) _page = _totalPages - 1; // keep in bounds

    return MainLayout(
      title: 'Accounts – PA List',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: 0,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
        IconButton(
          tooltip: Theme.of(context).brightness == Brightness.dark
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
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    'Failed to load PA list\n$_error',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cs.error),
                  ),
                )
              : ListView(
                  padding:
                      responsivePadding(context).copyWith(top: 12, bottom: 12),
                  children: [
                    // Search + Project + Export
                    Row(
                      children: [
                        Expanded(
                          child: _SearchField(onChanged: (v) => setState(() {
                                _query = v;
                                _page = 0;
                              })),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 160,
                          child: _CompactDropdown<String>(
                            value: _selectedProject.isEmpty
                                ? 'All'
                                : _selectedProject,
                            items: _projectOptions,
                            hint: 'Project',
                            onChanged: (v) => setState(() {
                              _selectedProject =
                                  (v == 'All') ? '' : (v ?? '');
                              _page = 0;
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _export,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Text('Export'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Cards
                    ..._paginated.map((r) => _PaCard(
                          r: r,
                          onDownload: () => _download(r.downloadURL),
                          onUpdate: () => _openUpdate(r),
                        )),

                    if (_paginated.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('No PA found',
                              style:
                                  TextStyle(color: cs.onSurfaceVariant)),
                        ),
                      ),

                    // Pagination
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Rows per page: ',
                            style: TextStyle(
                                color: cs.onSurfaceVariant, fontSize: 12)),
                        DropdownButton<int>(
                          value: _rowsPerPage,
                          items: const [
                            DropdownMenuItem(value: 10, child: Text('10')),
                            DropdownMenuItem(value: 20, child: Text('20')),
                            DropdownMenuItem(value: 50, child: Text('50')),
                          ],
                          onChanged: (v) =>
                              setState(() {
                                _rowsPerPage = v ?? 10;
                                _page = 0;
                              }),
                        ),
                        const Spacer(),
                        Text(
                          _filtered.isEmpty
                              ? '0–0 of 0'
                              : '${_page * _rowsPerPage + 1}–${_page * _rowsPerPage + _paginated.length} of ${_filtered.length}',
                          style: TextStyle(
                              color: cs.onSurfaceVariant, fontSize: 12),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed:
                              _page <= 0 ? null : () => setState(() => _page -= 1),
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text('Page ${_page + 1} of $_totalPages',
                            style: TextStyle(
                                color: cs.onSurfaceVariant, fontSize: 12)),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: _page >= _totalPages - 1
                              ? null
                              : () => setState(() => _page += 1),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}

/* ---------- Card ---------- */

class _PaCard extends StatelessWidget {
  final _PaRecord r;
  final VoidCallback onDownload;
  final VoidCallback onUpdate;
  const _PaCard(
      {required this.r, required this.onDownload, required this.onUpdate});

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
          // Header: PA No | PA Status
          Row(
            children: [
              Expanded(
                child: Text(
                  r.paNo,
                  style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
              Text(
                r.paStatus,
                style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 10),

          // Details
          _kv('Project', r.project, labelColor, valueColor),
          _kv('PA Date', r.paDateOnly, labelColor, valueColor),
          _kv('Site Name', r.siteName, labelColor, valueColor),
          _kv('Site Code', r.siteCode, labelColor, valueColor),
          _kv('Payment Status', r.paymentStatus, labelColor, valueColor),

          const SizedBox(height: 12),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.outlineVariant),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                ),
                onPressed: onDownload,
                icon: const Icon(Icons.download),
                label: const Text('Download'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onUpdate,
                child: const Text('Update',
                    style: TextStyle(fontWeight: FontWeight.w700)),
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
          children: [
            TextSpan(
                text: v, style: TextStyle(color: vColor, fontSize: 12))
          ],
        ),
      ),
    );
  }
}

/* ---------- Small UI helpers ---------- */

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
          hintText: 'Search…',
          hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          prefixIcon:
              Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          hint: Text(hint,
              style:
                  TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          items: items
              .map((e) =>
                  DropdownMenuItem<T>(value: e, child: Text('$e')))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/* ---------- Model ---------- */

class _PaRecord {
  final String id;
  final String paNo;
  final String project;
  final String paDate; // raw ISO
  final String siteName;
  final String siteCode;
  final String downloadURL;
  final String paStatus;
  final String paymentStatus;

  const _PaRecord({
    required this.id,
    required this.paNo,
    required this.project,
    required this.paDate,
    required this.siteName,
    required this.siteCode,
    required this.downloadURL,
    required this.paStatus,
    required this.paymentStatus,
  });

  String get paDateOnly => paDate.split('T').first;

  _PaRecord copyWith({String? paStatus, String? paymentStatus}) =>
      _PaRecord(
        id: id,
        paNo: paNo,
        project: project,
        paDate: paDate,
        siteName: siteName,
        siteCode: siteCode,
        downloadURL: downloadURL,
        paStatus: paStatus ?? this.paStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
      );

  factory _PaRecord.fromJson(Map json) => _PaRecord(
        id: (json['id'] ?? '').toString(),
        paNo: (json['pa_no'] ?? '').toString(),
        project: (json['project_name'] ?? '').toString(),
        paDate: (json['pa_date'] ?? '').toString(),
        siteName: (json['site_name'] ?? '').toString(),
        siteCode: (json['site_code'] ?? '').toString(),
        downloadURL: (json['downloadURL'] ?? '').toString(),
        paStatus: (json['pa_status'] ?? '').toString(),
        paymentStatus: (json['payment_status'] ?? '').toString(),
      );
}

/* ---------- Update bottom sheet ---------- */

class _EditPaSheet extends StatefulWidget {
  final _PaRecord record;
  const _EditPaSheet({required this.record});

  @override
  State<_EditPaSheet> createState() => _EditPaSheetState();
}

class _EditPaSheetState extends State<_EditPaSheet> {
  late String _paStatus;
  late String _paymentStatus;
  bool _saving = false;

  String _normPa(String s) {
    final v = s.trim().toUpperCase().replaceAll('_', ' ');
    const allowed = {'PENDING', 'APPROVED', 'NOT APPROVED', 'DISCARD'};
    return allowed.contains(v) ? v : 'PENDING';
  }

  String _normPay(String s) {
    final v = s.trim().toUpperCase().replaceAll('_', ' ');
    const allowed = {'UNPAID', 'PAID', 'DISCARD'};
    return allowed.contains(v) ? v : 'UNPAID';
  }

  @override
  void initState() {
    super.initState();
    _paStatus = _normPa(widget.record.paStatus);
    _paymentStatus = _normPay(widget.record.paymentStatus);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final r = await http.put(
        Uri.parse(
            '$API_BASE/api/payment_advices/${widget.record.id}/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'pa_status': _paStatus, 'payment_status': _paymentStatus}),
      );
      if (r.statusCode < 200 || r.statusCode >= 300) {
        throw Exception('HTTP ${r.statusCode}');
      }
      if (mounted) {
        Navigator.of(context).pop(widget.record
            .copyWith(paStatus: _paStatus, paymentStatus: _paymentStatus));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Update failed')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    setState(() => _saving = true);
    try {
      await http.delete(Uri.parse(
          '$API_BASE/api/payment_advices/${Uri.encodeComponent(widget.record.paNo)}'));
      if (mounted) {
        Navigator.of(context)
            .pop(widget.record.copyWith(paStatus: 'DELETED'));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Delete failed')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget ro(String label, String value) => TextField(
          readOnly: true,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: cs.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          style: TextStyle(color: cs.onSurface, fontSize: 13),
        );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Update PA',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 8),

            ro('PA No', widget.record.paNo),
            const SizedBox(height: 8),
            ro('Project', widget.record.project),
            const SizedBox(height: 8),
            ro('PA Date', widget.record.paDateOnly),
            const SizedBox(height: 8),
            ro('Site Name', widget.record.siteName),
            const SizedBox(height: 8),
            ro('Site Code', widget.record.siteCode),

            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _paStatus, // normalized
              items: const [
                DropdownMenuItem(value: 'PENDING', child: Text('PENDING')),
                DropdownMenuItem(value: 'APPROVED', child: Text('APPROVED')),
                DropdownMenuItem(
                    value: 'NOT APPROVED', child: Text('NOT APPROVED')),
                DropdownMenuItem(value: 'DISCARD', child: Text('DISCARD')),
              ],
              onChanged: (v) => setState(() => _paStatus = v ?? _paStatus),
              decoration: InputDecoration(
                labelText: 'PA Status',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _paymentStatus, // normalized
              items: const [
                DropdownMenuItem(value: 'UNPAID', child: Text('UNPAID')),
                DropdownMenuItem(value: 'PAID', child: Text('PAID')),
                DropdownMenuItem(value: 'DISCARD', child: Text('DISCARD')),
              ],
              onChanged: (v) =>
                  setState(() => _paymentStatus = v ?? _paymentStatus),
              decoration: InputDecoration(
                labelText: 'Payment Status',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),

            const SizedBox(height: 14),
            Row(
              children: [
                OutlinedButton(
                  onPressed: _saving ? null : _delete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('DELETE'),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel')),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: _saving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.success,
                    foregroundColor: Colors.black,
                  ),
                  child: _saving
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
